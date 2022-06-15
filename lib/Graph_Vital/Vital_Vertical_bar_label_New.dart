
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
import 'package:flutter_patient_app/Graph_Vital/Sub_View_Vertical_bar_label.dart';
import 'package:flutter_patient_app/Graph_Vital/ViewGraphModule.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
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

class Vital_Vertical_bar_label_New extends StatefulWidget {

 final String? patientName;
 final String? regId;

 final List<CommonVitalsDropDown>? dataForFilter;
  const Vital_Vertical_bar_label_New({
    Key? key,
    this.patientName,
    this.regId,
    this.dataForFilter,
  }) : super(key: key);

  @override
  _MyDropDownState createState() => _MyDropDownState(
      patientName: patientName,regId: regId,dataForFilter: dataForFilter);
}

class _MyDropDownState extends State<Vital_Vertical_bar_label_New> {
 static CommonVitalsDropDown selectedMonth= new CommonVitalsDropDown("","") ;
 static CommonDropDown selectedFieId= new CommonDropDown("","") ;
 static String typeChart="2";

  String? patientName;
  String? regId="";
  List<CommonVitalsDropDown>? dataForFilter;
  _MyDropDownState({


    this.patientName,
    this.regId,

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
      return FutureBuilder<Vital_Graph_Sign_Response>(
        future: callVitalsSignApi(context,"1"),// function where you call your api
        builder:(BuildContext context, AsyncSnapshot<Vital_Graph_Sign_Response> data) {

          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError)
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                  ));
            else {


              return layout(context,data.requireData.vitalSignNameList!,dataForFilter!);
            }
          }
        },
      );
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

  }

 Widget layout(BuildContext context,List<VitalSignNameList> mydata,List<CommonVitalsDropDown> myDataTime)
 {
   return  new Scaffold(

     body: new Container(
       margin: EdgeInsets.only(top: 0),
       child: Sub_View_Vertical_bar_label
         (
         regId:regIdShare ,
         patientName:patientName ,
         fieldData:mydata ,
         dataForFilter: myDataTime,
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


Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
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
