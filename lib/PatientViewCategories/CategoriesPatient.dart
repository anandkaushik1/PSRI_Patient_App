import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/OTPLogin/Login_Screen.dart';
import 'package:flutter_patient_app/OTPLogin/UpdateTokenRequest.dart';
import 'package:flutter_patient_app/OTPLogin/UpdateTokenResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientViewCategories/Categories_emptycard.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Card_List.dart';
import 'package:flutter_patient_app/SQLiteDbProvider.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleSpecialisationAndDoctorList.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/CanferenceCall.dart';
import 'package:flutter_patient_app/Video_Call/pages/MySAWVideocallScreen.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/Video_Call/utils/settings.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';


var titleName;
late BuildContext loaderContext;
ClientRole? _role = ClientRole.Broadcaster;
RtcEngine? _engine;
late BuildContext layoutContext, confContext;
final List<String> imgList = [
  'https://chi01pap002files.storage.live.com/y4m08kePr9tirIfjoMz6-f-I1zQJ0z46u_1dRp6xvGHVAbWS7YEQJKrbKxh1y9svMmETEMsOL83-avy10tBjoTeEQc7cDZzr_7sm1ZByU64OFa-iyf2GVPz4zYW_6EqGkGmBy6_QC2sUIXrUoKq467ei5XO5LFyxgy2aGCmOKol1UE63UpyhSfE4d58lmuMyi-5?width=2000&height=1238&cropmode=none',
  'https://chi01pap002files.storage.live.com/y4mejDpUuw8O081QFFuD_7zkQZgphvgcJC57tSso3lju20n__knPqb5AiOT6Y0ckAi2AmRef-iJ0l9wCUdTWvTVRJURa6mpBXBFNgtMGiK4WLZLV_zORU0_RIydiuhFE3ldsO7BPFnz3OSJP7y2X_smaNaFb3ndg4Y9picHcPbjYcfJYdOvxR9ygR8IVNCzySOr?width=10206&height=7087&cropmode=none',
  'https://chi01pap002files.storage.live.com/y4mk6NluN9ucJ_x_EtbN1BLRPEQoneQ5pREq9xEY2wcK6gZUbEI7iOcCDM3JElYSaYQQ4ywVlbMPAP7sEVwG3hMqVF_d2S5MBvvKlySkXm1tRbttR1DlKbcDTftUxfAXIog2gIEi_tHmHhsu5qjluOeZBPsrziWV5fghWBxW04-Yu5CHOihrf448AtbmuM7fVpc?width=6643&height=4095&cropmode=none',
  'https://chi01pap002files.storage.live.com/y4mYnki-yI1N0xfxuCbF6IBdjHlnGZCrlypdqw0fa0YbkUX9_55gnMhdtwKK8bMmgZbLf7uFw8WVbJDNTjAUcaY1SpBtcryyashr9FqwKgekA9QC5RgyGtkAk3_f2446AntRVqBvt6zXv_kC6_C_HCEXzlL1wdjmNHK279kJ8zVrEAst74408PwZr0mM3oKf7rM?width=5184&height=3456&cropmode=none',
];

class CategoriesPatient extends StatefulWidget {
  VerifyPatinetList? PatientDetails;
  int? pos;

  CategoriesPatient({this.PatientDetails, this.pos, Key? key}) : super(key: key);

  @override
  CategoriesPatientScreenState createState() => CategoriesPatientScreenState(
        PatientDetails:  this.PatientDetails,
        pos: this.pos,
      );
}

class CategoriesPatientScreenState extends State<CategoriesPatient>with WidgetsBindingObserver{
  VerifyPatinetList? PatientDetails;
  int? pos;
  int? _current = 1;
  //StreamSubscription<ReceivedAction>? notificationsActionStreamSubscription;
  CategoriesPatientScreenState({this.PatientDetails, this.pos, Key? key});


  Future<void> initialize() async {
    _engine = await RtcEngine.create(APP_ID);
  }
  @override
  void initState() {    // TODO: implement initState

    super.initState();
   // appstatus();
    WidgetsBinding.instance!.addObserver(this);
    initialize();
    CommonStrAndKey.videocallcounter=0;
    CommonStrAndKey.globelDate = DateTime.now();
    permissionHandling();
    print( CommonStrAndKey.myCallProductdata.id.toString()+" ==CommonStrAndKey.myCallProductdata ASAASASASASAASASASS========="+ CommonStrAndKey.myCallProductdata.channelName.toString());
    if(CommonStrAndKey.myCallProductdata.id!=0) {
      print( CommonStrAndKey.myCallProductdata.id.toString()+" ==CommonStrAndKey.myCallProductdata ASAASASASASAASASASS========="+ CommonStrAndKey.myCallProductdata.channelName.toString());

      CommonStrAndKey.myCallProductdatacounter++;
      CommonStrAndKey.videoReceivedMode = true;
      CommonStrAndKey.isConnecting = true;
      CommonStrAndKey.isConferenceFlg = false;
      GlobalVariable.navState.currentState!.push(
        MaterialPageRoute(
          builder: (_) =>
              CallPage(
                MyAppointmentId: CommonStrAndKey.myCallProductdata.myAppointmentId
                    .toString(),
                MyDoctorId: CommonStrAndKey.myCallProductdata.myDoctorId.toString(),
                MyDoctorName: CommonStrAndKey.myCallProductdata.doctorName.toString(),
                MyPatientName: CommonStrAndKey.myCallProductdata.patientName
                    .toString(),
                channelName: CommonStrAndKey.myCallProductdata.channelName
                    .toString(),
                MyNotificationType: "videocall",
                MyEntingType: "false",
                role: _role,
                engine: _engine,
              ),
        ),
      );


    }



  }


  @override
  void activate() {
    // TODO: implement activate
    CommonStrAndKey.Notificationcallcounter=0;
    CommonStrAndKey.myCallProductdatacounter=0;
    print("@@@@@@@@@@@@@@@@@@@@@@@@"+ CommonStrAndKey.Notificationcallcounter.toString());
    super.activate();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    CommonStrAndKey.Notificationcallcounter=0;
    print("@@@@@@@@@@@@@@@@@@@@@@@@"+ CommonStrAndKey.Notificationcallcounter.toString());
    CommonStrAndKey.myCallProductdatacounter=0;
    super.deactivate();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    CommonStrAndKey.Notificationcallcounter=0;
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    WidgetsBinding.instance!.removeObserver(this);

  }

  void permissionHandling() async {
    await _handleCameraAndMic();
  }
  Future<void> _handleCameraAndMic() async {
    await [Permission.microphone, Permission.camera].request();
  }
  @override
  Widget build(BuildContext context) {
    confContext = context;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    titleName =  List<String>.filled(11,"");
    titleName[0]="Height      5.5";
    titleName[1]="Weight      65kg";
    titleName[2]="Respiration 22";
    titleName[3]="Pulse       82";
    titleName[4]="Temp        99f";
    titleName[5]="BMI         39";
    titleName[6]="BSA         1.91";
    titleName[7]="BPSystolic  95%";
    titleName[8]="BPDiastolic 90";
    titleName[9]="HC         154cm";
    titleName[10]="Critical     ";
    var columnCount = 3;
    return Scaffold(

           backgroundColor: Color(CompanyColors.grey),
            appBar: AppBar(
                centerTitle: true,
                title: Container(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 88,
                        child:Center(
                       child: Column(
                         children: [
                         Text('Home ',style: TextStyle(fontSize: 15.0,color: Colors.white),),
                           Text(PatientDetails!.patientName.toString()+" |Age "+PatientDetails!.age.toString(),
                               style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.normal),
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                             ),


                         ],
                       ),
                        ),
                      ),
                      Expanded(
                        flex: 14,
                        child:  GestureDetector(
                          onTap: () {
                            _MonWillPopLogOut(context);
                          },
                          child: Container(
                            height: 29,
                            width: 15,
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: new SvgPicture.asset(
                              'assets/icons/logout-icon-my.svg',
                              height: 20,
                              width: 17,
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),

              flexibleSpace: Container(
                decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //     begin: Alignment.topCenter,
                    //     end: Alignment.bottomCenter,
                    //     colors: [
                    //       Color(0xFF17ead9),
                    //       Color(0xFF6078ea)
                    //     ]),
                  color: Color(CompanyColors.appbar_color),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF6078ea).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
              ),
            ),
            //drawer: drowarLayout(context),
            body:  new Column(
                children: <Widget>[

                  Expanded(
                    flex: 32,
                    child: new Container(
                      child:  new Stack(
                          children: <Widget>[
                           Column(
                      children: [
                      CarouselSlider(
                        items: imageSliders,
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 2.0,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            pauseAutoPlayOnTouch: true,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });

                            }
                        ),
                      ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.map((url) {
                            int index = imgList.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                        ]
                    ),
                          ],
                        ),

                    ),
                  ),
                  Expanded(
                    flex: 68,
                    child: SafeArea(

                      child: new Container(
                      child: AnimationLimiter(
                        child: GridView.count(
                          childAspectRatio: 1.0,
                          padding: const EdgeInsets.all(8.0),
                          crossAxisCount: columnCount,
                          children: List.generate(
                            15,
                            (int index) {
                              return AnimationConfiguration.staggeredGrid(
                                columnCount: columnCount,
                                position: index,
                                duration: Duration(milliseconds: 375),
                                child: ScaleAnimation(
                                  scale: 0.5,
                                  child: FadeInAnimation(
                                    child: Categories_emptycard(
                                      width: 44.0,
                                      height: 45.0,
                                      position: index,
                                      PatientDetails: PatientDetails!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    ),
                  )
                ],
              ),
            floatingActionButton: FloatingActionButton(
          onPressed: () {
            launch("tel://+91-9810498635");
          },
          child: new SvgPicture.asset(
            'assets/New_Icons/urgent.svg',
            height: 40,
            width: 40,
            alignment: Alignment.centerLeft,
            fit: BoxFit.fill,
          ),
          backgroundColor: Colors.redAccent,
        ),

    );

  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
      // widget is resumed
     /*   ReceivePort rcPort = new ReceivePort();
        IsolateNameServer.registerPortWithName(rcPort.sendPort, portNamecallShop);
        rcPort.listen((v) {
          print( " ReceivePortASAASASASASAASASASS=========ReceivePort"+ CommonStrAndKey.myCallProductdata.channelName.toString());

          _engine!.leaveChannel();
          _engine!.destroy();
        });*/
        break;
      case AppLifecycleState.inactive:
      // widget is inactive
        break;
      case AppLifecycleState.paused:
      // widget is paused

       // AwesomeNotifications().actionSink.close();
       // AwesomeNotifications().createdSink.close();
        CommonStrAndKey.Notificationcallcounter=0;
        print("@@@@@@@@@@@@@@@@@@@@@@@@"+ CommonStrAndKey.Notificationcallcounter.toString());
       // exit(0);
        //areYourSureExit(context);
        break;
      case AppLifecycleState.detached:
      // widget is detached
        break;
    }
  }
  Future<void> areYourSureExit(BuildContext context) async {
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
                Text('Are you sure exit this app'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('YES'),
              onPressed: () {
                CommonStrAndKey.Notificationcallcounter=0;
                print("@@@@@@@@@@@@@@@@@@@@@@@@"+ CommonStrAndKey.Notificationcallcounter.toString());
                exit(0);
              },
            ),
              FlatButton(
              child: Text('NO'),
              onPressed: () {
               dispose();
              },
            ),
          ],
        );
      },
    );
  }
  Widget drowarLayout(BuildContext context) {
    return Drawer(
        child: new Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 1],
                colors: [Color(0xFF17ead9), Color(0xFF6078ea)])
            ,),
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[

              new Container(
                margin: EdgeInsets.only(top: 30),
                width: 200,
                height: 200,
                color: Color(0xFF17ead9),
                child: DrawerHeader(
                    child:ListView(
                      padding: EdgeInsets.all(0),
                      children: <Widget>[
                    new Container(
                      child: new SvgPicture.asset(
                        'assets/New_Icons/male_icon_white.svg',
                        height: 80,
                        width: 35,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fill,
                      ),
                      margin: EdgeInsets.fromLTRB(90, 2, 90, 0),
                      width: 35,
                      height: 80,
                    ),
                    new Container(
                      margin: EdgeInsets.only(left: 80),
                      alignment: Alignment.topLeft,
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Welcome ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal),
                              textAlign: TextAlign.start),
                          Text(
                            "Vinod Sharma"+"  \n",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    )
                   ])

                  /* currentAccountPicture: CircleAvatar(
              child: Text("AC"),
            ),*/
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  //leading: Icon(Icons.home),
                  title: Text(
                    "Tele Consultation",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                         // settings: RouteSettings(name: "/Medication_Group"),
                          builder: (context) => TeleSpecialisationAndDoctorList( )),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  ///leading: Icon(Icons.dashboard),
                  title: Text(
                    "My Appointment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Book Appointment",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    print("c");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Lab Reports",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  ///leading: Icon(Icons.dashboard),
                  title: Text(
                    "OP Prescription",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Vital",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    print("c");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Diagnosis",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Video Call Invitation",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  ///leading: Icon(Icons.dashboard),
                  title: Text(
                    "Favourite Doctor",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "View Document",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    print("c");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Feedback",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    print("c");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "Writes Us",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    print("c");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "About Us",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),


              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),

              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "ADD Member",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),

              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  /// leading: Icon(Icons.share),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    _MonWillPopLogOut(context);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(height: 1.0, width: 200, color: Colors.white38),
              ),

              new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                height: 30,
                alignment: Alignment.center,
                child: ListTile(
                  // leading: Icon(Icons.info),
                  title: Text(
                    "ADD Member",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),

                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.0),
                child: Container(
                  height: 1.0,
                  width: 200,
                  color: Colors.white38,
                ),
              ),





              /*   ListTile(
          leading: Icon(Icons.rate_review),
          title: Text("Rate and Review"),
          onTap: (){},
        ),
        ListTile(
          leading: Icon(Icons.flag),
          title: Text("Privacy Policy"),
          onTap: (){},
        ),*/
            ],
          ),
        ));
  }
  Future LogoutApi(BuildContext context) async {
    _onLoading(context);
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    UpdateTokenRequest setObj = new UpdateTokenRequest();
    setObj.registrationId = PatientDetails!.registrationId;

    UpdateTokenRequest obj = new UpdateTokenRequest.fromJson(setObj.toJson());
    print(
    "==========================================================================");
    print("Request  \n" + setObj.toJson().toString());
    Response<UpdateTokenResponse> response =
    (await myService.UpdateNotificationToken(obj));

    var post = response.body;
    UpdateTokenResponse res = new UpdateTokenResponse.fromJson(post!.toJson());
    print("Response"+res.toJson().toString());
    if (response != null) {
    /// Navigator.pop(context);
    if (response.body!.msg.toString().toLowerCase() == "true") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              settings: RouteSettings(name: "/Login_Screen"),
              builder: (context) => Login_Screen()),
              (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(""+response.body!.status.toString()),
      ));

    }
    }
  }
  Future<bool> _MonWillPopLogOut(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async {
              LogoutApi(context);
              // exit(0);
              /* Navigator.of(context)
                .popUntil(ModalRoute.withName("/Home_Screen"));
*/
              /*SharedPreferences preferences = await SharedPreferences.getInstance();
            await preferences.clear();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    settings: RouteSettings(name: "/Login_Screen"),
                    builder: (context) => Login_Screen()),
                    (Route<dynamic> route) => false);*/
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }



}


final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                // child: Text(
                //   'No. ${imgList.indexOf(item)} image',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 20.0,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();


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
