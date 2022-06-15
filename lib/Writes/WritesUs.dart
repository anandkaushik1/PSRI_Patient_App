import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Profile/PatientProfileUpdate.dart';
import 'package:flutter_patient_app/Profile/PatientProfileUpdateResponse.dart';
import 'package:flutter_patient_app/Writes/Date_Picker_For_WriteUs.dart';
import 'package:flutter_patient_app/Writes/WriteUsResponse.dart';
import 'package:flutter_patient_app/Writes/WritesUsRequest.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime globelDate = DateTime.now();
const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

late BuildContext layoutContext;
String patientName = "",
    mobileNo = "",
    email = "",
    registration = "",
    hospital_name = "",
    remarks = "",
    time = "",
    encounter_id = "",
    date = "";

WriteUsResponse res = new WriteUsResponse();
var ctrName = TextEditingController();
var ctrHospital = TextEditingController();
var ctrMobile = TextEditingController();
var ctrEmail = TextEditingController();
var ctrDate = TextEditingController();
var ctrTime = TextEditingController();
var ctrRemarks = TextEditingController();
late List<RadioModel> superRadioButtonList;
List<RadioModel> radioList= <RadioModel>[];
late BuildContext contextWritesUs;

class WritesUs extends StatefulWidget {
  String? DoctorId = "";

  WritesUs({
    this.DoctorId,
    Key? key,
  }) : super(key: key);

  @override
  ProfileState createState() => ProfileState(
        DoctorId: this.DoctorId,
      );
}

class ProfileState extends State<WritesUs> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String timeOfCall = "";
  String _currentAddress = "";
  String? DoctorId = "";

  ProfileState({
    this.DoctorId,
  });

  @override
  void initState() {
    super.initState();
    radioList= <RadioModel>[];
    radioList.add(new RadioModel(true, '9-10', 'FID'));
    radioList.add(new RadioModel(false, '10-12', 'SEID'));
    radioList.add(new RadioModel(false, '12-2', 'THID'));
    radioList.add(new RadioModel(false, '3-6', 'FOID'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ctrName.text = "";
    ctrHospital.text = "";
    ctrEmail.text = "";
    ctrMobile.text = "";
    ctrDate.text = "";
    ctrTime.text = "";
    ctrRemarks.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    contextWritesUs = context;
    getDataSharePre();
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(CompanyColors.grey),
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Write Us',
          style: TextStyle(fontSize: 16.0,color: Colors.white),
        ),
backgroundColor: Color(CompanyColors.appbar_color),
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //         Color(0xFF17ead9),
          //         Color(0xFF6078ea)
          //       ]),
          //       borderRadius: BorderRadius.circular(6.0),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Color(0xFF6078ea).withOpacity(.3),
          //             offset: Offset(0.0, 8.0),
          //             blurRadius: 8.0)
          //       ]),
          // ),

      ),
      body: new Center(
        child: new Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 100, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10))
              ]),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 100,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        new Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: new TextFormField(
                            enabled: false,
                            controller: ctrHospital,
                            decoration: InputDecoration(
                              labelText: 'Hospital Name',
                              hintText: mobileNo,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.local_hospital),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              //setState(() => doctorId = value);
                              // hospital_name = value;
                            },
                          ),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrName,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Your Name',
                              hintText: email,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.person),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              //  patientName = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            controller: ctrEmail,
                            //obscureText: !_passwordVisible,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.email),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              email = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrMobile,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Mobile No.',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.phone),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              mobileNo = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                            decoration: myBoxDecoration(),
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            margin: EdgeInsets.only(bottom: 20),
                            child: new Column(
                              children: [
                                new Container(
                                  child: new Text(
                                    "Preferred date for call back",
                                    style: TextStyle(color: Colors.grey),

                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,

                                ),
                                new Center(
                                  child: buttonVisiableOrNot(),
                                ),
                              ],
                            )),
                        new Container(
                            decoration: myBoxDecoration(),
                            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                            margin: EdgeInsets.only(bottom: 20),
                            child: new Column(
                              children: [
                                new Container(
                                  child: new Text(
                                    "Preferred time for callback",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                ),
                                new Container(
                                  height: 70,
                                  margin: EdgeInsets.only(left: 15),
                                  child: new ListView.builder(
                                    itemCount: radioList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return new InkWell(
                                          //highlightColor: Colors.red,
                                          splashColor:Color(0xF17ead9),
                                          onTap: () {
                                            setState(() {
                                              radioList.forEach((element) =>
                                                  element.isSelected = false);
                                              radioList[index].isSelected =
                                                  true;
                                              if (index == 0) {
                                                timeOfCall = "9-10";
                                              } else if (index == 1) {
                                                timeOfCall = "10-12";
                                              } else if (index == 2) {
                                                timeOfCall = "12-2";
                                              } else {
                                                timeOfCall = "3-6";
                                              }
                                            });
                                          },
                                          child: new Container(
                                              child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                child: Center(
                                                  child: RadioItem(
                                                      radioList[index]),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          )));
                                    },
                                  ),
                                ),
                              ],
                            )),
                        new Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrRemarks,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Remarks',
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 10.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.disc_full),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              remarks = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.white,
                          child: Text(
                            'Contact for assistance: 91-011-61426142',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Poppins-Bold",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),

                        ),
                        new SizedBox(
                          height: 5,
                        ),
                        new Container(
                          width: 290,
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          child: InkWell(
                            child:

                            Container(
                              width:290,
                              height:50,
                              decoration: BoxDecoration(
                                color: Color(CompanyColors.appbar_color),
                                  // gradient: LinearGradient(
                                  //     begin: Alignment.topCenter,
                                  //     end: Alignment.bottomCenter,
                                  //     colors: [
                                  //       Color(0xFF17ead9),
                                  //       Color(0xFF6078ea)
                                  //     ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child:
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (validation(
                                        ctrHospital.text.toString(),
                                        ctrName.text.toString(),
                                        ctrEmail.text.toString(),
                                        ctrMobile.text.toString(),
                                        ctrEmail.text.toString(),
                                        ctrMobile.text.toString(),
                                        ctrRemarks.text.toString())) {
                                    /* _ConformationOfAppointment(
                                    "You are sure to password?");*/
                                    callApi(context);
                                  }
                                  },
                                  child:

                                  Center(
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
                          ),),

                      /*    new RaisedButton(
                            color: Color(0xff37b5ff),
                            textColor: Colors.white,
                            splashColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(6.0),
                                side: BorderSide(color: Colors.white)),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                background: Paint()..color = Colors.transparent,
                                // decoration: TextDecoration(BlendMode.color))
                              ),
                            ),
                            onPressed: () {
                              if (validation(
                                  ctrHospital.text.toString(),
                                  ctrEmail.text.toString(),
                                  ctrMobile.text.toString(),
                                  ctrHospital.text.toString(),
                                  ctrEmail.text.toString(),
                                  ctrMobile.text.toString(),
                                  ctrMobile.text.toString())) {
                                *//* _ConformationOfAppointment(
                                    "You are sure to password?");*//*
                                callApi(context);
                              }
                            },
                          ),*/
                      //  ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _ConformationOfAppointment(String aptMsg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("" + aptMsg),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                callApi(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(0xff37b5ff)));
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1, //                   <--- border width here
      ),
      borderRadius: BorderRadius.circular(6.0),
    );
  }

  bool validation(String hospitalStr, String nameStr, String emailStr,
      String mobileStr, String dateStr, String timeStr, String remarks) {
    bool valid = true;
    String toastMsg = "";
    if (hospitalStr == "" || hospitalStr == "null" || hospitalStr == null) {
      valid = false;
      toastMsg = "Please enter hospital";
    } else if (nameStr == "" || nameStr == "null" || nameStr == null) {
      valid = false;
      toastMsg = "Please enter name";
    } else if (mobileStr == "" || mobileStr == "null" || mobileStr == null) {
      valid = false;
      toastMsg = "Please enter mobile no";
    }  else if (mobileStr.length!=10) {
      valid = false;
      toastMsg = "Please enter valid mobile no";
    }
    else if (emailStr == "" || emailStr == "null" || emailStr == null) {
      valid = false;
      toastMsg = "Please enter email";
    } /*else if (dateStr == "" || dateStr == "null" || dateStr == null) {
      valid = false;
      toastMsg = "Please select date  ";
    } else if (timeStr == "" || timeStr == "null" || timeStr == null) {
      valid = false;
      toastMsg = "Please select time ";
    } */else if (remarks == "" || remarks == "null" || remarks == null) {
      valid = false;
      toastMsg = "Please enter remarks";
    }
    if(!valid) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg.toString()),
        duration: Duration(seconds: 3),
      ));
    }
    return valid;
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            child: new Container(
          height: 170,
          width: 100,
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: const Color(0xFFFFFF),
            borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          ),
          child: new Center(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                new CircularProgressIndicator(),
                new Text("Loading"),
              ],
            ),
          ),
        ));
      },
    );
    new Future.delayed(new Duration(seconds: 6), () {
      //pop dialog
      // Navigator.pop(context);
      // Navigator.pop(context);
    });
  }

  Widget buttonVisiableOrNot() {
    return new Container(
      height: 85,
      margin: EdgeInsets.fromLTRB(15, 0, 20, 0),
      child: Date_Picker_For_WriteUs(
        globelDate,
        onDateChange: (date) {
          // New date selected
          setState(() {
            globelDate = date;
          });
        },
      ),
    );
  }

  void getDataSharePre() async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    patientName = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ??
        '';
    mobileNo =
        CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobileNo) ??
            '';
    email =
        CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.email) ?? '';
    registration = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    encounter_id = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_id) ??
        '';
    hospital_name = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_name) ??
        '';
    ctrMobile.text = mobileNo;
    ctrEmail.text = email;
    ctrName.text = patientName;
    ctrHospital.text = hospital_name;
  }

  Future callApi(BuildContext context) async {
    // _onLoading();
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    WritesUsRequest setObj = new WritesUsRequest();
    setObj.registrationNo = "" + registration;
    setObj.encounterNo = "" + encounter_id;
    setObj.patientName = "" + ctrName.text.toString();
    setObj.email = "" + ctrEmail.text.toString();
    setObj.mobileNo = "" + ctrMobile.text.toString();

    String dateStr = DateFormat("yyyy-MM-dd").format(globelDate);
    setObj.callBackDate = "" + dateStr.toString();
    setObj.callBacktime = "" + timeOfCall;
    setObj.remark = "" + ctrRemarks.text.toString();
    print("Request"+setObj.toJson().toString());
    WritesUsRequest obj = new WritesUsRequest.fromJson(setObj.toJson());
    Response<WriteUsResponse> response = (await myService.SaveWriteUs(obj));
    print(response.body);
    var post = response.body;
    res = new WriteUsResponse.fromJson(post!.toJson());
    if (response != null) {
      if (response.body!.status.toString().toLowerCase().trim().contains("success")) {
        showAlerDialog(DialogType.SUCCES, 'Info', response.body!.message,true);
      } else {
        showAlerDialog(DialogType.SUCCES, 'Error', response.body!.message,false);
      }
    }

    print(response.body!.status.toString());
  }
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
        Duration(seconds: 3),
            () {
              Navigator.of(contextWritesUs, rootNavigator: false).pop();
              Navigator.of(contextWritesUs, rootNavigator: false).pop();
            }

    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 40.0,
            width: 86.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Color(CompanyColors.appbar_color) : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Color(0xff6a6fde) : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          /* new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )*/
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}
