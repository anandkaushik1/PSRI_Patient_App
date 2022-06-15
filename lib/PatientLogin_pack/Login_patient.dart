import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Multi_Patient/Multi_patient_New.dart';
import 'package:flutter_patient_app/NewLogin/Login_patient.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginRequest.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/Login_Screen.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordRequest.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordResponse.dart';
import 'package:flutter_patient_app/PatientLogin_pack/Multi_Patient_list_screen.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


String firebaseToken="";

class Login_patient extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

var loginId = new TextEditingController();
var password = new TextEditingController();
PatientLoginResponse res = new PatientLoginResponse();

class _MyAppState extends State<Login_patient> {
  bool _isSelected = false;
  bool _passwordVisible = true;
  String passwordvalue = "";
  String mobilevalue = "";
  final GlobalKey<ScaffoldState> forgetpasswardKey =
  new GlobalKey<ScaffoldState>();
  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text(value)));
  }


  @override
  void initState() {
    // TODO: implement initState
    loginId.text="";
    password.text="";
    super.initState();

    firebaseToken="";
    FirebaseMessaging.instance.getToken().then((value) {
      print(token);
      firebaseToken = value!;
    });
  }

  @override
  void dospose(){
    loginId.text="";
    password.text="";
  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue,
      //resizeToAvoidBottomPadding: true,
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/New_Icons/background.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),


          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[

             /* FadeAnimation(
                1,*/
                Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 80.0, 20, 0),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/images/child_care.png"),
                    ),
                  ),
                ),
            //  ),
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
                     /* FadeAnimation(
                        1.8,*/
                        Container(
                          child: IconButton(
                            padding: EdgeInsets.only(top: 40),
                            icon: Icon(Icons.arrow_back),
                            color: Colors.white,
                            onPressed: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context)=> Login_Screen()));
                            },
                          ),
                        ),
                     // ),
                     /* FadeAnimation(
                        1.8,*/
                        Container(
                          child: Text("",
                              style: TextStyle(
                                  fontFamily: "Poppins-Bold",
                                  fontSize: 25,
                                  letterSpacing: .6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                     // ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                  ),
                 /* FadeAnimation(
                    2.3,*/
                    Container(
                      child: loginCard(),
                    ),
                //  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // FadeAnimation(
                      //   2.7,
                      //   Container(
                      //     child: Row(
                      //       children: <Widget>[
                      //         SizedBox(
                      //           width: 12.0,
                      //         ),
                      //         GestureDetector(
                      //           onTap: _radio,
                      //           child: radioButton(_isSelected),
                      //         ),
                      //         SizedBox(
                      //           width: 8.0,
                      //         ),
                      //         Text("Remember me",
                      //             style: TextStyle(
                      //                 fontSize: 12,
                      //                 fontFamily: "Poppins-Medium")),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      /*FadeAnimation(
                        2.5,*/
                        Container(
                          child: InkWell(
                            child: Container(
                              width: 250,
                              height: 50,
                              margin: EdgeInsets.all(2),
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(CompanyColors.grey),
                                  border: Border.all(
                                      //color: Color(CompanyColors.appbar_color), // Set border color
                                      width: 1.0),   // Set border width
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5.0)), // Set rounded corner radius
                                  boxShadow: [BoxShadow(blurRadius: 1,color: Colors.blueAccent,offset: Offset(1,1))] // Make rounded corner of border
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    if (validationMobileNo(mobilevalue)) {
                                      callApi();
                                    } else {
                                      print('calling value fir sending ');
                                    }
                                  },
                                  child: Center(
                                    child: Text("SIGN IN",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0)),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () {
                              if (validationMobileNo(mobilevalue)) {
                                callApi();
                              } else {
                                print('calling value fir send sending ');
                              }
                            },
                          ),
                        ),
                     // ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // FadeAnimation(
                  //   2.7,
                  //   Container(
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         horizontalLine(),
                  //         Text("FOR NEW USER?",
                  //             style: TextStyle(
                  //                 fontSize: 14.0,
                  //                 fontFamily: "Poppins-Medium")),
                  //         horizontalLine()
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     FadeAnimation(
                  //       2.7,
                  //       Container(
                  //         child: InkWell(
                  //           child: Container(
                  //             width: 250,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //                 gradient: LinearGradient(colors: [
                  //                   Color(0xFF17ead9),
                  //                   Color(0xFF6078ea)
                  //                 ]),
                  //                 borderRadius: BorderRadius.circular(6.0),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                       color:
                  //                       Color(0xFF6078ea).withOpacity(.3),
                  //                       offset: Offset(0.0, 8.0),
                  //                       blurRadius: 8.0)
                  //                 ]),
                  //             child: Material(
                  //               color: Colors.transparent,
                  //               child: InkWell(
                  //                 onTap: () {},
                  //                 child: Center(
                  //                   child: Text("SIGNUP",
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontFamily: "Poppins-Bold",
                  //                           fontSize: 18,
                  //                           letterSpacing: 1.0)),
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                 /* FadeAnimation(
                    2.7,*/
                    Container(
                      child: InkWell(
                        onTap: () {
                          launchURL("https://akhilsystems.com");
                        },
                        child: Text(
                            "Powered by Akhil Systems Prt Ltd 205-206, Vardhman Times Plaza, Plot No. 13, Road No. 44, Pitampura, Commercial Complex, New Delhi-110034",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFFffffff),
                                fontFamily: "Poppins-Bold")),
                      ),

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: <Widget>[
                      //     // Text(
                      //     //   "Power By ",
                      //     //   style: TextStyle(fontFamily: "Poppins-Medium"),
                      //     // ),
                      //     InkWell(
                      //       onTap: () {},
                      //       child: Text(
                      //           "Powered by Akhil Systems Prt Ltd 205-206, Vardhman Times Plaza, Plot No. 13, Road No. 44, Pitampura, Commercial Complex, New Delhi-110034",
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               color: Color(0xFFffffff),
                      //               fontFamily: "Poppins-Bold")),
                      //     )
                      //   ],
                      // ),
                    ),
                 // ),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void saveDataForPatient(PatientList IpPatientobject) async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    // CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.loginId, ""+loginId.toString());
//  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.password, ""+password.toString());
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
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.isUserExist, "True");
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.patient_type, IpPatientobject.userType.toString());

    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.IsUnRegPat, IpPatientobject.IsUnRegPat.toString());

    VerifyPatinetList patinetList = new VerifyPatinetList();
    patinetList.registrationId = int.parse(IpPatientobject.regId.toString());
    patinetList.registrationNo = IpPatientobject.regNo;
    patinetList.patientName = IpPatientobject.patientName;
    patinetList.gender = IpPatientobject.gender;
    patinetList.dOB = IpPatientobject.ageYear;
    patinetList.emailId = IpPatientobject.email;
    patinetList.hospitalLocationId = IpPatientobject.hospitalID;
    patinetList.facilityID = IpPatientobject.facilityId;
    patinetList.age = IpPatientobject.age;
    patinetList.encounterId = IpPatientobject.encounterId;
    patinetList.encounterNo = IpPatientobject.encounterId;
    patinetList.patientType = IpPatientobject.userType;
    patinetList.mobileNo = IpPatientobject.mobileNo;

    if (res.patientList!.length > 0) {
      callforMultiple();
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              settings: RouteSettings(name: "/CategoriesPatient"),
              builder: (context) => CategoriesPatient(
                    PatientDetails: patinetList,
                  )),
          (Route<dynamic> route) => false);
    }
  }

  callforMultiple() {
    List<VerifyPatinetList> patientListvalue= <VerifyPatinetList>[];
    for (var i = 0; i < res.patientList!.length; i++) {
      PatientList data = res.patientList!.elementAt(i);
      VerifyPatinetList patinetList = new VerifyPatinetList();
      patinetList.registrationId = int.parse(data.regId.toString());
      patinetList.registrationNo = data.regNo;
      patinetList.patientName = data.patientName;
      patinetList.gender = data.gender;
      patinetList.dOB = data.ageYear;
      patinetList.emailId = data.email;
      patinetList.hospitalLocationId = data.hospitalID;
      patinetList.facilityID = data.facilityId;
      patinetList.age = data.age;
      patinetList.encounterId = data.encounterId;
      patinetList.encounterNo = data.encounterId;
      patinetList.patientType = data.userType;
      patinetList.mobileNo = data.mobileNo;
      patinetList.isUnRegPat = data.IsUnRegPat;
      patientListvalue.add(patinetList);
    }
    /*Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            settings: RouteSettings(name: "/Multi_Patient_list_screen"),
            builder: (context) => Multi_Patient_list_screen(
                  patientList: patientListvalue,
                )),
        (Route<dynamic> route) => false);*/




    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Multi_patient_New(

      )),
    );



  }




  void saveData(VerifyPatinetList IpPatientobject, String isUserExist) async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    // CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.loginId, ""+loginId.toString());
//  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.password, ""+password.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.registration_id,
        "" + IpPatientobject.registrationId.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.registration_no,
        "" + IpPatientobject.registrationNo.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.patient_name,
        "" + IpPatientobject.patientName.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.hospital_id,
        IpPatientobject.hospitalLocationId.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.hospital_name, "PSRI Hospital");
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.facility_id, IpPatientobject.facilityID.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.gender, IpPatientobject.gender.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.age, IpPatientobject.age.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.email, IpPatientobject.emailId.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.encounter_id, IpPatientobject.encounterId.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.encounter_no, IpPatientobject.encounterId.toString());
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
    CommonStrAndKey.galobsharedPrefs!
        .setString(CommonStrAndKey.isUserExist, isUserExist);
    CommonStrAndKey.galobsharedPrefs!.setString(
        CommonStrAndKey.patient_type, IpPatientobject.patientType.toString());
  }

  callApi() async {
    if (validateMobile(mobilevalue) == "") {
      if (mobilevalue.length >= 0) {
        String url = BasicUrl.sendUrl();
        final myService = MyServicePost.create(url);
        PatientLoginRequest setObj = new PatientLoginRequest();
        setObj.mobileNo = "" + mobilevalue;
        setObj.userPassword = "" + passwordvalue;
        setObj.loginBy = "1";
        setObj.deviceTokenNo = firebaseToken.trim();
        print('patient data ${setObj.toJson()}');

        PatientLoginRequest obj =
            new PatientLoginRequest.fromJson(setObj.toJson());
        Response<PatientLoginResponse> response =
            (await myService.MobPatientLogin(obj));
        print(response.body!.toJson());
        var post = response.body;
        res = new PatientLoginResponse.fromJson(post!.toJson());
        if (res.status == "Success") {
          print('Called santi for sucess');
          PatientList patientList = res.patientList!.elementAt(0);
          saveDataForPatient(patientList);
        } else {
          showInSnackBar(res.msg.toString());
        }
      } else {
        showInSnackBar("Please enter password");
      }
    } else {
      showInSnackBar(validateMobile(mobilevalue));
    }
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
    print('calid mobile $valid');
    return valid;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return "";
  }

  Widget LoginInputControls() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: new TextFormField(
            controller: loginId,
            maxLength: 10,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'Mobile',
              hintText: "0000000000",
              // helperText: "blk104",
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
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
            onChanged: (String value) {
              setState(() {
                mobilevalue = value;
              });
            },
            keyboardType: TextInputType.number,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: new TextFormField(
            //obscureText: !_passwordVisible,
            controller: password,
            style: TextStyle(color: Colors.white),
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

              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                child: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
              ),

              ///helperText: "1",
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
            ),
            onChanged: (String value) {
              setState(() {
                passwordvalue = value;
              });
            },
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_passwordVisible,
          ),
        )
      ],
    );
  }

  Widget loginCard() {
    return new Container(
      width: 300,
      height: 250,
      // decoration: BoxDecoration(
      //
      //     borderRadius: BorderRadius.circular(8.0),
      //     boxShadow: [
      //       BoxShadow(
      //           color: Colors.black12,
      //           offset: Offset(0.0, 15.0),
      //           blurRadius: 15.0),
      //       BoxShadow(
      //           color: Colors.black12,
      //           offset: Offset(0.0, -10.0),
      //           blurRadius: 10.0),
      //     ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Login",
                style: TextStyle(
                    color: Colors.white,
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
                child :Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.white,
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

    print(
        "==========================================================================");
    print("Response  \n" + res.toJson().toString());
    if (response != null) {
      Navigator.pop(dialogContext);
        if(response.body!.errorMessage.toString().toLowerCase()=="true")
         {
           ctrforgetpassward.clear();
           Navigator.of(context).pop();
        /*_scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body.password.toString()),
          duration: Duration(seconds: 7),
        ));*/

    //showAlerDialog(DialogType.SUCCES, 'Info', "Successfully changed your password",false);
      } else {
        /* forgetpasswardKey.currentState.showSnackBar(
            SnackBar(
              content: Text("" + response.body.errorMessage.toString(),style: TextStyle(color: Colors.white),),
              duration: Duration(seconds: 1),
            ));*/
         // Navigator.of(context).pop();
          ctrforgetpassward.clear();
          Navigator.of(context).pop();
          _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text("" + response.body!.password.toString()),
            duration: Duration(seconds: 7),
          ));
         /* showAlerDialog(
              DialogType.ERROR, 'Error', "Do not change your password", false);*/
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
                    maxLength: 10,
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



}
