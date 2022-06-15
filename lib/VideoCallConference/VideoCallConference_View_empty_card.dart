import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/VideoCallConference/ConferenceViewResponse.dart';
import 'package:flutter_patient_app/Video_Call/pages/CanferenceCall.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
late BuildContext confContext,loadingContext,layoutContext;
ClientRole? _role = ClientRole.Broadcaster;
class VideoCallConference_View_empty_card extends StatelessWidget {
  final double? width;
  final double? height;
  final VCStatusList? patientDetails;
  final int? pos;

  const VideoCallConference_View_empty_card({
    Key? key,
    this.width,
    this.height,
    this.patientDetails,
    this.pos,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    layoutContext=context;
    return new GestureDetector(
      /*onTap: (){
      print("Container clicked");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Lab_details_List(
          labData: labResult,
          pos: pos,
        )),
      );
    },*/

      child: Container(
        width: width,
        height: height,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Stack(
          children: [
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  "" + patientDetails!.doctorName.toString(),
                  style: TextStyle(
                      color: Color(0xff5056ca),
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                new Text(
                  "Date :- " + patientDetails!.appointmentDate.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
                new Text(
                  "Patient Name:- " + patientDetails!.senderName.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
                new Text(
                  "Date/Time:- " + patientDetails!.appointmentDate.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),
              /*  new Text(
                  "Payment Status:- " + patientDetails.status.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                ),*/
              ],
            ),

          /*  new GestureDetector(
              onTap:() {
             ///   _ConformationOfAppointment(patientDetails,"Do you want to cancel Appointment?",context);
              },
              child:   new Align(
                alignment: Alignment.topRight,
                heightFactor: 30.0,
                widthFactor: 30.0,
                child:  SvgPicture.asset(
                  'assets/icons/delete.svg',
                  height: 30.0,
                  width: 30.0,
                  fit: BoxFit.fill,
                ),),
            ),*/
            new GestureDetector(
              onTap:() {
                AppointmentListJSon obj =new AppointmentListJSon();
                obj.appointmentDate=patientDetails!.appointmentDate.toString();
                obj.hospitalLocationId=1;
                obj.doctorId=patientDetails!.doctorId;
                obj.facilityID=3;
                obj.appointmentId=0;
                obj.registrationNo="";
                obj.isTeleConsultation=true;
                obj.doctorName=patientDetails!.doctorName;
                obj.patientName=patientDetails!.senderName;

                CommonStrAndKey.isConnecting=true;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CanferenceCall(
                    //channelName: PatientDetails.regId.toString(),
                    MyAppointmentId: obj.appointmentId.toString(),
                    MyDoctorId: obj.doctorId.toString(),
                    MyDoctorName:obj.doctorName.toString() ,
                    MyPatientName: obj.patientName.toString(),
                    channelName:  patientDetails!.uniqueValue.toString().trim(),
                    MyNotificationType: "conference",
                    MyEntingType: "true",
                    role:_role ,
                  ),),
                );
                 },
              child:   new Align(
                alignment: Alignment.bottomRight,
                heightFactor: 30.0,
                widthFactor: 30.0,
                child:  SvgPicture.asset(
                  'assets/icons/videocall.svg',
                  height: 30.0,
                  width: 30.0,
                  fit: BoxFit.fill,
                ),),
            )
          ],
        ),
      ),
    );
  }


  Future<void> _ConformationOfAppointment(AppointmentListJSon data,String aptMsg,BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        confContext=context;
        return AlertDialog(
          title: Text('Are you sure'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("" + aptMsg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
              //  callApi(context,patientDetails);
              },
            ),
          ],
        );
      },
    );
  }
  void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingContext=context;
        return Dialog(
            child: new Container(
              height: 170,
              width: 100,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius:
                new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: new Center(

                child:  new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              ),
            )


        );
      },
    );
    /*new Future.delayed(new Duration(seconds: 6), () {
      //pop dialog
      //Navigator.pop(context);
    });*/
  }
  /*Future  callApi(BuildContext context ,AppointmentListJSon data)
  async {
    Navigator.of(confContext).pop();
    _onLoading(context);
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    DeleteAppointmentRequest setObj=new DeleteAppointmentRequest();
    setObj.appointmentId=""+data.appointmentId.toString();
    setObj.registrationNo=""+data.registrationNo.toString();
    setObj.reasons="";
    print("Request  \n" + setObj.toJson().toString());
    DeleteAppointmentRequest obj=new DeleteAppointmentRequest.fromJson(setObj.toJson());
    Response<DeleteAppointmentResponse> response = (await myService.MobCancelAppointment(obj));
    print(response.body);
    var post = response.body;
    resDelete=new DeleteAppointmentResponse.fromJson(post!.toJson());
    if(response!=null)
    {
      Navigator.of(loadingContext).pop();
      Navigator.of(layoutContext).pop();
      if(response.body.cancelMessage.toLowerCase()=="your appointment has been cancelled sucessfully.")
      {


          _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text("" + response.body.cancelMessage.toString()),
                duration: Duration(seconds: 3),
              ));

      }else
      {
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text("" + response.body.cancelMessage.toString()),
              duration: Duration(seconds: 3),
            ));

      }
    }

  }*/

}
