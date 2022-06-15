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

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PatientProfileUpdateResponse.dart';

const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

String patientName = "",
    mobileNo = "",
    email = "",
    registration = "",
    oldPassword = "",
    newPassword = "",
    ConformedPW = "";
late BuildContext confContext,loadingContext,layoutContext;
PatientProfileUpdateResponse res = new PatientProfileUpdateResponse();
var ctrName = TextEditingController();
var ctrOldPW = TextEditingController();
var ctrNewPW = TextEditingController();
var ctrConformedPW = TextEditingController();
var ctrMobile = TextEditingController();
var ctrEmail = TextEditingController();

class Profile extends StatefulWidget {
  String? DoctorId = "";

  Profile({
    this.DoctorId,
    Key? key,
  }) : super(key: key);

  @override
  ProfileState createState() => ProfileState(
        DoctorId: this.DoctorId,
      );
}

class ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _currentAddress = "";
  String? DoctorId = "";

  ProfileState({
    this.DoctorId,
  });

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ctrName.text = "";
    ctrEmail.text = "";
    ctrMobile.text = "";
    ctrOldPW.text = "";
    ctrNewPW.text = "";
    ctrConformedPW.text = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    getDataSharePre();
    layoutContext=context;
    return layout(context);
  }

  Widget layout(BuildContext context) {

    return Scaffold(

      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile ',
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
      body: new Center(
        child: new Container(
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
              color: Color(CompanyColors.grey),
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
                child: new Container(
                  child: new Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/profilehelpingx.png',
                          width: double.maxFinite,
                          height: double.maxFinite,
                        ),
                        new Center(
                            child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 120.0,
                              height: 120.0,
                              child: new SvgPicture.asset(
                                'assets/images/user_profile.svg',
                                height: 120,
                                width: 120,
                                fit: BoxFit.fill,
                              ),

                              /*decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                "https://i.imgur.com/tz8PJJR.jpg")))*/
                            ),
                            new Align(
                              alignment: Alignment.center,
                              child: new Text(
                                "       " + patientName,
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                      ]),
                ),
                flex: 35,
              ),
              Expanded(
                flex: 65,
                child: new Container(
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: new TextFormField(
                            enabled: false,
                            controller: ctrName,
                            decoration: InputDecoration(
                              labelText: 'Name',
                             hintText: "Name",
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
                              //setState(() => doctorId = value);
                              //  mobileNo = value;
                            },
                          ),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                          child: new TextFormField(
                            enabled: false,
                            controller: ctrMobile,
                            decoration: InputDecoration(
                              labelText: 'Mobile No.',
                              hintText: mobileNo,
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
                              //setState(() => doctorId = value);
                              //  mobileNo = value;
                            },
                          ),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrEmail,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: email,
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
                              // email = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrOldPW,
                            enabled: false,
                            decoration: InputDecoration(
                              labelText: 'UHID',
                              hintText: oldPassword,
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
                              // email = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                       /* new Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            controller: ctrOldPW,
                            //obscureText: !_passwordVisible,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Old Password',
                              hintText: "Password",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.lock),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              oldPassword = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrNewPW,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              hintText: "New Password",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.lock_open),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              newPassword = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                          child: new TextFormField(
                            //obscureText: !_passwordVisible,
                            controller: ctrConformedPW,
                            enabled: true,
                            decoration: InputDecoration(
                              labelText: 'Confirmed Password',
                              hintText: "Confirmed Password",
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6.0)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(top: 5), // add padding to adjust icon
                                child: Icon(Icons.lock_open),
                              ),
                            ),

                            keyboardType: TextInputType.text,
                            onChanged: (String value) {
                              newPassword = value;
                              //(() => password = value);
                            },
                          ),
                        ),
                        new Container(
                          width: 270,
                          height: 50,
                          margin: EdgeInsets.only(top: 10),
                          child: InkWell(
                            child: Container(
                              width: 290,
                              height: 50,
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
                                    if (validation(
                                        ctrOldPW.text.toString(),
                                        ctrNewPW.text.toString(),
                                        ctrConformedPW.text.toString())) {
                                      _ConformationOfAppointment(
                                          "You are sure to change password?");
                                    }
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
                        ),*/

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


                            if(validation(ctrOldPW.text.toString(),ctrNewPW.text.toString(),ctrConformedPW.text.toString())) {
                              _ConformationOfAppointment("You are sure to password?");
                            }
                          },


                        ),),*/
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
        confContext=context;
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

  bool validation(
    String oldPasswordStr,
    String newPasswordStr,
    String confirmedStr,
  ) {
    bool valid = true;
    String toastMsg = "";
    if (oldPasswordStr == "" ||
        oldPasswordStr == "null" ||
        oldPasswordStr == null) {
      valid = false;
      toastMsg = "Please enter old password";
    } else if (newPasswordStr == "" ||
        newPasswordStr == "null" ||
        newPasswordStr == null) {
      valid = false;
      toastMsg = "Please enter new password";
    } else if (confirmedStr == "" ||
        confirmedStr == "null" ||
        confirmedStr == null) {
      valid = false;
      toastMsg = "Please enter confirmed password";
    } else if (newPasswordStr != confirmedStr) {
      valid = false;
      toastMsg = "New password and confirmed password is not match ";
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
        loadingContext=context;
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
   /* new Future.delayed(new Duration(seconds: 4), () {
      //pop dialog
      Navigator.pop(context);
      Navigator.pop(context);
    });*/
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

  Future callApi(BuildContext context) async {
    Navigator.pop(confContext);
    _onLoading();
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    PatientProfileUpdate setObj = new PatientProfileUpdate();
    setObj.firstName = "" + patientName;
    setObj.middleName = "";
    setObj.lastName = "";
    setObj.email = "" + email;
    setObj.mobileNo = "" + mobileNo;
    setObj.regNo = "" + registration;
    setObj.password = "" + ctrNewPW.text.toString();
    setObj.oldPassword = "" + ctrOldPW.text.toString();
    // setObj.mobileNo="9910068478";
    // setObj.userPassword="1715";
    //setObj.loginBy="1";

    PatientProfileUpdate obj =
        new PatientProfileUpdate.fromJson(setObj.toJson());
    Response<PatientProfileUpdateResponse> response =
        (await myService.MobPatientProfile(obj));
    print(response.body);
    var post = response.body;
    res = new PatientProfileUpdateResponse.fromJson(post!.toJson());

       Navigator.pop(loadingContext);
       if (response != null) {
         if (response.body!.status.toString().toLowerCase().contains("success")||response.body!.status.toString().toLowerCase().contains("true")) {
           showAlerDialog(DialogType.SUCCES, 'Info', response.body!.msg,true);
         } else {
           showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg,false);
         }
       }
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
    oldPassword =
        CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ?? '';

        '';
    ctrMobile.text = mobileNo;
    ctrEmail.text = email;
    ctrName.text = patientName;
    ctrOldPW.text = oldPassword;
  }

}
