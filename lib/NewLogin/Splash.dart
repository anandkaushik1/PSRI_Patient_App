
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/TokenModel.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/NewLogin/Login_patient.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/UpdateRequest.dart';
import 'package:flutter_patient_app/NewLogin/Model/UpdateResponse.dart';
import 'package:flutter_patient_app/OTPLogin/Login_Screen.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/SQLiteDbProvider.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/Video_Call/utils/settings.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_patient_app/utils/connectivity_service.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


ClientRole? _role = ClientRole.Broadcaster;
RtcEngine? _engine;
class  Splash extends StatefulWidget {
  static  String dynamicToken="";
  late BuildContext mcontext;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<Splash> {
  bool issaved = false;
  bool isconnected=true;
  late BuildContext mcontext,confContext;
  @override
  void initState() {
    super.initState();
    initialize();
    //forGetAuthToken();
    //alreadyLoginOrNot();
    SQLiteDbProvider.db.getAllProducts();

  }
  Future<void> initialize() async {
    _engine = await RtcEngine.create(APP_ID);
  }
  @override
  Widget build(BuildContext context) {
    mcontext=context;
    return   FutureBuilder<UpdateResponse>(
      future: callApi('${""}'), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<UpdateResponse> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return layout(context);
        } else {
          if (data.hasError) {
            return layout(context);
          }
          else if (data.requireData == null) {
            return layout(context);
          } else {
            return layout(context);
          }
        }
      },
    );
  }

  Widget layout(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Color(CompanyColors.appbar_color),
      body:

      new Container(
        child: new Stack(
          children: <Widget>[

            /*Image.asset('assets/images/background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
*/
            new Container(
              margin:EdgeInsets.fromLTRB(20, 270, 20, 100) ,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome\nPSRI Hospital",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                    textScaleFactor: 1,
                    //Venkateshwar
                  )
              ),
            ),
            /*  new Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Patient Care App',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(CompanyColors.Text_poweredby))),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
  Future alreadyLoginOrNot() async {
    /* bool isconnectedvalue = await CheckInterNet.internetConnectivity();
    setState(() {
      isconnected = isconnectedvalue;
    });*/
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String gettoken =
        CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
            '';
    String accessToken =
        CommonStrAndKey.galobsharedPrefs!.getString("accessToken") ??
            '';
    Splash.dynamicToken=accessToken;

    print('hello  is coneedted value is  :$isconnected');
    if (isconnected) {
      if (gettoken != null && gettoken.length > 0) {
        // showDashboard();
        showDashboardFF();
        /*Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => CategoriesPatient()));*/
      } else {
        var url = BasicUrl.sendUrlToken();

        Map<String, dynamic> body = {
          'UserName': 'user',
          'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q=',
          'grant_type': 'password'
        };
        Uri myurl =Uri.parse(url);
        final response = await http.post(myurl,
            body: body,
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            encoding: Encoding.getByName("utf-8"));

        if (response.statusCode == 200) {
          print('respose code ${response.statusCode}');
          // If the call to the server was successful, parse the JSON
          print(response.body);
          var tokenModel = TokenModel.fromJson(json.decode(response.body));
          if (tokenModel != null) {
            if (tokenModel.accessToken != null) {
              String strToken =
                  tokenModel.tokenType.toString() + " " + tokenModel.accessToken.toString();
              saveData(strToken);
            }
          }
        } else {
          // If that call was not successful, throw an error.
          throw Exception('Failed to load post');
        }
      }
    } else {
      // no internet value found
    }
  }

  getCenterWidgit() {
    if (isconnected == null) {
      return Center(
          child: Text(
            "Welcome\nPSRI Hospital",textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20,decoration:TextDecoration.none),
            textScaleFactor: 1,
            //Venkateshwar
          ));
    } else if (isconnected) {
      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_QlSUvE.json',
                  height: 100,
                  width: 100),*/

              Text(
                "Welcome\nPSRI Hospital ",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20,decoration:TextDecoration.none),
                textScaleFactor: 1,
                //Venkateshwar
              ),
            ],
          ));
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.signal_cellular_connected_no_internet_4_bar,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            Text('No internet! Please check your internet connection',
                style: TextStyle(color: Colors.white, fontSize: 40)),
          ],
        ),
      );
    }
  }

  showLoginView() {
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(mcontext).pushAndRemoveUntil(
            MaterialPageRoute(
                settings: RouteSettings(name: "/Login_patient"),
                builder: (context) => Login_Screen()),
                (Route<dynamic> route) => false));
  }

  showDashboardFF()  async {
    SQLiteDbProvider.db.getAllProducts();
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String my_patientName = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ?? '';
    String my_mobileNo = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobileNo) ?? '';
    String my_email = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.email) ?? '';
    String my_mobile = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobile_no) ?? '';
    String my_hISRegistrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    String my_hospitalID = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
    String my_facilityId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ?? '';
    String my_encounterId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_id) ?? '';
    // String my_role = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    String my_age = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.age) ?? '';

    //String my_userType = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_type) ?? '';
    String my_gender = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.gender) ?? '';
    String my_firstName = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ?? '';
    //  String my_middleName = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    // String my_lasttName = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    //  String my_errorMessage = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    //   String my_uHIDMSG = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';



    String my_ageDays = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.age) ?? '';
    String my_regNo = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ?? '';
    String my_regId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    //  String my_titleId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    // String my_isUnRegPat = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    // String my_videoConsultationCode = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';




    // PatientList selectedPatient=new PatientList();
    VerifyPatinetList selectedPatient=new VerifyPatinetList();
    selectedPatient.patientName=""+my_patientName.toString();
    selectedPatient.mobileNo=""+my_mobileNo.toString();
    selectedPatient.emailId=""+my_email;
    //selectedPatient.imagePath=""+my_imagePath;
    selectedPatient.registrationId=(int.parse(my_hISRegistrationId.toString()));
    selectedPatient.hospitalLocationId=""+my_hospitalID;
    selectedPatient.facilityID=""+my_facilityId;
    selectedPatient.encounterId=""+my_encounterId;
    //selectedPatient.role=""+my_role;


    selectedPatient.age=""+my_age;
    //selectedPatient.userType=""+my_userType;
    selectedPatient.gender=""+my_gender;
    selectedPatient.patientName=""+my_firstName;
    // selectedPatient.middleName=""+my_middleName;
    // selectedPatient.lasttName=""+my_lasttName;
    //selectedPatient.errorMessage=""+my_errorMessage;
    selectedPatient.registrationId=int.parse(my_hISRegistrationId.toString());


    selectedPatient.age=""+my_ageDays;
    selectedPatient.registrationNo=""+my_regNo;
    selectedPatient.registrationId=int.parse(my_regId.toString());
    //selectedPatient.titleId=1;
    //selectedPatient.isUnRegPat=false;
    //selectedPatient.vi=""+my_videoConsultationCode;


    Timer(
        Duration(seconds: 4),
            () {
          if (!CommonStrAndKey.isLaunchMode) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    settings: RouteSettings(name: "/CategoriesPatient"),
                    builder: (context) =>
                        CategoriesPatient(
                          PatientDetails: selectedPatient,
                          pos: 0,
                        )),
                    (Route<dynamic> route) => false);
          }
        }
    );
  }

  void saveData(String accessToken) async
  {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("accessToken", accessToken);
    Splash.dynamicToken=accessToken;

    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registration_id =
        CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
            '';
    if (registration_id != null && registration_id.length > 0) {
      showDashboardFF();
    }else {
      Timer(
          Duration(seconds: 1),
              () =>
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => Login_Screen())));
    }

  }

  Future forGetAuthToken() async {


    var url = BasicUrl.sendUrlToken();

    Map<String, dynamic> body = {
      'UserName': 'user',
      'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q=',
      'grant_type': 'password'
    };
    Uri myurl =Uri.parse(url);
    final response = await http.post(myurl,
        //body: body,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8")
    );

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      print(response.body);
      var tokenModel= TokenModel.fromJson(json.decode(response.body));
      if(tokenModel!=null)
      {
        if(tokenModel.accessToken!=null)
        {
          String strToken=tokenModel.tokenType.toString()+" "+tokenModel.accessToken.toString();
          saveData(strToken);
        }
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }


  Future<UpdateResponse> callApi(String r) async {
    String url = BasicUrl.sendVersionUrl();
    final myService = MyServicePost.create(url);
    UpdateRequest req = new UpdateRequest();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String versionName = packageInfo.version;
    String versionode = packageInfo.buildNumber;
    req.hospitalId = "1";
    req.packageName = packageName.trim();
    //req.versionCode =int.parse("10");
    req.versionCode = int.parse(versionode);

    req.versionName = versionName;

    print("Request  \n" + req.toJson().toString());
    print("aaaaaaaaaaaaaaaaaa"+versionode);
    UpdateRequest objj = new UpdateRequest.fromJson(req.toJson());
    Response<UpdateResponse> responserrr =
    (await myService.GetversionStatus(objj));
    var postt = responserrr.body;
    print("bbbbbbbbbbbbbbbbbbbbbbb");

    UpdateResponse res = new UpdateResponse.fromJson(postt!.toJson());
    print(res.toJson().toString());

    if(res.status.toString().toLowerCase().trim()=="updated version")
    {
      //alreadyLoginOrNot(true);
      // forGetAuthToken();
      alreadyLoginOrNot();
      print("cccccccccccccccccccccccccccc");

    }else
    {
      versionpopup(context);
      print("ddddddddddddddddddddddddddd");

    }

    return Future.value(res);
  }


  Future<void> versionpopup(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;

    String packageName = packageInfo.packageName;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        confContext = context;
        return AlertDialog(
          title: Text('Update App?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("A new version of "+appName+" is available! \n"),
                Text("Would you like to update it now"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Update Now'),
              onPressed: () {
                launchURL(packageName);
                //exit(0);
              },
            ),

          ],
        );
      },
    );
  }

  launchURL(String mypackage) async {
    // com.aks.akhildemo
    String url = "https://play.google.com/store/apps/details?id="+mypackage;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



}


/*class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                //foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }


}*/

/*class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}*/

/*class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 3),
          ColorTween(begin: Color(CompanyColors.appbar_color), end: Color(CompanyColors.appbar_color))),
      Track("color2").add(Duration(seconds: 3),
          ColorTween(begin: Color(CompanyColors.appbar_color), end: Color(CompanyColors.appbar_color)))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}*/

class CenteredText extends StatelessWidget {
  const CenteredText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          "Welcome\nPSRI Hospital",textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20,decoration:TextDecoration.none),
          textScaleFactor: 1,
          //Venkateshwar
        ));
  }

/*  Future<HttpClientResponse> foo() async {
    Map<String, dynamic> jsonMap = {
      'homeTeam': {'UserName': 'user'},
      'awayTeam': {'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q='},
      'awayTeam': {'grant_type': 'password'},
    };
    String jsonString = json.encode(jsonMap); // encode map to json
    String paramName = 'param'; // give the post param a name
    String formBody = paramName + '=' + Uri.encodeQueryComponent(jsonString);
    List<int> bodyBytes = utf8.encode(formBody); // utf8 encode
    HttpClientRequest request =
    await _httpClient.post(_host, _port, '/a/b/c');
    // it's polite to send the body length to the server
    request.headers.set('Content-Length', bodyBytes.length.toString());
    // todo add other headers here
    request.add(bodyBytes);
    return await request.close();
  }*/

}

void getData() async
{
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String myAccessToken=sharedPrefs.getString("accessToken") ?? 'not find';
  String test=myAccessToken;
}








