
import 'dart:collection';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Graph_Vital/CustomDropDownFieldId.dart';
import 'package:flutter_patient_app/Graph_Vital/ViewGraphModule.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Request.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'CustomDropDownDisplayTime.dart';
String selected="";

 List<CommonDropDownForFilter> listNameIdData=<CommonDropDownForFilter>[];
List<CommonDropDown> listFieldData=<CommonDropDown>[];

String doctorId="", facilityId="",hospitalId="";
String patientName="", regIdShare="",regNoShare="";
List<String> shortItems =  ['DD0','WW-1', 'MM-1','MM-3','MM-6','YY-1'];
//List<String> shortItems =  ['DD 0','WW 1', 'MM 1','MM 3','MM 6','YY 1'];
List<String> timesItems =  ['Day','Week', 'Month','3 Month','6 month','Year'];
HashMap<String,String> hashMap=new HashMap<String,String>();

class Sub_View_Vertical_bar_label extends StatefulWidget {

 final String? patientName;
 final String? regId;
 final List<CommonVitalsDropDown>? dataForFilter;
 final List<VitalSignNameList>? fieldData;
  const Sub_View_Vertical_bar_label({
    Key? key,
    this.patientName,
    this.regId,
    this.dataForFilter,
    this.fieldData,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState(
      patientName: patientName,regId: regId,
      dataForFilter: dataForFilter,fieldData: fieldData);
}

class _MyDropDownState extends State<Sub_View_Vertical_bar_label> {
 static CommonVitalsDropDown selectedMonth= new CommonVitalsDropDown("","") ;
 static CommonDropDown selectedFieId= new CommonDropDown("","") ;
 static String typeChart="2";

  String? patientName;
  String? regId="";
  List<CommonVitalsDropDown>? dataForFilter;
  List<VitalSignNameList>? fieldData;
  _MyDropDownState({


    this.patientName,
    this.regId,
    this.fieldData,
    this.dataForFilter,
  });
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Bar'),
    1: Text('Line'),
    /*2: Text('Logo 3'),*/
  };
  int sharedValue = 0;
 refresh() {
     setState(() {});
   }

  @override
  void initState(){
    super.initState();
    // Additional initialization of the State
    setDropDown(fieldData!);
    getDataSharePre();
    getPatientDetails();
    _MyDropDownState.selectedFieId.titleId=CommonStrAndKey.selectedPatient;
    _MyDropDownState.selectedMonth.titleId=shortItems.elementAt(5).toString();
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    if (MediaQuery.of(context).orientation == Orientation.landscape) {

      return layout(context);
    } else {
      return new Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'No Record Found',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ));
    }
   /* if (MediaQuery.of(context).orientation == Orientation.landscape){
      return layout( context);

    }else{
      return new Container(
        color: Colors.white,
        child: new Center(
          child:new Text("Loading.....",style: TextStyle(color:Colors.black,fontSize: 12,),) ,
        )
      );
    }*/



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
                CommonStrAndKey.selectedisBarLineChart="0";
              } else {
                typeChart = "1";
                CommonStrAndKey.selectedisBarLineChart="1";
              }
            });
          },
          groupValue: sharedValue,
        ),
      ),


    );
  }

  Widget layout(BuildContext context)
  {
    return  new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Vital Graph View ',style: TextStyle(fontSize: 16.0),),
        backgroundColor: Color(CompanyColors.appbar_color),
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
                      color: Color(CompanyColors.appbar_color),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),),
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  padding:EdgeInsets.all(5) ,
                  child:  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 45,
                          child:new Container(

                            child:  Text(""+patientName!.toString(),
                            style: TextStyle(color:Color(CompanyColors.appbar_color),fontWeight: FontWeight.bold), ),
                          )


                      ),
                      Expanded(
                        flex: 15,
                        child:new Container(

                          decoration: BoxDecoration(
                            border: Border.all(
                              color:Color(CompanyColors.appbar_color),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),),
                          child: CustomDropDownFieldId(
                            dropDownData: listFieldData,
                            notifyParent: refresh,
                          ),
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
                                color: Color(CompanyColors.appbar_color),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(4),),
                            child: new Center(
                              child:CustomDropDownDisplayTime(
                                dropDownData: listNameIdData,
                                notifyParent: refresh,
                              ),
                              //timeFilterDropDownString(),
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
                margin: EdgeInsets.only(top: 20),
                color: Colors.white,
                child:new Stack(
                  children: [
                 /*   Align(
                      alignment: Alignment.topRight,
                      child: new Container(
                        width: 250,
                        //height: 60,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Row(
                          children: [
                            new Text("Unit "+fieldListData.resultGraphList.elementAt(0).unitName,style: TextStyle(fontSize: 12),),
                            new Container(
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child:  new Text("Range "
                                +fieldListData.resultGraphList.elementAt(0).minValue.toString()+" - "+
                                  fieldListData.resultGraphList.elementAt(0).maxValue.toString(),
                                style: TextStyle(fontSize: 12),),
                            )

                          ],
                        ),
                      ),
                    ),*/
                  //  selectedchart(fieldListData),
                    ViewGraphModule(chatType:  _MyDropDownState.typeChart.toString(),
                        dateRange: _MyDropDownState.selectedMonth.titleId.toString(),
                        fieldId: CommonStrAndKey.selectedPatient),
                  ],
                )
              ),
            ),
            Expanded(
              flex:0,
              child: new Center(
                child: Text("YEAR 2020"),
              ),
            )
          ],
        ),
      ),



    );
  }



}

Future<Vital_Graph_Sign_Response> callVitalsSignApi(BuildContext context, String hospitalId) async {
  // _onLoading();
  String url = BasicUrl.sendUrlGraph();
  final myService = MyServicePost.create(url);
  Vital_Graph_Sign_Request setObj = new Vital_Graph_Sign_Request();
  setObj.hospitalLocationId = "" + hospitalId.toString();
  Vital_Graph_Sign_Request obj =new Vital_Graph_Sign_Request.fromJson(setObj.toJson());
  Response<Vital_Graph_Sign_Response> response =(await myService.GetVitalSignName(obj));
  print('santi val ${response.body}');
  var post = response.body;
  // if (post != null) {
  Vital_Graph_Sign_Response res = new Vital_Graph_Sign_Response.fromJson(post!.toJson());
  return Future.value(res);
  // }
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
   _MyDropDownState.selectedMonth.titleId=shortItems.elementAt(0);
   _MyDropDownState.selectedMonth.title=timesItems.elementAt(0);
   CommonStrAndKey.selectedGraphDisplayTime=listNameIdData.elementAt(3).titleId;
   if(labDropDownList.length!=0) {

     for (int i = 0; i < labDropDownList.length; i++) {
       VitalSignNameList obj = labDropDownList.elementAt(i);

         CommonDropDown datahh = new CommonDropDown(
             obj.displayName.toString().trim(), obj.vitalId.toString().trim());
         listFieldData.add(datahh);

     }
     _MyDropDownState.selectedFieId = listFieldData.elementAt(0);
    // Lab_Details_Card__List.fieldMyValue= listFieldData.elementAt(0).titleId.toString();
      CommonStrAndKey.selectedPatient= listFieldData.elementAt(0).titleId.toString();
   }
 }
Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

class CommonDropDown {
  String title;
  String titleId;

  CommonDropDown(this.title, this.titleId);
}

class CommonDropDownForFilter {
  String title;
  String titleId;

  CommonDropDownForFilter(this.title, this.titleId);
}

class OrdinalSalesMy {
  final String year;
  final double sales;

  OrdinalSalesMy(this.year, this.sales);
}
void getDataSharePre()
{

  doctorId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_id) ?? '';
  facilityId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id_first) ?? '';
  hospitalId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
  String ddd=doctorId;

}
void getPatientDetails()
{

  patientName=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ?? '';
  regIdShare=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
  regNoShare=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ?? '';
  String ddd=doctorId;

}
