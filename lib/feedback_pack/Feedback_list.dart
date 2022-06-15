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


class Feedback_list extends StatefulWidget {
  static Map<String, CustomerInfo> mapForFeedBack = Map();
  static List<CustomerInfo> dataCustomer= <CustomerInfo>[];
  static List<SavePatientFeedbackModel> savedata =<SavePatientFeedbackModel>[];

  final String? patientType;
  final String? encounterId;
  final String? registrationId;


  Feedback_list({
    this.patientType,
    this.encounterId,
    this.registrationId,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        patientType: patientType,
        encounterId: encounterId,
        registrationId: registrationId
      );
}

class _CardListScreenState extends State<Feedback_list> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();

  String? patientType = "";

  String? encounterId;
  String? registrationId;

  _CardListScreenState({
    this.patientType,
    this.encounterId,
    this.registrationId
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
    return FutureBuilder<Feedback_Response>(
      future: callApi(encounterId!.toString(),registrationId!.toString()), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Feedback_Response> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found ',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ));
          else if (data.requireData.status.toString().toLowerCase() == "success") {
            if (data.requireData.patientFeebackModel != null) {
              print(
                  'data lenght :${data.requireData.patientFeebackModel!.length}');
              if (data.requireData.patientFeebackModel!.length > 0) {
                Feedback_list.dataCustomer.clear();
                String title = "";
                for (int i = 0;
                i < data.requireData.patientFeebackModel!.length;
                i++) {
                  PatientFeebackModelSuper dataSubList =
                  new PatientFeebackModelSuper();
                  dataSubList =
                      data.requireData.patientFeebackModel!.elementAt(i);
                  title = dataSubList.departmentName.toString();
                  if (dataSubList != null &&
                      dataSubList.patientFeebackModel!.length > 0) {
                    for (int j = 0;
                    j < dataSubList.patientFeebackModel!.length;
                    j++) {
                      print(
                          'sub data lenght :${dataSubList.patientFeebackModel!.length}');
                      PatientFeeback dataFeedback = new PatientFeeback();
                      dataFeedback =
                          dataSubList.patientFeebackModel!.elementAt(j);
                      String tempTitle = "";
                      if (j == 0) {
                        tempTitle = title;
                      } else {
                        String tempTitle = "";
                      }
                      CustomerInfo asa2 = new CustomerInfo(
                          "" + tempTitle.toString(),
                          "" + dataFeedback.subDepartment!.toString(),
                          "" + dataFeedback.departmentId!.toString(),
                          "" + dataFeedback.subDepartmentId!.toString(),
                          "",
                          "",
                          "",
                          "" + dataFeedback.flag!.toString(),
                          "" + dataFeedback.rating!.toString(),
                          "0",
                          dataFeedback.departmentId!.toString(),
                          dataFeedback.subDepartmentId!.toString(),
                          dataFeedback.subDepartment!.toString(),
                          dataFeedback.feedBackStatusId!.toString(),
                          dataFeedback.encounterId!.toString(),
                          dataFeedback.flag!.toString());
                      Feedback_list.dataCustomer.add(asa2);
                    }
                  }
                }

                return layout(true);
              } else {
                return layout(false);
              }
            } else {
              return layout(false);
            }
          } else {
            return layout(false);
          }
        }
      },
    );
  }


  Widget layout(bool isVisible) {
    return  ListLayout(isVisible);
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

  Widget ListLayout(bool isVisiable) {
    if (isVisiable) {
      return SafeArea(
        key: _scaffoldKey,
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.only(bottom: 60),
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: Feedback_list.dataCustomer.length,
                  itemBuilder: (BuildContext context, int index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 44.0,
                        child: FadeInAnimation(
                          child: Feedback_list_empty_card(
                            width: MediaQuery.of(context).size.width,
                            height: 120.0,
                            dataValue:
                                Feedback_list.dataCustomer.elementAt(index),
                            pos: index,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                color: Colors.transparent,
                width: 300,
                height: 50,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: InkWell(
                  child: Container(
                    width: 300,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                        borderRadius: BorderRadius.circular(6.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFF6078ea).withOpacity(.3),
                              offset: Offset(0.0, 8.0),
                              blurRadius: 8.0)
                        ]),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          if (Feedback_list.mapForFeedBack != null) {
                            if (Feedback_list.mapForFeedBack.length > 0) {
                              for (var customerInfo
                                  in Feedback_list.dataCustomer) {
                                if (customerInfo.initialRating!.toString().contains("0")) {
                                } else {
                                  print('called 1111');
                                  SavePatientFeedbackModel model =
                                      SavePatientFeedbackModel();
                                  model.flag = customerInfo.flag;
                                  model.encounterId = customerInfo.encounterId;
                                  model.feedBackStatusId =
                                      customerInfo.feedBackStatusId;
                                  model.subDepartment =
                                      customerInfo.subDepartment;
                                  model.subDepartmentId =
                                      customerInfo.subDepartmentId;
                                  model.departmentId =
                                      customerInfo.departmentId;
                                  model.registrationId =
                                      customerInfo.registrationId;
                                  model.encounterId = customerInfo.encounterId;
                                  model.feedback = customerInfo.feedback;
                                  model.rating = customerInfo.initialRating;
                                  Feedback_list.savedata.add(model);
                                }
                              }
                              if (Feedback_list.savedata.length > 0) {
                                String jsonTags =
                                    jsonEncode(Feedback_list.savedata);
                                print('jsonTags : ${jsonTags}');
                                callApiForSend(jsonTags);
                              }
                            } else {
                              _scaffoldKey2.currentState!.showSnackBar(SnackBar(
                                content:
                                    Text("Please rate at least one review!"),
                                duration: Duration(seconds: 3),
                              ));
                            }
                          } else {
                            _scaffoldKey2.currentState!.showSnackBar(SnackBar(
                              content: Text("Please rate at least one review "),
                              duration: Duration(seconds: 3),
                            ));
                          }

                          //if(validation(ctrOldPW.text.toString(),ctrNewPW.text.toString(),ctrConformedPW.text.toString())) {

                          //}
                        },
                        child: Center(
                          child: Text("Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 18,
                                  letterSpacing: 1.0)),
                        ),
                      ),
                    ),
                  ),
                ),

                /* new RaisedButton(

                  color: Color(0xff37b5ff),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0),
                      side: BorderSide(color: Colors.white)
                  ),
                  child: Text('Submit',

                    style: TextStyle(
                      background: Paint()
                        ..color = Colors.transparent,
                      // decoration: TextDecoration(BlendMode.color))

                    ),

                  ),

                  onPressed: () {
                    if(Feedback_list.mapForFeedBack!=null) {
                      if(Feedback_list.mapForFeedBack.length>0){
                        Feedback_list.mapForFeedBack.entries.forEach((e) {
                          print('{ key: ${e.key}, value: ${e.value} }');
                        });
                        }else
                      {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please any one" ),
                              duration: Duration(seconds: 3),
                            ));
                      }

                    }else
                      {
                        _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text("Please select any one"   ),
                              duration: Duration(seconds: 3),
                            ));
                      }

                    //if(validation(ctrOldPW.text.toString(),ctrNewPW.text.toString(),ctrConformedPW.text.toString())) {

                    //}
                  },*/
              ),
            ),
          ],
        ),
      );
    } else {
      return  Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),);
    }
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

Future<Feedback_Response> callApi(String myEncounterId,String myRegistrationId) async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  String registration = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.registration_id) ??
      '';
  String url = BasicUrl.sendUrl();
  print('url : ');
  final myService = MyServicePost.create(url);
  Feedback_Request objddd = new Feedback_Request();
    objddd.encounterId =myEncounterId;
    objddd.registrationId = myRegistrationId;
    print('feedback payload : ${objddd.toJson()}');
    Feedback_Request objj = new Feedback_Request.fromJson(objddd.toJson());
    Response<Feedback_Response> responserrr =
        (await myService.GetPatientFeedback(objj));
    var postt = responserrr.body;
    print('santi feedback ${responserrr.body}');
    res = new Feedback_Response.fromJson(postt!.toJson());


  return Future.value(res);
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
  String?  title;
  String?  subTitle;
  String?  DeptId;
  String?  subDeptId;
  String?  remark;
  String?  feedback;
  String?  registrationId;
  String?  position;
  String?  rating;
  String?  initialRating;

  String?  departmentId;
  String?  subDepartmentId;
  String?  subDepartment;
  String?  feedBackStatusId;
  String?  encounterId;
  String?  flag;

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
