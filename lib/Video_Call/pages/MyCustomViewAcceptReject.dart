import 'dart:async';
import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallResponse.dart';
import 'package:flutter_patient_app/Video_Call/pages/CanferenceCall.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploadeddoc_response.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/settings.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:flutter_svg/flutter_svg.dart';
String? myRegistrationId,myDoctorId,myFacilityId,myHospitalId,myEncounterId;
class MyCustomViewAcceptReject extends StatefulWidget {
  /// non-modifiable channel name of the page

 // final AppointmentListJSon AppointmentDetails;
  final String? channelName;
  final String? MyAppointmentId;
  final String? MyDoctorId;
  final String? MyPatientName;
  final String? MyDoctorName;
  final String? MyNotificationType;
  final  String? MyEntingType;
  /// Creates a call page with given channel name.
  const MyCustomViewAcceptReject({Key? key,
    this.channelName,
    this.MyDoctorId,
    this.MyPatientName,
    this.MyDoctorName,
    this.MyAppointmentId,
    this.MyNotificationType,
    this.MyEntingType
  }) : super(key: key);

  @override
  _MyCallPageState createState() => _MyCallPageState(
    channelName: channelName,
      MyAppointmentId: MyAppointmentId,
      MyDoctorId: MyDoctorId,
    MyPatientName: MyPatientName,
    MyDoctorName: MyDoctorName,
      MyNotificationType: MyNotificationType,
      MyEntingType: MyEntingType
  );



}

class _MyCallPageState extends State<MyCustomViewAcceptReject> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
 // AppointmentListJSon AppointmentDetails;
  String? channelName;
  String? MyAppointmentId;
  String? MyDoctorId;
  String? MyPatientName;
  String? MyDoctorName;
  String? MyNotificationType;
  String? MyEntingType;
  _MyCallPageState(
  {
     this.channelName,
     this.MyAppointmentId,
    this.MyPatientName,
    this.MyDoctorName,
     this.MyDoctorId,
     this.MyNotificationType,
    this.MyEntingType
   }
   );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    myRegistrationId="";
    myDoctorId="";
    myFacilityId="";
    myHospitalId="";
    myEncounterId="";
    getPatientDetails();

  }
  void permissionHandling() async {
    await _handleCameraAndMic();
  }

  Future<void> _handleCameraAndMic() async {
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  Widget build(BuildContext context) {

    return Layout(context);

  }

  Widget noDataFound(BuildContext context) {
  /*  new Future.delayed(new Duration(seconds: 1), () {
      //Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
      Navigator.of(context).pop();
    });*/
    return new Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Try Again',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ));
  }
  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
  }
  Widget Layout(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
      ),
      backgroundColor: Colors.white,
      body:ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 300,
            maxWidth: MediaQuery.of(context).size.width,

          ),
          child: Center(
            /*children: <Widget>[_videoView(views[0])],*/


            child:   Column(

              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20,100,20,20),
                  color: Colors.white,
                  child: new SvgPicture.asset("assets/New_Icons/patient-call.svg",
                    height: 200,
                    width: 200,
                    fit:BoxFit.fill,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Center(
                    child: Text("Doctor Name : "+MyDoctorName.toString()+
                        "\nPatient Name :"+MyPatientName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),),
                ),
                Text(
                  "Please wait,    \nyou are connecting...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(20, 60, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     new GestureDetector(
                       child: Container(

                         child:
                         new SvgPicture.asset("assets/New_Icons/call_icon_decline.svg",
                           height: 60,
                           width: 60,
                           fit:BoxFit.fill,
                         ),
                       ),
                       onTap: () {

                         if(MyEntingType.toString().toLowerCase().trim()=="true")
                           {
                             Navigator.pop(context);
                           }else
                             {
                               exit(0);
                             }
                       //

                       },
                     ),
                     new SizedBox(
                       width: 120,
                     ),
                     new GestureDetector(
                     child: Container(
                        child:
                        new SvgPicture.asset("assets/New_Icons/call_icon_accept.svg",
                          height: 60,
                          width: 60,
                          fit:BoxFit.fill,
                        ),
                      ),
                     onTap: () {
                       if(MyNotificationType.toString().toLowerCase().trim()=="videocall") {
                         Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                               builder: (context) =>
                                   CallPage(
                                     //  AppointmentDetails:AppointmentDetails ,
                                     MyAppointmentId: MyAppointmentId,
                                     MyDoctorId: MyDoctorId,
                                     MyDoctorName: MyDoctorName,
                                     MyPatientName: MyPatientName,
                                     channelName: channelName.toString().trim(),
                                     MyNotificationType: MyNotificationType,
                                     MyEntingType: MyEntingType,
                                   ),
                             ));
                       }else if(MyNotificationType.toString().toLowerCase().trim()=="conference") {
                         Navigator.of(context).pushReplacement(
                             MaterialPageRoute(
                               builder: (context) =>
                                   CanferenceCall(
                                     //  AppointmentDetails:AppointmentDetails ,
                                     MyAppointmentId: MyAppointmentId,
                                     MyDoctorId: MyDoctorId,
                                     MyDoctorName: MyDoctorName,
                                     MyPatientName: MyPatientName,
                                     channelName: channelName.toString().trim(),
                                     MyNotificationType: MyNotificationType,
                                     MyEntingType: MyEntingType,
                                   ),
                             ));
                       }
                     },
                     ),
                    ],
                  ),
                )

              ],
            ),
          )),

    );
  }


  void getPatientDetails()
  {

     myRegistrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
  //   myDoctorId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_id) ?? '';

     myFacilityId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ?? '';

     myHospitalId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';

     myEncounterId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_id) ?? '';


  }

}
