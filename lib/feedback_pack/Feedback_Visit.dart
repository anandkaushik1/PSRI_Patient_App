import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Request.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Response.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_list.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_list_empty_card.dart';
import 'package:flutter_patient_app/feedback_pack/LastVisitRequest.dart';
import 'package:flutter_patient_app/feedback_pack/LastVisitResponse.dart';
import 'package:flutter_patient_app/feedback_pack/SaveFeedbackResponseModel.dart';
import 'package:flutter_patient_app/feedback_pack/SaveFeedbackResponseModel.dart';
import 'package:flutter_patient_app/feedback_pack/SavePatientFeedbackModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Feedback_Response res = new Feedback_Response();
SaveFeedbackResponseModel ressend = new SaveFeedbackResponseModel();
//List<RadioModel> superRadioButtonList;
String tempTypeOfSearch = "";
String doctorId="", facilityId="", hospitalId="";

late BuildContext layoutContext;
late BuildContext contextWritesUs;


class Feedback_Visit extends StatefulWidget {
  static Map<String, CustomerInfo> mapForFeedBack = Map();
  static List<CustomerInfo> dataCustomer= <CustomerInfo>[];
  static List<SavePatientFeedbackModel> savedata =
      <SavePatientFeedbackModel>[];

  String? patientType = "";

  Feedback_Visit({
    this.patientType,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        patientType: this.patientType,
      );
}

class _CardListScreenState extends State<Feedback_Visit> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();

  String? patientType = "";

  _CardListScreenState({
    this.patientType,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getLatisit();
  }

  @override
  Widget build(BuildContext context) {
    layoutContext = context;
    contextWritesUs = context;
    // getDoctorId();
    // return layout(true);
    return FutureBuilder<LastVisitResponse>(
      future: callApi("1", "", ""), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<LastVisitResponse> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ));
          else if (data.requireData.status.toString().toLowerCase() == "success") {

              if (data.requireData.lastVisit!.elementAt(0).isFeedbackGiven.toString().trim()==("0")) {
                return layout(false,data.requireData);
            } else {
              return layout(true,data.requireData);
            }
          } else {
            return layout(false,data.requireData);
          }
        }
      },
    );
  }

  Widget layout(bool isVisible,LastVisitResponse data) {
    return Scaffold(
      key: _scaffoldKey2,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Feedback',
          style: TextStyle(fontSize: 16.0),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(CompanyColors.appbar_color),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
      ),
      body: ListLayout(isVisible,data),
    );
  }

  callApiForSend(String body) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    final response = await myService.SavePatientFeedback(body);
    if (response != null) {
      if (response.body!.status!.toString().contains("Success")) {
        showAlerDialog(DialogType.SUCCES, 'Info', response.body!.message,true);
      } else {
        showAlerDialog(DialogType.ERROR, 'Error', response.body!.message,false);
      }
    }

    print(response.body!.status!.toString());
  }

  showAlerDialog(type, title, message,bool timeNoOff) {
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

        Navigator.of(layoutContext, rootNavigator: true).pop();
      },
    )..show();
    if (timeNoOff){
      Timer(
          Duration(seconds: 3),
              () {
            Navigator.of(layoutContext, rootNavigator: false).pop();
            Navigator.of(layoutContext, rootNavigator: false).pop();
          }

      );
    }
  }

  Widget ListLayout(bool isVisiable,LastVisitResponse myData) {
    if (isVisiable) {
      return Feedback_list(
        encounterId: myData.lastVisit!.elementAt(0).encounterId.toString(),
        registrationId: myData.lastVisit!.elementAt(0).registrationId.toString(),
      );
    } else {
      return Center(child: Text('Feedback Already Given for this Visit!',
      style: TextStyle(fontSize: 18,color: Colors.blue),));
    }
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

Future<LastVisitResponse> callApi(
    String patientType, String typeSearch, searchValue) async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  String registration = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.registration_id) ??
      '';
  String url = BasicUrl.sendUrl();
  print('url : ');
  final myService = MyServicePost.create(url);
  LastVisitRequest lastvist = new LastVisitRequest();
  lastvist.registrationId = registration;
  Response response = await myService.LastVisit(lastvist);
  print('santi resposnse lastvisit :${response.body.toString()}');


  return Future.value(response.body);
}

getLatisit() async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  String registration = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
      '';
  String url = BasicUrl.sendUrl();

  print('url : ');
  final myService = MyServicePost.create(url);

  LastVisitRequest lastvist = new LastVisitRequest();
  lastvist.registrationId = registration;

  var response = await myService.LastVisit(lastvist);
  print('santi resposnse lastvisit :${response.body}');
}

showAlerDialog(type, title, message,bool timeNoOff) {
  AwesomeDialog dialog;

  dialog = AwesomeDialog(
    context: contextWritesUs,
    animType: AnimType.SCALE,
    dialogType: type,
    title: title,
    body: Center(
      child: Text(
        message,
      ),
    ),
    btnOkOnPress: () {

      Navigator.of(contextWritesUs, rootNavigator: true).pop();
    },
  )..show();
  if (timeNoOff){
    Timer(
        Duration(seconds: 2),
            () {
          Navigator.of(contextWritesUs, rootNavigator: false).pop();
          Navigator.of(contextWritesUs, rootNavigator: false).pop();
        }

    );
  }
}

String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}

void getDoctorId() {
  facilityId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ??
          '';
  hospitalId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
          '';
  String ddd = doctorId;
}

class CustomerInfo {
  String title;
  String subTitle;
  String DeptId;
  String subDeptId;
  String remark;
  String feedback;
  String registrationId;
  String position;
  String rating;
  String initialRating;

  String departmentId;
  String subDepartmentId;
  String subDepartment;
  String feedBackStatusId;
  String encounterId;
  String flag;

  CustomerInfo(
      this.title,
      this.subTitle,
      this.DeptId,
      this.subDeptId,
      this.remark,
      this.feedback,
      this.registrationId,
      this.position,
      this.rating,
      this.initialRating,
      this.departmentId,
      this.subDepartmentId,
      this.subDepartment,
      this.feedBackStatusId,
      this.encounterId,
      this.flag);
}
