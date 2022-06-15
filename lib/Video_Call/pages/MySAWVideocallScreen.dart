import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Product.dart';
import 'package:flutter_patient_app/SQLiteDbProvider.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallResponse.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploadeddoc_response.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/settings.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:flutter_svg/flutter_svg.dart';
String? myRegistrationId,myDoctorId,myFacilityId,myHospitalId,myEncounterId;
class MySAWVideocallScreen extends StatefulWidget {
  /// non-modifiable channel name of the page


  /// Creates a call page with given channel name.
  const MySAWVideocallScreen({Key? key,

  }) : super(key: key);

  @override
  _MyCallPageState createState() => _MyCallPageState(
  );



}

class _MyCallPageState extends State<MySAWVideocallScreen> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;

  _MyCallPageState();

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
   // getPatientDetails();

  }
  void permissionHandling() async {
    await _handleCameraAndMic();
  }

  Future<void> _handleCameraAndMic() async {
    await [Permission.microphone, Permission.camera].request();
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Product>(
      future: SQLiteDbProvider.db.getProductById(1), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Product> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return noDataFound(context);
          else if (data.requireData == null) {
            return noDataFound(context);
          } else {
            if (data.requireData.id!=0) {

              print("#@#@#@#@#@#@#@#@#@#@#@#@#@#"+data.requireData.doctorName.toString());
              return Layout(data.requireData);
            }else{
              return noDataFound(context);

            }
          }
        }
      },
    );

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
  Widget Layout(Product data)
  {
    return Scaffold(

      backgroundColor: Colors.white,
      body: CallPage(
            //  AppointmentDetails:AppointmentDetails ,
              MyAppointmentId: data.myAppointmentId,
              MyDoctorId: data.myDoctorId,
              MyDoctorName:data.doctorName ,
              MyPatientName: data.patientName,
              MyNotificationType: "videocall",
              MyEntingType: "true",
              channelName: ""+data.channelName.toString().trim(),
            ),

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
