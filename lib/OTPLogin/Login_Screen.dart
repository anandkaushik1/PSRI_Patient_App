import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chopper/chopper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/OTPLogin/LoginRequestOTP.dart';
import 'package:flutter_patient_app/OTPLogin/LoginResponseOTP.dart';
import 'package:flutter_patient_app/OTPLogin/Login_With_Otp.dart';
import 'package:flutter_patient_app/PatientLogin_pack/Login_patient.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/Patient_Registration.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/Patient_Registration_new.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/CanferenceCall.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/Video_Call/utils/settings.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late BuildContext loaderContext;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Login_Screen extends StatefulWidget {
  Login_Screen({Key? key}) : super(key: key);

  @override
  _CardGridScreenState createState() => _CardGridScreenState();
}

var ctrMobileNo = new TextEditingController();
var ctrCountryCode = new TextEditingController();
String selectDropDownValue = "+91";

class _CardGridScreenState extends State<Login_Screen> {
  List<String> added = [];
  String currentText = "";
  TextEditingController _textFieldController = TextEditingController();
  String _charEntered = '';
  int count = 0;

  //FocusNode textSecondFocusNode = new FocusNode();
  _CardGridScreenState({Key? key});

  /*_onChanged(String value) {
    setState(() {
      _charEntered = value.split("").last;
      count++;
      if(count==3)
        {
          //FocusScope.of(context).requestFocus(textSecondFocusNode);
        }

    });
  }*/

  void appstatus() async
  {

    print("loginsfffthththth===");
    CommonStrAndKey.galobsharedPrefsInstaledApp = await SharedPreferences.getInstance();
  /*  String alreadyLogin =
        CommonStrAndKey.galobsharedPrefsInstaledApp!.getString(CommonStrAndKey.appstatus) ??"";
    print("loginsfffthththth==="+alreadyLogin.toString());
    if(alreadyLogin!="first") {
      if(alreadyLogin!="third") {
        CommonStrAndKey.galobsharedPrefsInstaledApp!.setString(
            CommonStrAndKey.appstatus, "sec");
        String alreadyLogin =
            CommonStrAndKey.galobsharedPrefsInstaledApp!.getString(CommonStrAndKey.appstatus) ??"";
        print("loginsfffthththth==="+alreadyLogin.toString());
      }
    }*/

  }

  @override
  void initState(){
    ctrMobileNo.text = "";

    appstatus();
  }

  @override
  void dispose(){
    ctrMobileNo.text = "";

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(CompanyColors.appbar_color),
      /* appBar: AppBar(
                centerTitle: true,

      title: Text('Categroies',style: TextStyle(fontSize: 16.0),),

    ),*/
      body: new Container(
        child: new Stack(
          children: <Widget>[
            Image.asset(
              'assets/New_Icons/background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  // 'assets/New_Icons/child_logo.png',
                  // height: 100,
                  // width: 100,
                  //'assets/New_Icons/akhil_icon.png',
                  'assets/New_Icons/Logo.png',
                  height: 300,
                  width:300,
                ),
              ),
            ),
            new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 30,
                      child: Text(""),
                    ),
                    Expanded(
                      flex: 40,
                      child: Column(
                        children: [
                          new Container(
                            child: Align(
                              child: new Text(
                                "Enter your mobile number",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
                          ),
                          new Container(
                            height: 60,
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.fromLTRB(30, 9, 30, 0),
                            padding: EdgeInsets.only(bottom: 0),
                            child: TextField(
                              controller: ctrMobileNo,
                              autocorrect: true,
                              maxLength: 10,
                              maxLines: 1,

                              // focusNode: textSecondFocusNode,
                              style: TextStyle(
                                color: Colors.white,
                                height: 0.1,
                              ),
                              textAlign: TextAlign.left,

                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                //hintText: 'Type Text Here',
                                contentPadding: EdgeInsets.only(bottom: 0),

                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white70,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      style: BorderStyle.solid),
                                ),
                              ),
                            ),
                          ),
                          new Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                            child: new RaisedButton(
                              color: Color(CompanyColors.button_color_new),
                              textColor: Colors.black,
                              splashColor: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(6.0),
                                  side: BorderSide(
                                      color: Color(CompanyColors.appbar_color))),
                              child: Text(
                                'Send OTP',
                                style: TextStyle(
                                  background: Paint()
                                    ..color = Colors.transparent,
                                  fontWeight: FontWeight.bold,
                                  // decoration: TextDecoration(BlendMode.color))
                                ),
                              ),
                              onPressed: () {
                                if (validation(
                                    selectDropDownValue, ctrMobileNo.text)) {
                                  callApi(context);
                                }
                              },
                            ),
                          ),
                          new Text(
                            "---------- OR ----------",
                            style: TextStyle(color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // signup code goes here
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                                          builder: (BuildContext context)=> Patient_Registration_new()));
                                    },
                                    child: new Text("Signup",
                                        style: TextStyle(color: Colors.white))),
                                Container(
                                  height: 20,
                                  width: 1,
                                  color: Colors.white,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Login_patient()));
                                    },
                                    child: new Text("Login with password",
                                        style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validation(String CountryCode, String MobileNo) {
    bool valid = true;
    String toastMsg = "";
    if (MobileNo == "" || MobileNo == "null" || MobileNo == null) {
      valid = false;
      toastMsg = "Please enter mobile no";
    } else if (MobileNo.length < 10) {
      valid = false;
      toastMsg = "Please enter valid mobile no";
    }
    if (!valid) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg),
        duration: Duration(seconds: 3),
      ));
    }
    return valid;
  }

  Future callApi(BuildContext context) async {
    _onLoading(context);
    try {
      String url = BasicUrl.sendUrl();
      final myService = MyServicePost.create(url);
      LoginRequestOTP setObj = new LoginRequestOTP();
      setObj.mobileNo = "" + ctrMobileNo.text.toString();

      LoginRequestOTP obj = new LoginRequestOTP.fromJson(setObj.toJson());
      print(
          "==========================================================================");
      print("Request  \n" + setObj.toJson().toString());
      Response<LoginResponseOTP> response =
      (await myService.GenerateOTPForPatientOTP(obj));

      var post = response.body;
      LoginResponseOTP res = new LoginResponseOTP.fromJson(post!.toJson());
      print("Response"+res.toJson().toString());
      if (response != null) {
        /// Navigator.pop(context);
        if (response.body!.status!.toString().toLowerCase() == "true") {
          if (response.body!.status != null) {
            // if(response.body.status.length==1) {
            /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => CategoriesPatient(
                  pos: ,
                )));*/

            Navigator.pop(loaderContext);
            // Navigator.of(loaderContext).pop(false);
            Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: "/Login_With_Otp"),
                  builder: (context) => Login_With_Otp(
                    data: res,
                    otp: res.oTPno.toString(),
                  )),
            );

            /*_scaffoldKey.currentState.showSnackBar(
                SnackBar(
                  content: Text("" + response.body.msg.toString()),
                  duration: Duration(seconds: 1),
                ));*/
          }
        } else {
          Navigator.pop(loaderContext, true);
          _scaffoldKey.currentState!.showSnackBar(SnackBar(
            content: Text("" + response.body!.errorMessage.toString()),
            duration: Duration(seconds: 1),
          ));
        }
      } else {
        Navigator.pop(loaderContext, true);
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body!.errorMessage.toString()),
          duration: Duration(seconds: 1),
        ));
      }
    } catch (e) {
      print(
          "*******************************************************************************\n\n");
      print(
          "=====================================Server Issue==============================\n\n");
      print(
          "*******************************************************************************\n");
    }
  }
}

void _onLoading(BuildContext pcontext) {
  showDialog(
    context: pcontext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      loaderContext = context;
      return Theme(
        data: Theme.of(context)
            .copyWith(dialogBackgroundColor: Colors.transparent),
        child: Dialog(
            child: new Container(
              height: 100,
              width: 100,
              color: Colors.transparent,
              child: new Center(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Container(
                        color: Colors.transparent,
                        child: SpinKitFadingCircle(
                            size: 51.0, color: Color(0xffffffff))),
                    new Text(
                      "Please wait...",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
            )),
      );
    },
  );
  /* new Future.delayed(new Duration(seconds: 3), () {
      //pop dialog
      Navigator.pop(pcontext);
      Navigator.push(
        pcontext,
        MaterialPageRoute(builder: (context) => Login_Screen()),
      );
    });*/
}
