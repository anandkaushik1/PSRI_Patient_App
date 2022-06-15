import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/Payment_pack/KKCHPayment.dart';
import 'package:flutter_patient_app/RescheduleAppointment/RescheduleAppointmentRequest.dart';
import 'package:flutter_patient_app/RescheduleAppointment/RescheduleAppointmentResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/Get_Patient_Details_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/Get_Patient_Details_Response.dart';

import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Response.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

var titleName, Icon;
var patientDetails;
String alreadyBooked="";
Get_Patient_Details_Response patientData = new Get_Patient_Details_Response();
late BuildContext layoutContext, confContext;

String? doctorId, facilityId, hospitalId, registrationId,registration_no,regflag;
var remarksController = new TextEditingController();
class RescheduleEmptyCard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double? width;
  double? height;
  final int? position;
  final String? RegId;
  final String? RegNo;
  final GetDoctorAppointmentSlotJsonListArray? objSlot;
  final String? doctorId;
  final DateTime? DateForAppt;
  final AppointmentListJSon? myAppointData;
  RescheduleEmptyCard({
    Key? key,
    this.width,
    this.height,
    this.position,
    this.objSlot,
    this.RegId,
    this.RegNo,
    this.doctorId,
    this.DateForAppt,
    this.myAppointData,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    layoutContext = context;

    getDataSharePre();

    return new GestureDetector(
        key: _scaffoldKey,
        onTap: () {
          print("Container clicked");
          if (objSlot!.statusBooked != 0) {
            _alreadyBookedAppmt(context,doctorId!.toString());
          } else {
            _ConformationOfAppointment(context,objSlot!,doctorId!.toString(),DateForAppt!);
           // getPatientDetails(context, doctorId, DateForAppt);
          }
        },
        child: _buildChip(objSlot!, width!.toDouble(), height!.toDouble()));
  }

  Future<void> _ConformationOfAppointment(
      BuildContext context,
      GetDoctorAppointmentSlotJsonListArray data,
      String DoctorId,
      DateTime dateStr) async {
    String msg="";
   /* if(CommonStrAndKey.isTeleConsultFlg)
    {
      msg=
      'Do you want to book Tele Consultation Appointment for';
    }else
    {
      msg=
      'Do you want to book Appointment for';
    }*/
    msg=
    'Do you want to reschedule Appointment for';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        confContext = context;
        return AlertDialog(
          title: Text('Remarks'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
               new Container(
                 child:
                new TextFormField(
                  controller: remarksController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(100),
                  ],
                  minLines: 2,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: ' Remarks ......',
                    hintStyle: TextStyle(
                        color: Colors.grey
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13.0)),
                    ),
                  ),
                ),),
                new SizedBox(
                  height: 5,),
                new Text('Max value 100',style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),),
                // new Text('${remarksController.text.length}'),
                new SizedBox(
                  height: 20,),
                new Container(
                  child: new Center(
                    child: Text(msg+"" +
                        '\n' +
                        convertDateToStringFromatForView(dateStr) +
                        " at " +(objSlot!.appointmentTimeAmPm!.toString()),
                        /*utcTo12HourFormat(
                            objSlot.appointmentTimeAmPm),*/
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Reschedule Now'),
              onPressed: () {
                Navigator.of(context).pop();

                bookAppointment(data, DoctorId, dateStr,true);
              },
            ),

            FlatButton(
              child:Text('Cancel'),
              onPressed: () {
                remarksController.text="";
                  Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }

 /* String utcTo12HourFormat(String bigTime) {
    DateTime tempDate = DateFormat("hh:mm").parse(bigTime);
    var dateFormat = DateFormat("h:mm a"); // you can change the format here
    var utcDate = dateFormat.format(tempDate); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate).toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    print("------------$createdDate");
    return createdDate;
  }*/
  Future<void> _bookedAppointment(BuildContext context) async {
    String msg="";
   /* if(CommonStrAndKey.isTeleConsultFlg)
    {
      msg='Tele Consultation Appointment booked successfuly';
    }else
    {
      msg='Appointment booked successfuly';
    }*/
    msg='Appointment rescheduled successfuly';
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        confContext = context;
        return AlertDialog(
          title: Text('Appointment Status '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(confContext).pop();
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/MyBook_Appointment"));
              },
            ),

          ],
        );
      },
    );
  }

  Future<bool> _alreadyBookedAppmt(
      BuildContext context, String DoctorId) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Already Booked'),
        content: new Text(
          'This appointment slot already booked ',
          style: TextStyle(fontSize: 12),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('Cancel'),
          ),
        ],
      ),
    )) ??
        false;
  }

   // Am And PM Format
  /*Widget _buildChip(
      GetDoctorAppointmentSlotJsonListArray data, double width, double height) {
    if (data.statusBooked != 0) {
      return Chip(
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Color(CompanyColors.bluegray60),
          child: Text("X"),
        ),
        label: Text(objSlot.appointmentTimeAmPm,
         *//* " "+utcTo12HourFormat(
              objSlot.appointmentTimeAmPm) +"  ",*//*
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(CompanyColors.bluegray60),
        elevation: 2.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(1.0),
      );
    } else {
      return Chip(
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Color(CompanyColors.appbar_color60),
          child: Text("A"),
        ),
        label: Text(objSlot.appointmentTimeAmPm,
          *//*" "+utcTo12HourFormat(
            objSlot.appointmentTimeAmPm)+"  ",*//*
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(CompanyColors.appbar_color60),
        elevation: 2.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(1.0),
      );
    }
  }
*/
  Widget _buildChip(
      GetDoctorAppointmentSlotJsonListArray data, double width, double height) {
    if (data.statusBooked != 0) {
      return Chip(
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Color(CompanyColors.bluegray60),
          child: Text("X"),
        ),
        label: Text(
          " "+objSlot!.appointmentTimeAmPm!.toString() +"  ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(CompanyColors.bluegray60),
        elevation: 2.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(1.0),
      );
    } else {
      return Chip(
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Color(CompanyColors.appbar_color60),
          child: Text("A"),
        ),
        label: Text(" "+objSlot!.appointmentTimeAmPm!.toString() +"  ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(CompanyColors.appbar_color60),
        elevation: 2.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(1.0),
      );
    }
  }




  showAlerDialog(type, title, message, BuildContext context) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {
        Navigator.of(context)
            .popUntil(ModalRoute.withName("/CategoriesPatient"));

      },
    )..show();
  }


  Future bookAppointment(GetDoctorAppointmentSlotJsonListArray data,
      String DoctorId, DateTime dateStrr,bool payFlg) async {
    // Navigator.pop(confContext);
    String url = BasicUrl.baseUrl;
    final myService = MyServicePost.create(url);
    RescheduleAppointmentRequest setObj = new RescheduleAppointmentRequest();
    setObj.doctorId = "";
    setObj.facilityId = int.parse(facilityId!.toString());
    setObj.registrationId = "";
    setObj.appointmentDate = "" + dateStrr.toString();
    setObj.fromTime=data.appointmentTimeAmPm;
    setObj.appointmentSource = "M";
    setObj.appointmentId = int.parse(myAppointData!.appointmentId!.toString());
    setObj.rescheduleReason= ""+remarksController.text.toString();
    print("Request  \n" + setObj.toJson().toString());
    RescheduleAppointmentRequest obj =
    new RescheduleAppointmentRequest.fromJson(setObj.toJson());
    Response<RescheduleAppointmentResponse> response =
    (await myService.ReschedulePatientAppointment(obj));
    print('santi teting : ${response.body!.msg}');
    var post = response.body;
    remarksController.text="";
    if (response != null) {

      if (response.body!.status!.toString().toLowerCase() == "true") {

            _bookedAppointment(layoutContext);

      } else {
        showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg, layoutContext);
      }
    }
  }
}

String convertDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(date);
  print(formatted); // something like 2013-04-20
  return formatted;
}

String convertDateToStringFromatForView(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MMMM-yyyy');
  String formatted = formatter.format(date);
  print(formatted); // something like 2013-04-20
  return formatted;
}

void getDataSharePre() async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();

  facilityId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ??
          '';
  hospitalId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
          '';
  registrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
      '';
  regflag = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.IsUnRegPat) ??
      '';


}
