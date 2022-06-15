import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Multi_Patient/Multi_patient_New.dart';
import 'package:flutter_patient_app/OTPLogin/LoginResponseOTP.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpRequestOTP.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientLogin_pack/Multi_Patient_list_screen.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

late BuildContext loaderContext,dialogContext;
String _chosenValue = "";
String firebaseToken="";

var ctrOtp = new TextEditingController();

class Login_With_Otp extends StatefulWidget {

  LoginResponseOTP? data;
  String? otp;
  String? button;
  Login_With_Otp({this.data, this.otp, this.button,  Key? key}) : super(key: key);

  @override
  _CardGridScreenState createState() =>
      _CardGridScreenState(data: data, otp: otp, button: button);
}

class _CardGridScreenState extends State<Login_With_Otp> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginResponseOTP? data;
  String? otp;
  String? button;
  _CardGridScreenState({this.data, this.otp,this.button ,Key? key});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    firebaseToken="";
    FirebaseMessaging.instance.getToken().then((value) {
      print(token);
      firebaseToken = value!;
    });
    ctrOtp.text = "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // ctrOtp.text = "";
  }

  @override
  Widget build(BuildContext context) {
    dialogContext=context;
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown]);
          return layout(true, data!);

   // return callBackApiResponse("",context);
  }

  Widget layout(bool flg,LoginResponseOTP myData)
  {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:  Colors.blue,
      /* appBar: AppBar(
                centerTitle: true,
            title: Text('Categroies',style: TextStyle(fontSize: 16.0),),
             ),*/
      body:  new Container(
        child:  new Stack(

          children: <Widget>[
            Image.asset('assets/New_Icons/background.png',

              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/ 1.2,
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

                  SizedBox(
                    height: 50,
                  ),
                  new Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 25,
                            child: Text(""),
                          ),
                          Expanded(
                            flex: 20,
                            child: Text(""),
                          ),
                          Expanded(
                            flex: 40,
                            child: Column(
                              children: [
                                new Container(
                                //  child: forRegistration(myData.verifyPatinetList),

                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(30, 5, 30, 0),
                                  child: Column(
                                    children: [
                                      Align(
                                        child: new Text(
                                          "Verify OTP",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        alignment: Alignment.centerLeft,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Align(
                                          child: new Text(
                                            "Please enter OTP sent to " +
                                                data!.mobileNo.toString(),
                                              /* + " with verification code." +
                                                "( " +
                                                otp.toString() +
                                                " )",*/
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                                  child: new Row(
                                    children: [
                                      Expanded(
                                        flex: 100,
                                        child: new Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(left: 10),
                                            child: Align(
                                              child: Container(
                                                width: 180,
                                                child: TextField(
                                                  autocorrect: true,
                                                  controller: ctrOtp,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    letterSpacing: 20,
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,

                                                  keyboardType:
                                                  TextInputType.number,
                                                  //maxLength:4 ,

                                                  decoration: InputDecoration(
                                                    //hintText: 'Type Text Here',
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: Colors.white70,
                                                        style:
                                                        BorderStyle.solid,
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          style: BorderStyle
                                                              .solid),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                new Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  margin: EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: new RaisedButton(
                                      color: Color(CompanyColors.grey),
                                      textColor: Colors.black,
                                      splashColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(6.0),
                                          side: BorderSide(
                                              color: Colors.lightBlueAccent)),
                                      child: Text(
                                        'Done',
                                        style: TextStyle(
                                          background: Paint()
                                            ..color = Colors.transparent,
                                          fontWeight: FontWeight.bold,
                                          // decoration: TextDecoration(BlendMode.color))
                                        ),
                                      ),
                                      onPressed: () {
                                        if (validation(ctrOtp.text.toString())) {
                                          callApi(context);

                                        }
                                      }
                                ),
                                ) ]
                                  ,
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
  void toast(BuildContext context) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("nbbm" + otp.toString()),
      duration: Duration(seconds: 13),
    ));
  }

  bool validation(String OTPCode) {
    bool valid = true;
    String toastMsg = "";
    /* if (OTPCode == "" || OTPCode == "null" || OTPCode == null) {
      valid = false;
      toastMsg = "Please enter OTP";
    } else */if (OTPCode == "" || OTPCode == "null" || OTPCode == null) {
      valid = false;
      toastMsg = "Please enter OTP";
    } else if (OTPCode.length < 3) {
      valid = false;
      toastMsg = "Please enter valid OTP ";
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
    _onLoading(dialogContext);
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    VerifyOtpRequestOTP setObj = new VerifyOtpRequestOTP();
    setObj.mobileNo = data!.mobileNo.toString();
    setObj.oTP = "" + ctrOtp.text.toString();
    setObj.deviceTokenNo=firebaseToken.trim();
    VerifyOtpRequestOTP obj = new VerifyOtpRequestOTP.fromJson(setObj.toJson());
    print("==========================================================================");
    print("Request  \n" + setObj.toJson().toString());
    print("==========================================================================");
    Response<VerifyOtpResponseOTP> response =
    (await myService.VerifyPatientOTP(setObj));

    var post = response.body;
    VerifyOtpResponseOTP res = new VerifyOtpResponseOTP.fromJson(post!.toJson());
    print("///////////////////////////////////////////");
    print("Respone   \n"+res.toJson().toString());
    print("//////////////////////////////////");

    if (response != null) {
      /// Navigator.pop(context);
      Navigator.pop(dialogContext);
      if (response.body!.status.toString().toLowerCase() == "success" || response.body!.status!.toString().toLowerCase()=="true") {
        saveData(res.verifyPatinetList!.elementAt(0),res.isUserExist.toString());

        if(res.verifyPatinetList!.length==1)
        {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  settings:
                  RouteSettings(name: "/CategoriesPatient"),
                  builder: (context) => CategoriesPatient(
                    PatientDetails: res.verifyPatinetList!.elementAt(0),
                  )),
                  (Route<dynamic> route) => false);

        }else
        {
          /*Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                settings:
                RouteSettings(name: "/Multi_Patient_list_screen"),
                builder: (context) => Multi_Patient_list_screen(
                  patientList: response.body.verifyPatinetList,

                )),
                (Route<dynamic> route) => false);*/
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Multi_patient_New(

            )),
          );

        }

        _scaffoldKey.currentState!.showSnackBar(
            SnackBar(
              content: Text("" + response.body!.msg.toString()),
              duration: Duration(seconds: 3),
            ));
      } else {
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
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitFadingCircle(size: 71.0, color: Color(0xff37b5ff)));
  }

}




void _onLoading(BuildContext pcontext) {
  showDialog(
    context: pcontext,
    barrierDismissible: false,
    builder: (BuildContext context) {
      loaderContext=context;
      return   Theme(
        data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),

        child: Dialog(
            child: new Container(
              height: 100,
              width: 100,
              color:Colors.transparent,

              child: new Center(

                child:  new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new Container(
                        color: Colors.transparent,
                        child: SpinKitFadingCircle(size: 51.0, color: Color(0xffffffff))),
                    new Text("Please wait...",style: TextStyle(fontSize: 25 ,color: Colors.white),),
                  ],
                ),
              ),
            )


        ),);
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
void saveData(VerifyPatinetList IpPatientobject,String isUserExist) async
{

  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
 // CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.loginId, ""+loginId.toString());
//  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.password, ""+password.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.registration_id, ""+IpPatientobject.registrationId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.registration_no, ""+IpPatientobject.registrationNo.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.patient_name, ""+IpPatientobject.patientName.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.hospital_id, IpPatientobject.hospitalLocationId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.hospital_name, "PSRI Hospital");
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.facility_id, IpPatientobject.facilityID.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.gender, IpPatientobject.gender.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.age, IpPatientobject.age.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.email, IpPatientobject.emailId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.encounter_id, IpPatientobject.encounterId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.encounter_no, IpPatientobject.encounterId.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.isUserExist, isUserExist);
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.patient_type, IpPatientobject.patientType.toString());
  CommonStrAndKey.galobsharedPrefs!.setString(CommonStrAndKey.IsUnRegPat, IpPatientobject.isUnRegPat.toString());

}

