import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Response.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Response.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';

import 'package:flutter_patient_app/Book_Appointment_pack/Book_Appointment.dart';
import 'package:flutter_patient_app/Payment_pack/KKCHPayment.dart';

import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Response.dart';

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
class Teleempty_card extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  double? width;
  double? height;
  int? position;
  String? RegId;
  String? RegNo;
  GetDoctorAppointmentSlotJsonListArray? objSlot;
  String? doctorId;
  DateTime? DateForAppt;
  Teleempty_card({
    Key? key,
    this.width,
    this.height,
    this.position,
    this.objSlot,
    this.RegId,
    this.RegNo,
    this.doctorId,
    this.DateForAppt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    remarksController.text="";
    layoutContext = context;

    getDataSharePre();

    return new GestureDetector(
        key: _scaffoldKey,
        onTap: () {
          print("Container clicked");
          if (objSlot!.statusBooked != 0) {
            _alreadyBookedAppmt(context,doctorId!.toString());
            // showAlerDialogAllReadyBooked(DialogType.INFO, 'Already Booked',
            //     'This appointment already booked', context, doctorId);
          } else {
            getPatientDetails(context, doctorId!.toString(), DateForAppt!);
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
    if(CommonStrAndKey.isTeleConsultFlg)
    {
      msg=
      'Do you want to book Tele Consultation Appointment for';
    }else
    {
      msg=
      'Do you want to book Appointment for';
    }
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
                    onTap: () {
                     CommonStrAndKey.enterRemark=true;
                    },
                  ),

                ),
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
                        " at " +
                        data.appointmentTimeAmPm!.toString(),
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
              child: Text('Pay Now'),
              onPressed: () {
               // Navigator.of(context).pop();
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KKCHPayment(
                    myOrderId: "123",
                    myUserId: "321",
                  ),),
                );*/

                //Navigator.of(context).pop();
                bookAppointment(data, DoctorId, dateStr,true);
              },
            ),

            FlatButton(
              child: (!CommonStrAndKey.isTeleConsultFlg)?Text('Pay Later'):Text('Cancel'),
              onPressed: () {
                if (!CommonStrAndKey.isTeleConsultFlg) {
                  Navigator.of(context).pop();
                  bookAppointment(data, DoctorId, dateStr,false);
                }else{
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _bookedAppointment(BuildContext context) async {
    String msg="";
    if(CommonStrAndKey.isTeleConsultFlg)
    {
      msg='Tele Consultation Appointment booked successfuly';
    }else
    {
      msg='Appointment booked successfuly';
    }
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
                Navigator.of(context).pop();
                // Navigator.pop(layoutContext);
                Navigator.of(context)
                    .popUntil(ModalRoute.withName("/CategoriesPatient"));
              },
            ),
            /*  FlatButton(
              child: Text('yes'),
              onPressed: () {
                if(patientDetails !="") {



                }
              },
            ),*/
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
          'This appointment already booked ',
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

  Widget slotColorView(
      GetDoctorAppointmentSlotJsonListArray data, double width, double height) {
    if (data.statusBooked != 0) {
      return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Color(CompanyColors.bluegray60),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(CompanyColors.shadow_color),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: Text(
                  objSlot!.appointmentTimeAmPm!.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ));
    } else {
      return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Color(CompanyColors.appbar_color60),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(CompanyColors.shadow_color),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new Center(
                  child: Text(
                    objSlot!.appointmentTimeAmPm!.toString(),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 16.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Color(CompanyColors.button_txt_color),
                    ),
                  ),
                ),
              )
            ],
          ));
    }
  }

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
          " "+objSlot!.appointmentTimeAmPm.toString() +"  ",
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
        label: Text(" "+objSlot!.appointmentTimeAmPm.toString() +"  ",
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

  Widget slotColorView2(
      GetDoctorAppointmentSlotJsonListArray data, double width, double height) {
    if (data.statusBooked != 0) {
      return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Color(CompanyColors.button_color_new),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: Text(
                  objSlot!.appointmentTimeAmPm.toString(),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 18.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ));
    } else {
      return Container(
          width: width,
          height: height,
          alignment: Alignment.center,
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
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new Center(
                  child: Text(
                    objSlot!.appointmentTimeAmPm.toString(),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      color: Color(CompanyColors.button_color_new),
                    ),
                  ),
                ),
              )
            ],
          ));
    }
  }

  Future getPatientDetails(
      BuildContext context, String DoctorId, DateTime dateStr) async {
    Get_Patient_Details_Response dataPatient =
    new Get_Patient_Details_Response();
    String url = BasicUrl.baseUrl;
    final myService = MyServicePost.create(url);

    Get_Patient_Details_Request setObj = new Get_Patient_Details_Request();
    setObj.registrationNo = "" + RegNo!.toString();
    Get_Patient_Details_Request obj =
    new Get_Patient_Details_Request.fromJson(setObj.toJson());



    print("Request"+obj.toJson().toString());





    Response<Get_Patient_Details_Response> response =
    (await myService.MobGetPatientDetailsByRegistrationNo(obj));
    print(response.body);
    patientDetails = response.body;
    Get_Patient_Details_Response res =
    new Get_Patient_Details_Response.fromJson(patientDetails.toJson());

    if (res.status.toString().toLowerCase() == "success") {
      patientData = res;
      _ConformationOfAppointment(context, objSlot!, DoctorId, dateStr);
      // showAlerDialogConform(DialogType.INFO, 'Are you sure?', context, objSlot,
      //  DoctorId, dateStr);
    } else {
      showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg, context);
    }

    // return Future.value(res);
  }

  showAlerDialogConform(
      type,
      title,
      BuildContext context,
      GetDoctorAppointmentSlotJsonListArray data,
      String DoctorId,
      DateTime dateStr) {
    String message="";
    CommonStrAndKey.enterRemark=true;
    if(CommonStrAndKey.isTeleConsultFlg)
    {
      message = 'Do you want to book Tele Consultation Appointment for' +
          '\n' +
          convertDateToStringFromatForView(dateStr) +
          " at " +
          data.appointmentTimeAmPm.toString();
    }else {
      message = 'Do you want to book Appointment for' +
          '\n' +
          convertDateToStringFromatForView(dateStr) +
          " at " +
          data.appointmentTimeAmPm.toString();
    }

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
        btnOkText: "Pay Now",

        btnCancelText:(CommonStrAndKey.isTeleConsultFlg)?"Cancel": "Pay Later",
        btnOkOnPress: () {
          if (patientDetails != "") {
            /* Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => KKCHPayment(
                myOrderId: "123",
                myUserId: "321",
              ),),
            );*/
            bookAppointment(data, DoctorId, dateStr,true);

          }
        },
        btnCancelOnPress: () {
          if (CommonStrAndKey.isTeleConsultFlg) {
            Navigator.of(context, rootNavigator: true).pop();
          }else
          {
            bookAppointment(data, DoctorId, dateStr,false);

          }

        }

    )
      ..show();
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
        //Navigator.pop(layoutContext);
        Navigator.of(context)
            .popUntil(ModalRoute.withName("/CategoriesPatient"));
        // Navigator.of(context, rootNavigator: true).pop();
      },
    )..show();
  }

  showAlerDialogAllReadyBooked(
      type, title, message, BuildContext context, String DoctorId) {
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
        //Navigator.pop(layoutContext);
        // Navigator.of(layoutContext).pop(false);
        // Navigator.of(layoutContext, rootNavigator: true).pop();
        Navigator.of(context)
            .popUntil(ModalRoute.withName("/CategoriesPatient"));
      },
    )..show();
  }

  showAlerDialogSucess(type, title, message) {
    AwesomeDialog dialog;
    dialog = AwesomeDialog(
      context: layoutContext,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {
        //Navigator.pop(layoutContext);
        Navigator.of(layoutContext, rootNavigator: true).pop();
      },
    )..show();
  }

  Future bookAppointment(GetDoctorAppointmentSlotJsonListArray data,
      String DoctorId, DateTime dateStrr,bool payFlg) async {
    // Navigator.pop(confContext);
    String url = BasicUrl.baseUrl;
    final myService = MyServicePost.create(url);
    TeleNew_Book_Appointment_Request setObj = new TeleNew_Book_Appointment_Request();
    setObj.ageday = "0";
    setObj.agemonth = "0";
    setObj.ageyear = "0";
    setObj.apptotime = "" + data.appointmentTimeAmPm!.toString();
    setObj.appfromtime = "" + data.appointmentTimeAmPm!.toString();
    String tempDate = convertDateFromat(dateStrr);
    setObj.appointmentdate = "" + tempDate;
    setObj.appointmentsource="m";
    setObj.authorizationno = "0";
    setObj.dob = "" + patientData.patientDetailsArray!.elementAt(0).dOB.toString();
    setObj.doctorid = "" + DoctorId;
    // setObj.email = "asd@gmail.com";
    String myemail=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.email)??"";
    print("########+ "+myemail);
    if(myemail.trim()!="")
    {
      setObj.email = myemail.trim();
    }else {
      setObj.email = "asd@gmail.com";
    }
     setObj.facilityID = "" + facilityId!.toString();
    //setObj.facilityID = CommonStrAndKey.isSelectFacilityId;

    setObj.fullName =
        "" + patientData.patientDetailsArray!.elementAt(0).firstName.toString();
    String GenderStr = "1";
    String tempGanderAge = patientData.patientDetailsArray!
        .elementAt(0)
        .patientAgeGender
        .toString();
    if (tempGanderAge.isNotEmpty) {
      String temp = tempGanderAge.replaceAll("/", " ");
      if (temp.toLowerCase().contains("female")) {
        GenderStr = "1";
      } else {
        GenderStr = "2";
      }
    }
    setObj.gender = GenderStr;
    setObj.hospitalLocationId = "" + hospitalId!.toString();
    setObj.mobile = ""+patientData.patientDetailsArray!.elementAt(0).mobile.toString();
    //+ patientData.patientDetailsArray.elementAt(0).mobile;

    setObj.packageId = "0";
    setObj.paymentModeId = "0";
    setObj.registrationNo =""+patientData.patientDetailsArray!.elementAt(0).registrationNo.toString();
    // "" + patientData.patientDetailsArray.elementAt(0).registrationNo;
    setObj.remarks = ""+remarksController.text.toString();
    setObj.titleId = "" + patientData.patientDetailsArray!.elementAt(0).titleId.toString();
    setObj.visitTypeId = "1";
    if(CommonStrAndKey.isTeleConsultFlg)
    {
      setObj.isTeleConsultation = "1";
    }else {
      setObj.isTeleConsultation = "0";
    }
    if(regflag.toString().trim() == "true")
    {
      setObj.IsUnRegPat= true;
    }
    else{
      setObj.IsUnRegPat=false;
    }

    setObj.IsPayNow=payFlg;


    // String stringReq = jsonEncode(setObj);
    //print(stringReq);

    print("Request  \n" + setObj.toJson().toString());
    TeleNew_Book_Appointment_Request obj =
    new TeleNew_Book_Appointment_Request.fromJson(setObj.toJson());
    Response<TeleNew_Book_Appointment_Response> response =
    (await myService.TeleMobSaveAppointment(obj));
    print('santi teting : ${response.body!.errorMessage}');
    var post = response.body;
    if (response != null) {
      if (response.body!.status.toString().toLowerCase() == "true") {
        if (CommonStrAndKey.isTeleConsultFlg)
        { Navigator.push(
          layoutContext,
          MaterialPageRoute(builder: (context) =>
              KKCHPayment(
                myOrderId: "" + response.body!.appointmentId.toString().trim(),
                myUserId: "" + response.body!.appointmentId.toString().trim(),
              ),),
        );
        }else
        {
          if(payFlg) {
            Navigator.push(
              layoutContext,
              MaterialPageRoute(builder: (context) =>
                  KKCHPayment(
                    myOrderId: "" +
                        response.body!.appointmentId.toString().trim(),
                    myUserId: "" +
                        response.body!.appointmentId.toString().trim(),
                  ),),
            );
          }else
          {
            _bookedAppointment(layoutContext);
          }

        }
      } else {
        showAlerDialog(DialogType.ERROR, 'Error', response.body!.errorMessage, layoutContext);
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
