
import 'dart:collection';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_Garph_View.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_Garph_View_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field_Response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
Lab_GraphView_Field_Response res =new Lab_GraphView_Field_Response();
Lab_Garph_View_Response resGraphResult =new Lab_Garph_View_Response();
String selected="";
String typeChart="2";
String doctorId="", facilityId="",hospitalId="";
String patientName="", regIdShare="",regNoShare="";
HashMap<String,String> hashMap=new HashMap<String,String>();
int sharedValue = 0;
class ViewGraphModule extends StatefulWidget {
 final  String? fieldId;
 final  String? dateRange;
 final String? chatType;
   ViewGraphModule({
    Key? key,
    this.fieldId,
    this.dateRange,
    this.chatType,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState(fieldId: fieldId,dateRange: dateRange,chatType: chatType);
}

class _MyDropDownState extends State<ViewGraphModule> {

  String? fieldId;
  String? dateRange;
  String? chatType;
  _MyDropDownState({
    this.fieldId,
    this.dateRange,
    this.chatType,
  });

   @override
  void initState(){
    super.initState();
    getDataSharePre();
    getPatientDetails();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

  }
  @override
  void dispose(){
    // Additional disposal code
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape){
      return FutureBuilder<Lab_Garph_View_Response>(
        future: callApi(""), // function where you call your api
        builder: (BuildContext context, AsyncSnapshot<
            Lab_Garph_View_Response> data) { // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError)
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('Network issue',style: TextStyle(fontSize: 10),),
                  )
              );
            else {
              if(data.requireData!=null) {
                if (data.requireData.status!.toString().toLowerCase() == "success"){
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                  return layout(data.requireData, context);
                }else
                {
                  return new Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('No Record Found',style: TextStyle(fontSize: 10,color: Colors.grey),),
                      )
                  );
                }
              }else
              {
                return new Container(
                    color: Colors.white,
                    child: Center(
                      child: Text('No Record Found',style: TextStyle(fontSize: 10,color: Colors.grey),),
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


  Widget layout(Lab_Garph_View_Response fieldListData,BuildContext context)
  {
    return  new Scaffold(

      body: new Container(
        margin: EdgeInsets.only(top: 0),
        child:
              new Container(
                  margin: EdgeInsets.only(top: 0),
                  color: Colors.white,
                  child:new Stack(
                    children: [

                      //selectedchart(fieldListData),
                    ],
                  )


              ),

        ),


    );
  }

 /* Widget selectedchart(Lab_Garph_View_Response fieldListData)
  {
    if(CommonStrAndKey.selectedisBarLineChart=="0")
    {
      return new charts.BarChart(
        _createS(fieldListData!),
        animate: false,
        barRendererDecorator: new charts.BarLabelDecorator<String>(),
        domainAxis: new charts.OrdinalAxisSpec(),
      );
     }else
    {
      return  new charts.TimeSeriesChart(_createSampleDataLine(fieldListData), animate: false) ;
    }
  }*/

  /// Create one series with sample hard coded data.
/*
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData(Lab_Garph_View_Response dataObj) {
    OrdinalSales? field;
    var data=  <OrdinalSales?>(dataObj.resultGraphList!.length);
    for(int i=0;i<dataObj.resultGraphList!.length;i++)
    {
      var value=double.parse(dataObj.resultGraphList!.elementAt(i).fieldValue.toString());
      int intvalue=value.round();
      String str=dataObj.resultGraphList!.elementAt(i).entryDate.toString();
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
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(CompanyColors.appbar_color)),
          data: data!,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSales sales, _) =>
          '\$${sales.sales.toString()}')
    ];
  }

  static List<charts.Series<LinearSales, DateTime>> _createSampleDataLine(Lab_Garph_View_Response dataObj) {

    LinearSales field=null;
    var data=  new List<LinearSales>(dataObj.resultGraphList!.length);
    for(int i=0;i<dataObj.resultGraphList!.length;i++)
    {
      var value=double.parse(dataObj.resultGraphList!.elementAt(i).fieldValue.toString());
      int intvalue=value.round();
      String str=dataObj.resultGraphList!.elementAt(i).entryDate.toString().trim();

      DateTime dateTime1 = DateFormat('d/M/yyyy').parse(str);
      String subStr=str.substring(0,2);
      var firstV=double.parse(subStr);
      field= new LinearSales(dateTime1, value) ;

      print("$firstV  $value");
      data[i]=field;
    }
    */
/*final data = [
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
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(CompanyColors.appbar_color)),
        domainFn: (LinearSales saless, _) => saless.year,
        measureFn: (LinearSales saless, _) => saless.sales,
        data: data,
        labelAccessorFn: (LinearSales sales, _) =>
        '${sales.sales}',

      )
    ];

*/
/*
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

  static List<charts.Series<OrdinalSalesMy, String>> _createS(Lab_Garph_View_Response dataObj) {
    OrdinalSalesMy field=null;
    var data=  new List<OrdinalSalesMy>(dataObj.resultGraphList!.length);
    for(int i=0;i<dataObj.resultGraphList!.length;i++)
    {
      var value=double.parse(dataObj.resultGraphList!.elementAt(i).fieldValue.toString());
      int intvalue=value.round();
      String str=dataObj.resultGraphList!.elementAt(i).entryDate.toString();
      DateTime dateTime1 = DateFormat('d/M/yyyy').parse(str);
      String subStr=str.substring(0,5);
      field= new OrdinalSalesMy(subStr, value) ;
      data[i]=field;
    }


    return [
      new charts.Series<OrdinalSalesMy, String>(
          id: 'Sales',
          domainFn: (OrdinalSalesMy sales, _) => sales.year,
          measureFn: (OrdinalSalesMy sales, _) => sales.sales,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Color(CompanyColors.appbar_color)),
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (OrdinalSalesMy sales, _) =>
          '${sales.sales.toString()}')
    ];
  }
*/


  Future<Lab_Garph_View_Response>  callApi(String regIdStr)  async {

      String url = BasicUrl.sendUrlGraph();
      final myService = MyServicePost.create(url);
      Lab_Garph_View req = new Lab_Garph_View();
      req.hospitalLocationId = "" +hospitalId;
      req.registrationId = ""+regIdShare;
      req.fieldId=""+CommonStrAndKey.selectedPatient;
      req.dateRange=""+ CommonStrAndKey.selectedGraphDisplayTime;
      req.fromDate = "";
      req.toDate = "";
      print("Request \n" + req.toJson().toString());
      Lab_Garph_View objj = new Lab_Garph_View.fromJson(req.toJson());
      Response<Lab_Garph_View_Response> responserrr = (await myService
          .LabResultGraph(objj));
      var postt = responserrr.body;
      print(responserrr.body);
      resGraphResult = new Lab_Garph_View_Response.fromJson(postt!.toJson());
      return Future.value(resGraphResult);

  }
  Widget Loading(BuildContext forThis){

    return new Container(
        color: Colors.white,
        child:SpinKitCubeGrid(size: 71.0, color:Color(CompanyColors.appbar_color)
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
