
import 'dart:collection';
/// Vertical bar chart with bar label renderer example.
// EXCLUDE_FROM_GALLERY_DOCS_START
import 'dart:math';
// EXCLUDE_FROM_GALLERY_DOCS_END
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Request.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
Lab_GraphView_Field_Response res =new Lab_GraphView_Field_Response();
Vital_Graph_Response resGraphResult =new Vital_Graph_Response();
String selected="";
CommonVitalsDropDown selectedMonth= new CommonVitalsDropDown("","") ;
CommonDropDown selectedFieId= new CommonDropDown("","") ;
 List<CommonDropDownForFilter> listNameIdData=<CommonDropDownForFilter>[];
List<CommonDropDown> listFieldData=<CommonDropDown>[];
const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);
String typeChart="2";
String doctorId="", facilityId="",hospitalId="";
String patientName="", regIdShare="",regNoShare="";
List<String> shortItems =  ['DD0','WW-1', 'MM-1','MM-3','MM-6','YY-1'];
//List<String> shortItems =  ['DD 0','WW 1', 'MM 1','MM 3','MM 6','YY 1'];
List<String> timesItems =  ['Day','Week', 'Month','3 Month','6 month','Year'];
HashMap<String,String> hashMap=new HashMap<String,String>();
class vertical_bar_label_vitals extends StatefulWidget {
 final DoctorLabDetails? LabDetails;
 final List<VitalSignNameList>? forLabDataList;
 final String? patientName;
 final String? regId;
 final List<CommonVitalsDropDown>? dataForFilter;
  const vertical_bar_label_vitals({
    Key? key,
    this.LabDetails,
    this.patientName,
    this.regId,
    this.forLabDataList,
    this.dataForFilter,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState(LabDetails: LabDetails,patientName: patientName,regId: regId,
      forLabDataList: forLabDataList,dataForFilter: dataForFilter);
}

class _MyDropDownState extends State<vertical_bar_label_vitals> {
  List<VitalSignNameList>? forLabDataList;
  DoctorLabDetails? LabDetails;
  String? patientName;
  String? regId="";
  List<CommonVitalsDropDown>? dataForFilter;
  _MyDropDownState({

    this.LabDetails,
    this.patientName,
    this.regId,
    this.forLabDataList,
    this.dataForFilter,
  });
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Bar'),
    1: Text('Line'),
    /*2: Text('Logo 3'),*/
  };
  int sharedValue = 0;







  @override
  void initState(){
    super.initState();
    // Additional initialization of the State
    setDropDown(forLabDataList!);
    getPatientDetails();
    selectedFieId.titleId=forLabDataList!.elementAt(5).vitalId.toString();
    selectedMonth.titleId=shortItems.elementAt(5).toString();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

  }
  @override
  void dispose(){
    // Additional disposal code
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp ,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape){
      return FutureBuilder<Vital_Graph_Response>(
        future: callApi(""), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<
            Vital_Graph_Response> data) { // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError)
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Error: ${data.error}'),
                  )
              );
            else {
              if(data.requireData!=null) {
                return layout(data.requireData, context);
              }else
              {
                return new Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                    )
                );
              }
            }
          }
        },
      );

    }else{
      return new Container(
        color: Colors.white,
        child: new Center(
          child:new Text("Loading.....",style: TextStyle(color:Colors.black,fontSize: 12,),) ,
        )
      );
    }



  }
  Widget customRadioButton()
  {
    return new Container(
      child:
      SizedBox(
        width: 80.0,
        height: 33,
        child: CupertinoSegmentedControl<int>(
          children: logoWidgets,
          onValueChanged: (int val) {
            setState(() {
              sharedValue = val;
              if (val == 0) {
                typeChart = "0";
              } else {
                typeChart = "1";
              }
            });
          },
          groupValue: sharedValue,
        ),
      ),


    );
  }

  Widget layout(Vital_Graph_Response fieldListData,BuildContext context)
  {


    return  new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vital Graph View ',style: TextStyle(fontSize: 16.0),),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF17ead9),
                    Color(0xFF6078ea)
                  ]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: new Container(
        margin: EdgeInsets.only(top: 0),
        child:  new Column(
          children: <Widget>[

            Expanded(
                flex: 20,

                child:new Container(
                  height: 35,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xff6a6fde),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),),
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding:EdgeInsets.all(5) ,
                  child:  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 30,
                          child:new Container(

                            child:  Text(""+patientName.toString(),
                            style: TextStyle(color:Color(0xff6a6fde),fontWeight: FontWeight.bold), ),
                          )


                      ),
                      Expanded(
                        flex: 30,
                        child:new Container(

                          decoration: BoxDecoration(
                            border: Border.all(
                              color:Color(0xff6a6fde),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),),
                          child: fieldTypeDropDown(forLabDataList!),
                        ),



                      ),
                      Expanded(
                        flex: 20,
                        child:new Container(
                          height: 34,
                          child: customRadioButton(),
                        ),

                      ),
                      Expanded(
                        flex: 20,
                        child:new Container(

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xff6a6fde),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),),
                            child: new Center(
                              child:timeFilterDropDownString(),
                            )

                        ),

                      ),
                    ],
                  ),
                )


            ),
            Expanded(
              flex:80,
              child: new Container(
                margin: EdgeInsets.only(top: 30),
                color: Colors.white,
               // child:selectedchart(fieldListData),
              ),
            ),
            Expanded(
              flex:0,
              child: new Center(
                child: Text("data"),
              ),
            )
          ],
        ),
      ),



    );
  }

 /* Widget selectedchart(Vital_Graph_Response fieldListData)
  {
    if(sharedValue==0)
      {
        return new charts.TimeSeriesChart(_createSampleData(fieldListData), animate: false
        ,  defaultRenderer: new charts.BarRendererConfig<DateTime>(),defaultInteractions: false,
          behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],) ;
      }else
        {
          return  new charts.TimeSeriesChart(_createSampleDataLine(fieldListData), animate: false) ;
       }
  }*/


  Widget? timeFilterDropDownString()
  {
    try {
      bool flg = false;
      if (timesItems.length > 0) {
        return new Center(

          child: new DropdownButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 25,
            underline: SizedBox(),
            items: timesItems
                .map((label) =>
                DropdownMenuItem<String>(

                  child: Text(label,
                    style: TextStyle(color: Color(0xff6a6fde), fontSize:
                    10, fontWeight: FontWeight.bold),),
                  value: label,
                ))
                .toList(),
            onChanged: (String? _value) {
              setState(() {
                selectedMonth.title = _value!.toString();

               selectedMonth.titleId = hashMap[_value].toString();
              });
            },
            value: selectedMonth.title,


          ),
        );
      } else {
        return new Center(
          child: Text(""),
        );
      }
    }on Exception catch (_) {
      print('never reached');
    }
  }
Widget? timeFilterDropDown()
{
  try {
    bool flg = false;
    if (listNameIdData.length > 0) {
      return new Center(

        child: new DropdownButton<CommonVitalsDropDown>(
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 25,
          underline: SizedBox(),
          items: dataForFilter!
              .map((label) =>
              DropdownMenuItem<CommonVitalsDropDown>(

                child: Text(label.title,
                  style: TextStyle(color: Color(0xff6a6fde), fontSize:
                  10, fontWeight: FontWeight.bold),),
                value: label,
              ))
              .toList(),
          onChanged: (CommonVitalsDropDown? _value) {
            setState(() {
              selectedMonth.title = _value!.title;
              //selectedMonth.titleId = _value!.titleId;
              /*if(_value.titleId=="DD 0")
                {
                  selectedMonth.titleId="DD0";
                }else {
                selectedMonth.titleId = _value.titleId.replaceAll(" ", "-");
              }*/
            });
          },
          value: selectedMonth,


        ),
      );
    } else {
      return new Center(
        child: Text(""),
      );
    }
  }on Exception catch (_) {
    print('never reached');
  }
}


  Widget fieldTypeDropDown(List<VitalSignNameList> dataField)
  {
    bool flg=false;
    if(dataField.length>0)
      {
       flg=true;

      }else{
      flg=false;
    }
    return new Visibility(
      visible: flg,
      child: new Center(

      child: new DropdownButton<CommonDropDown>(
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 25,
        underline: SizedBox(),
        items: listFieldData
            .map((label) => DropdownMenuItem<CommonDropDown>(

          child: Text(label.title.toString(), style: TextStyle(color: Color(0xff6a6fde),fontSize:
          10,fontWeight: FontWeight.bold),),
          value: label,
        ))
            .toList(),
        onChanged: (CommonDropDown? _value) {
          setState(() {
            selectedFieId.title=_value!.title;
            //selectedFieId.titleId=_value!.titleId.toString();
          });
        },
        value: selectedFieId,

      ),
    ),);
  }


  /// Create one series with sample hard coded data.
 /* static List<charts.Series<OrdinalSales, DateTime>> _createSampleData(Vital_Graph_Response dataObj) {
    OrdinalSales field=null;
    var data=  new List<OrdinalSales>(dataObj.vitalGraphList!.length);
    for(int i=0;i<dataObj.vitalGraphList!.length;i++)
      {
        var value=double.parse(dataObj.vitalGraphList!.elementAt(i).vitalValue.toString());
        int intvalue=value.round();
        String str=dataObj.vitalGraphList!.elementAt(i).vitalEntryDate.toString();
        DateTime dateTime1 = DateFormat('d/M/yyyy').parse(str);
         String subStr=str.substring(0,2);
        field= new OrdinalSales(dateTime1, value) ;
        data[i]=field;
      }


    return [
      new charts.Series<OrdinalSales, DateTime>(
          id: 'Sales',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff6a6fde)),
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
              '\$${sales.sales.toString()}')
    ];
  }


  static List<charts.Series<LinearSales, DateTime>> _createSampleDataLine(Vital_Graph_Response dataObj) {

    LinearSales field=null;
    var data=  new List<LinearSales>(dataObj.vitalGraphList!.length);
    for(int i=0;i<dataObj.vitalGraphList!.length;i++)
    {
      var value=double.parse(dataObj.vitalGraphList!.elementAt(i).vitalValue.toString());
      int intvalue=value.round();
      String str=dataObj.vitalGraphList!.elementAt(i).vitalEntryDate.toString().trim();

      DateTime dateTime1 = DateFormat('d/M/yyyy').parse(str);
      String subStr=str.substring(0,2);
      var firstV=double.parse(subStr);
      field= new LinearSales(dateTime1, value) ;

      print("$firstV  $value");
      data[i]=field;
    }
    *//*final data = [
      new LinearSales(3, 5),
      new LinearSales(4, 25),
      new LinearSales(5, 100),
      new LinearSales(6, 75),
      new LinearSales(7, 5),
      new LinearSales(8, 25),
      new LinearSales(9, 100),

    ];*//*

    return [
      new charts.Series<LinearSales, DateTime>(
        id: 'Saless',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff6a6fde)),
        domainFn: (LinearSales saless, _) => saless.year,
        measureFn: (LinearSales saless, _) => saless.sales,
        data: data,
        labelAccessorFn: (LinearSales sales, _) =>
        '${sales.sales}',

      )
    ];

*//*
    return List<charts.Series<LinearSales, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (LinearSales series, _) => series.year,
          measureFn: (LinearSales series, _) => series.sales,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(0xff6a6fde)),
    ];
*//*

  }
*/

  Future<Vital_Graph_Response>  callApi(String regIdStr)  async {
   
      String url = BasicUrl.sendUrlGraph();
      final myService = MyServicePost.create(url);
      Vital_Graph_Request req = new Vital_Graph_Request();
      req.hospitalLocationId = "" +hospitalId;
      req.registrationId = ""+regIdShare;
      req.dateRange="YY-1";/*+selectedMonth.titleId;*/
      req.fromDate = "";
      req.toDate = "";
      req.facilityId="3";
      List<XmlVitalId> xmlVitalIdData=<XmlVitalId>[];
      XmlVitalId obj=new XmlVitalId();
      obj.vitalId=""+selectedFieId.titleId.toString();
      xmlVitalIdData.add(obj);
      req.xmlVitalId=xmlVitalIdData;

      Vital_Graph_Request objj = new Vital_Graph_Request.fromJson(req.toJson());
      Response<Vital_Graph_Response> responserrr = (await myService
          .VitalGraph(objj));
      var postt = responserrr.body;
      print(responserrr.body);
      resGraphResult = new Vital_Graph_Response.fromJson(postt!.toJson());
      return Future.value(resGraphResult);
  
  }
  Widget Loading(BuildContext forThis){

    return new Container(
        color: Colors.white,
        child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
        ));
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final DateTime year;
  final double sales;

  OrdinalSales(this.year, this.sales);
}




/// Sample linear data type.
class LinearSales {
  final DateTime year;
  final double sales;

  LinearSales(
  this.year,
      this.sales);
}

 void setDropDown(List<VitalSignNameList> labDropDownList)
 {
   listFieldData.clear();
   listNameIdData.clear();
   for(int i=0;i<shortItems.length;i++)
     {
       CommonDropDownForFilter timep = new CommonDropDownForFilter(
            timesItems.elementAt(i),shortItems.elementAt(i));
       listNameIdData.add(timep);
       hashMap.putIfAbsent(timesItems.elementAt(i), () => shortItems.elementAt(i));
     }
   selectedMonth.titleId=shortItems.elementAt(5);
   selectedMonth.title=timesItems.elementAt(5);

   if(labDropDownList.length!=0) {
     for (int i = 0; i < labDropDownList.length; i++) {
       VitalSignNameList obj = labDropDownList.elementAt(i);


         CommonDropDown datahh = new CommonDropDown(
             obj.displayName.toString(), obj.vitalId.toString());
         listFieldData.add(datahh);

     }
     selectedFieId = listFieldData.elementAt(0);
   }
 }

class CommonDropDown {
  String? title;
  String? titleId;

  CommonDropDown(this.title, this.titleId);
}

class CommonDropDownForFilter {
  String? title;
  String? titleId;

  CommonDropDownForFilter(this.title, this.titleId);
}

void getPatientDetails()async
{
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  facilityId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ?? '';
  hospitalId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
  patientName=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ?? '';
  regIdShare=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
  regNoShare=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ?? '';
  String ddd=doctorId;

}
