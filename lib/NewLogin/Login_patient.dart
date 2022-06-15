import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginRequest.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordRequest.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordResponse.dart';
import 'package:flutter_patient_app/PatientLogin_pack/Multi_Patient_list_screen.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/PatientViewCategories/MasterCategoriesPatient.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/Patient_Registration.dart';
import 'package:flutter_patient_app/anim/FadeAnimation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late BuildContext dialogContext, contextforgotpassword;
String firebaseToken = "";

class Login_patient extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var loginId = new TextEditingController();
var password = new TextEditingController();
var ctrforgetpassward = new TextEditingController();
PatientLoginResponse res = new PatientLoginResponse();

class _MyAppState extends State<Login_patient> {
  bool _isSelected = false;
  final GlobalKey<ScaffoldState> forgetpasswardKey =
      new GlobalKey<ScaffoldState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String passwordvalue = "";
  String mobilevalue = "";

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 60,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseMessaging.instance.getToken().then((value) {
      print(token);
      firebaseToken = value!;
    });
    loginId.text = "";
    password.text = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    loginId.text = "";
    password.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      //resizeToAvoidBottomPadding: true,
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              FadeAnimation(
                1,
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 40.0, 10, 0),
                    child: SizedBox(
                      height: 220,
                      width: 280,
                      child: Image.asset("assets/images/image_patient.png"),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              /*  FadeAnimation(1.8, Container(
             child:
                Image.asset("assets/images/child_care.png")),),*/
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      FadeAnimation(
                        1.8,
                        Container(
                          child: Image.asset(
                            "assets/images/akhil_icon.png",
                            width: 70,
                            height: 70,
                          ),
                        ),
                      ),
                      FadeAnimation(
                        1.8,
                        Container(
                          child: Text("ASPL",
                              style: TextStyle(
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 28,
                                  letterSpacing: .6,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  FadeAnimation(
                    2.3,
                    Container(
                      child: loginCard(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FadeAnimation(
                        2.7,
                        Container(
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 12.0,
                              ),
                              /* GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),*/
                              SizedBox(
                                width: 8.0,
                              ),

                              /*Text("Remember me",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Poppins-Medium")),*/
                            ],
                          ),
                        ),
                      ),
                      FadeAnimation(
                        2.5,
                        Container(
                          child: InkWell(
                            child: Container(
                              width: 130,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF17ead9),
                                        Color(0xFF6078ea)
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Center(
                                    child: Text("SIGN   hgjfyrfj IN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (validationMobileNo(mobilevalue)) {
                                callApi(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    2.7,
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          horizontalLine(),
                          Text("FOR NEW USER?",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontFamily: "Poppins-Medium")),
                          horizontalLine()
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeAnimation(
                        2.7,
                        Container(
                          child: InkWell(
                            child: Container(
                              width: 290,
                              height: 60,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF17ead9),
                                        Color(0xFF6078ea)
                                      ]),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xFF6078ea).withOpacity(.3),
                                        offset: Offset(0.0, 8.0),
                                        blurRadius: 8.0)
                                  ]),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Patient_Registration()));
                                  },
                                  child: Center(
                                    child: Text("SIGN UP",
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
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimation(
                    2.7,
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Powered By ",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text("Akhil Systems Pvt Ltd",
                                style: TextStyle(
                                    color: Color(0xFF5d74e3),
                                    fontFamily: "Poppins-Bold")),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginCard() {
    return new Container(
      width: 300,
      height: 250,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .9)),
            SizedBox(
              height: 15,
            ),
            Container(
              child: LoginInputControls(),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue,
                        fontFamily: "Poppins-Medium",
                        fontSize: 14),
                  ),
                  onTap: () {
                    forgetpasswardpopup("");
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
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
    /*new Future.delayed(new Duration(seconds: 6), () {
      //pop dialog
      //Navigator.pop(context);
    });*/
  }

  Future callApi(BuildContext context) async {
    _onLoading();
    print('mobile valie : $mobilevalue');
    print('password value $passwordvalue');
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    PatientLoginRequest setObj = new PatientLoginRequest();
    setObj.mobileNo = "" + mobilevalue;
    setObj.userPassword = "" + passwordvalue;
    setObj.deviceTokenNo = firebaseToken.trim();
    setObj.loginBy = "1";

    print("Request  \n" + setObj.toJson().toString());
    PatientLoginRequest obj = new PatientLoginRequest.fromJson(setObj.toJson());
    Response<PatientLoginResponse> response =
        (await myService.MobPatientLogin(obj));
    print(response.body);
    var post = response.body;
    res = new PatientLoginResponse.fromJson(post!.toJson());
    if (response != null) {
      // Navigator.pop(context);
      if (response.body!.status.toString().toLowerCase() == "success") {
        if (response.body!.patientList != null) {
          if (response.body!.patientList!.length == 1) {
            saveData(response.body!.patientList!.elementAt(0));

            Navigator.pop(dialogContext);
            /* Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    settings:
                    RouteSettings(name: "/CategoriesPatient"),
                    builder: (context) => CategoriesPatient(
                      PatientDetails: response.body.patientList.elementAt(0),
                      pos: 0,
                    )),
                    (Route<dynamic> route) => false);*/

            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("" + response.body!.msg.toString()),
              duration: Duration(seconds: 3),
            ));
          } else {
            saveData(response.body!.patientList!.elementAt(0));
            Navigator.pop(dialogContext);
            /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Multi_Patient_list_screen(
                    patientList: response.body.patientList,
                  )));*/

            /* Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      settings:
                      RouteSettings(name: "/Multi_Patient_list_screen"),
                      builder: (context) => Multi_Patient_list_screen(
                        patientList: response.body.patientList,

                      )),
                      (Route<dynamic> route) => false);*/
            _scaffoldKey.currentState!.showSnackBar(SnackBar(
              content: Text("" + response.body!.msg.toString()),
              duration: Duration(seconds: 3),
            ));
          }
        } else {
          _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text("" + response.body!.msg.toString()),
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        Navigator.pop(dialogContext);
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body!.msg.toString()),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      Navigator.pop(dialogContext);
      /*Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Categroies()));*/
    }
  }

  showAlerDialog(type, title, message, bool timeNoOff) {
    AwesomeDialog dialog;

    dialog = AwesomeDialog(
      context: contextforgotpassword,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {
        Navigator.of(contextforgotpassword, rootNavigator: true).pop();
      },
    )..show();
    if (timeNoOff) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(contextforgotpassword, rootNavigator: false).pop();
        Navigator.of(contextforgotpassword, rootNavigator: false).pop();
      });
    }
  }

  Future callApiForgetPassword(String otp) async {
    _onLoading();
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    ForgetPasswordRequest setObj = new ForgetPasswordRequest();
    setObj.mobileNo = "" + ctrforgetpassward.text.toString();

    ForgetPasswordRequest obj =
        new ForgetPasswordRequest.fromJson(setObj.toJson());
    print(
        "==========================================================================");
    print("Request  \n" + setObj.toJson().toString());
    Response<ForgetPasswordResponse> response =
        (await myService.MobForgatePassword(obj));

    var post = response.body;
    ForgetPasswordResponse res =
        new ForgetPasswordResponse.fromJson(post!.toJson());
    if (response != null) {
      Navigator.pop(dialogContext);
      if (response.body!.errorMessage.toString().trim().toLowerCase() !=
              "null" ||
          response.body!.errorMessage.toString().trim().toLowerCase() !=
              "false") {
        ctrforgetpassward.clear();
        Navigator.pop(context);
        forgetpasswardKey.currentState!.showSnackBar(SnackBar(
          content: Text(
            "Successfully changed your password",
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
        ));
        //showAlerDialog(DialogType.SUCCES, 'Info', "Successfully changed your password",false);
      } else {
        /* forgetpasswardKey.currentState.showSnackBar(
            SnackBar(
              content: Text("" + response.body.errorMessage.toString(),style: TextStyle(color: Colors.white),),
              duration: Duration(seconds: 1),
            ));*/
        showAlerDialog(
            DialogType.ERROR, 'Error', "Do not change your password", false);
      }
    } else {
      Navigator.pop(dialogContext);
      /* forgetpasswardKey.currentState.showSnackBar(
            SnackBar(
              content: Text("" + response.body.errorMessage.toString(),style: TextStyle(color: Colors.white),),
              duration: Duration(seconds: 1),
            ));*/
      showAlerDialog(
          DialogType.ERROR, 'Error', "Do not change your password", false);
    }
  }

  Future<void> forgetpasswardpopup(String mobileStr) async {
    List<Color> _colors = [
      Color(0xff0096b9),
      Color(0xff0096b9),
      Color(0xff00a69d)
    ];
    List<double> _stops = [0.0, 0.3, 0.4];
    ctrforgetpassward.text = "";
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: forgetpasswardKey,
          title: Text('Enter Mobile'),
          backgroundColor: Color(0xfff9f9f9),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 180,
                  child: TextField(
                    autocorrect: true,
                    controller: ctrforgetpassward,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,
                    //maxLength:4 ,

                    decoration: InputDecoration(
                      //hintText: 'Type Text Here',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff1d9bb4), style: BorderStyle.solid),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xff1d9bb4), style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xff1d9bb4)),
              ),
              onPressed: () {
                ctrforgetpassward.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit', style: TextStyle(color: Color(0xff1d9bb4))),
              onPressed: () {
                if (validationMobileNo(ctrforgetpassward.text.toString())) {
                  callApiForgetPassword(ctrforgetpassward.text.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> optpopup(String mobileStr) async {
    List<Color> _colors = [
      Color(0xff0096b9),
      Color(0xff0096b9),
      Color(0xff00a69d)
    ];
    List<double> _stops = [0.0, 0.3, 0.4];
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: forgetpasswardKey,
          title: Text('Enter OTP'),
          backgroundColor: Color(0xff1d9bb4),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 180,
                  child: TextField(
                    autocorrect: true,
                    controller: ctrforgetpassward,
                    style: TextStyle(
                      color: Colors.white70,
                      letterSpacing: 20,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,
                    //maxLength:4 ,

                    decoration: InputDecoration(
                      //hintText: 'Type Text Here',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white70, style: BorderStyle.solid),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.white, style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xffffffff)),
              ),
              onPressed: () {
                ctrforgetpassward.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit', style: TextStyle(color: Color(0xffffffff))),
              onPressed: () {
                if (validationOtp(ctrforgetpassward.text.toString())) {
                  callApiForgetPassword(ctrforgetpassward.text.toString());
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool validationOtp(String OTPCode) {
    bool valid = true;
    String toastMsg = "";
    if (OTPCode == "" || OTPCode == "null" || OTPCode == null) {
      valid = false;
      toastMsg = "Please enter OTP";
    } else if (OTPCode.length < 4) {
      valid = false;
      toastMsg = "Please enter valid OTP ";
    }
    if (!valid) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg),
        duration: Duration(seconds: 1),
      ));
    }
    return valid;
  }

  bool validationMobileNo(String mobile) {
    bool valid = true;
    String toastMsg = "";
    if (mobile == "" || mobile == "null" || mobile == null) {
      valid = false;
      toastMsg = "Please enter mobile no";
    } else if (mobile.length < 10) {
      valid = false;
      toastMsg = "Please enter valid mobile";
    }
    if (!valid) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg),
        duration: Duration(seconds: 1),
      ));
    }
    return valid;
  }

  Widget LoginInputControls() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          child: new TextFormField(
            controller: loginId,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Mobile',

              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              // hintText: "123",
              // helperText: "blk104",
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            onChanged: (String value) {
              mobilevalue = value;
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: new TextFormField(
            obscureText: true,
            style: TextStyle(color: Colors.white),
            //obscureText: !_passwordVisible,
            controller: password,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: '******',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),

              ///helperText: "1",
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                passwordvalue = value;
              });
              // setState(() => password = value);
            },
          ),
        )
      ],
    );
  }
}

void saveData(PatientList IpPatientobject) async {
  CommonStrAndKey.galobsharedPrefs= await SharedPreferences.getInstance();
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.loginId, "" + loginId.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.password, "" + password.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.registration_id, "" + IpPatientobject.regId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.registration_no, "" + IpPatientobject.regNo.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.patient_name,
      "" + IpPatientobject.patientName.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.hospital_id, IpPatientobject.hospitalID.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.hospital_name, "PSRI Hospital");
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.facility_id, IpPatientobject.facilityId.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.gender, IpPatientobject.gender.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.age, IpPatientobject.age.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.email, IpPatientobject.email.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.encounter_id, IpPatientobject.encounterId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.encounter_no, IpPatientobject.encounterId.toString());
  CommonStrAndKey.galobsharedPrefs!
      .setString(CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(
      CommonStrAndKey.patient_type, IpPatientobject.userType.toString());
}
