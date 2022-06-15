import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_patient_app/NewLogin/Splash.dart';
import 'package:flutter_patient_app/Product.dart';
import 'package:flutter_patient_app/SQLiteDbProvider.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/CanferenceCall.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/isolate_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:permission_handler/permission_handler.dart';

import 'CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Video_Call/utils/settings.dart';
import 'dart:io';
import 'package:system_alert_window/system_alert_window.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'dart:isolate';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

import 'package:wakelock/wakelock.dart';
//import 'package:screen/screen.dart';

late AudioHandler _audioHandler;

final GlobalKey<NavigatorState> navigatorobj = GlobalKey();
ClientRole? _role = ClientRole.Broadcaster;
RtcEngine? _engine;

bool _isShowingWindow = false;
String _platformVersion = 'Unknown';
const String portName = "MyAppPort";
bool _isUpdatedWindow = false;
/*String  channelName1="",DoctorName1="",DoctorId1="",MyAppointmentId1="",RegistrationId1="",notificationType1=""
,PatientName1="",priority1="",notificationMessage1="",notificationTitle1="";*/
final ReceivePort port = ReceivePort();
const String isolateName = 'isolate';


SystemWindowPrefMode prefMode = SystemWindowPrefMode.OVERLAY;

void _openMYApp() async
{
  await LaunchApp.openApp(
       androidPackageName: 'com.psri_patient_app',
  );

  bool isInstalled = await DeviceApps.isAppInstalled('com.psri_patient_app');
  /*if (isInstalled != false)
  {
    String code = "xxxxxxxxx";
    List<String> data = [code,'10000','cancel', '3'];
    String shareData = jsonEncode(data);
    final intent = AndroidIntent(
        action: "android.intent.action.SEND",
        data: Uri.encodeFull(shareData),
        package: 'com.psri_patient_app');
    intent.launch();
  }*/
  /*if (isInstalled != false)
  {
    AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: "",
    );
    await intent.launch();
  }*/
}

final callSetup = <String, dynamic>{
  'ios': {
    'appName': 'CallKeepDemo',
  },
  'android': {
    'alertTitle': 'Permissions required',
    'alertDescription':
    'This application needs to access your phone accounts',
    'cancelButton': 'Cancel',
    'okButton': 'ok',
    // Required to get audio in background when using Android 11
    'foregroundService': {
      'channelId': 'com.company.my',
      'channelName': 'Foreground service for my app',
      'notificationTitle': 'My app is running on background',
      'notificationIcon': 'mipmap/ic_notification_launcher',
    },
  },
};

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  print("sound played");
  await Firebase.initializeApp();
  String channelName = message.data.entries.elementAt(0).value.toString();
  String DoctorName = message.data.entries.elementAt(1).value.toString();
  String DoctorId = message.data.entries.elementAt(2).value.toString();
  String MyAppointmentId = message.data.entries.elementAt(4).value.toString();
  String RegistrationId = message.data.entries.elementAt(5).value.toString();
  String notificationType = message.data.entries.elementAt(6).value.toString();
  String PatientName = message.data.entries.elementAt(7).value.toString();
  //String  priority = message.data.entries.elementAt(8).value.toString();
  // priority1 = message.data.entries.elementAt(8).value.toString();
  String notificationMessage =
      message.data.entries.elementAt(8).value.toString();
  String notificationTitle = message.data.entries.elementAt(9).value.toString();
 // _openMYApp();
 /* if (await Permission.systemAlertWindow.request().isGranted) {
    print("################################### true ###"+"systemAlertWindow.request().isGranted");

    // Either the permission was already granted before or the user just granted it.
  }else
    {
      print("################################### false ###"+"systemAlertWindow.request().isGranted");

    }*/
  /*print('Permission granted9898989');
  final status = await Permission.systemAlertWindow.request();
  if (status == PermissionStatus.granted) {
    print('Permission granted');
  } else if (status == PermissionStatus.denied) {
    print('Denied. Show a dialog with a reason and again ask for the permission.');
  } else if (status == PermissionStatus.permanentlyDenied) {
    print('Take the user to the settings page.');
  }*/
  Product tempProduct=new Product(1,
      MyAppointmentId.toString(),
      DoctorId.toString(),
      DoctorName.toString(),
      PatientName.toString(),
      channelName.toString(),
      123,"xyz");
  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  Directory dir = await getApplicationDocumentsDirectory();
  SQLiteDbProvider.db.initDB();
  SQLiteDbProvider.db.insert(tempProduct);

   CommonStrAndKey.videoReceivedMode = true;



  /*if (notificationType.toString().trim().toLowerCase() == "videocall") {
    CommonStrAndKey.isConnecting = true;
    CommonStrAndKey.isConferenceFlg = false;

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
        //AwesomeNotifications().shouldShowRationaleToRequest();
      }
    });
    AwesomeNotifications().createNotification(

      content: NotificationContent(
          id: 10,
          channelKey: 'call_channel',
          backgroundColor: Colors.greenAccent,
          title: "Calling by "+DoctorName.toString(),
          body: 'Appointment id '+MyAppointmentId,
          payload: {'AppointmentId':MyAppointmentId.toString(),
            'DoctorId': DoctorId.toString(),
            'PatientName': PatientName.toString(),
            'DoctorName': DoctorName.toString(),
            'RegistrationId':RegistrationId.toString(),
            'UniqueValue': channelName.toString(),
            'NotificationType': notificationType.toString(),
          }),

    );

  }
  else if (notificationType.toString().trim().toLowerCase() == "conference") {
    CommonStrAndKey.isConnecting = true;
    CommonStrAndKey.isConferenceFlg = false;
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    AwesomeNotifications().createNotification(

      content: NotificationContent(
          id: 10,
          channelKey: 'call_channel',
          backgroundColor: Colors.greenAccent,
          title: "Calling by "+DoctorName.toString(),
          body: 'Appointment id '+MyAppointmentId,
          payload: {'AppointmentId':MyAppointmentId.toString(),
            'DoctorId': DoctorId.toString(),
            'PatientName': PatientName.toString(),
            'DoctorName': DoctorName.toString(),
            'RegistrationId':RegistrationId.toString(),
            'UniqueValue': channelName.toString(),
            'NotificationType': notificationType.toString(),
          }),


    );

   }*/
   playLocalAsset();
  _showOverlayWindow(DoctorName.toString());
  //Wakelock.enable();
 // Workmanager.registerOneOffTask("1", "Simple task");
  //startTimer();
  /*FlutterRingtonePlayer.play(
    android: AndroidSounds.ringtone,
    ios: IosSounds.glass,
    looping: false,
    // Android only - API >= 28
    volume: 0.7,
    // Android only - API >= 28
    asAlarm: true,
    // Android only - all APIs
  );*/
  print("sound playedyiyiuyiuou");

  return Future<void>.value();


}

playLocalAsset() {
  ReceivePort rcPort = new ReceivePort();
  IsolateNameServer.registerPortWithName(rcPort.sendPort, portName);
  rcPort.listen((v) {
    FlutterRingtonePlayer.stop();
  });
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId}");
  FlutterRingtonePlayer.playRingtone(looping: true);
}

void stopMusic() {
  SendPort? sendPort = IsolateNameServer.lookupPortByName(portName);
  sendPort!.send("Abcd");
}
void stopCall() {
  SendPort? sendPort = IsolateNameServer.lookupPortByName(portNamecallShop);
  sendPort!.send("Xyzs");
}

Future<void> main() async {
  /* IsolateNameServer.registerPortWithName(receivePort.sendPort, portName!);
  AndroidAlarmManager.initialize();*/

  WidgetsFlutterBinding.ensureInitialized();
  //FlutterRingtonePlayer.playNotification();

  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await AndroidAlarmManager.initialize();
    await Firebase.initializeApp();

   // AndroidIntent intent = AndroidIntent( );
   /// String? dat=intent.action;
   // print("######################################"+dat.toString()+"######################################");
    AwesomeNotifications().initialize(
        'resource://drawable/akhil_icon',
        [
          NotificationChannel(
            channelKey: 'call_channel',
            channelName: 'Calls Channel',
            channelDescription: 'Channel with call ringtone',
            defaultColor: Color(0xFF9D50DD),
            importance: NotificationImportance.High,
            ledColor: Colors.white,
            channelShowBadge: true,
            locked: true,
            //soundSource: 'resource://raw/myfirstr',
           // playSound: true,
            //defaultRingtoneType: DefaultRingtoneType.Ringtone,
            criticalAlerts: true,
          ),
        ],
        debug: true);
  }

  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  Directory dir = await getApplicationDocumentsDirectory();
  SQLiteDbProvider.db.initDB();
  // SQLiteDbProvider.db.insert(tempProduct);
  SQLiteDbProvider.db.getAllProducts();
  Wakelock.enable();
  runApp(MyApp());
}

Future<void> callBack(String tag)async {

  if (Platform.isAndroid) PathProviderAndroid.registerWith();
  Directory dir = await getApplicationDocumentsDirectory();
  SQLiteDbProvider.db.getAllProducts() ;

  //  print("ASAASASASASAASASASS========="+temp2.name.toString());
  switch (tag) {
    case "simple_button":
    case "updated_simple_button":
      {
        print("clicked simple_button");

        stopMusic();
      // stopCall();
        SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
      }
      break;
    case "focus_button":
      {
        print("Focus mybutton has been mycalled");

        stopMusic();
        _openMYApp();
        //String channelName = globals.myvideoData.data.entries.elementAt(0).value.toString();
       // print("jdszjfdghf====="+channelName);

       /*      CommonStrAndKey.videoReceivedMode = true;
        if ( "videocall" == "videocall") {
          CommonStrAndKey.isConnecting = true;
          CommonStrAndKey.isConferenceFlg = false;
          _showOverlayWindow("ArpitSaxena");
          AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
            if (!isAllowed) {
              // This is just a basic example. For real apps, you must show some
              // friendly dialog box before call the request method.
              // This is very important to not harm the user experience
              AwesomeNotifications().requestPermissionToSendNotifications();
              //AwesomeNotifications().shouldShowRationaleToRequest();
            }
          });
          AwesomeNotifications().createNotification(

            content: NotificationContent(
                id: 10,
                channelKey: 'call_channel',
                backgroundColor: Colors.greenAccent,
                title: "Calling by "+"ArpitSaxena",
                body: 'Appointment id '+"10001",


                payload: {'AppointmentId':"ArpitSaxena",
                  'DoctorId':"1081",
                  'PatientName':"Anandjjjjj",
                  'DoctorName':"ArpitSaxena",
                  'RegistrationId':"606624",
                  'UniqueValue':"ASPL1081606624202221161326226",
                  'NotificationType':"VideoCall",
                }
                ),

          );

        }
        else if ("conference" == "conference") {
          CommonStrAndKey.isConnecting = true;
          CommonStrAndKey.isConferenceFlg = false;
          AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
            if (!isAllowed) {
              // This is just a basic example. For real apps, you must show some
              // friendly dialog box before call the request method.
              // This is very important to not harm the user experience
              AwesomeNotifications().requestPermissionToSendNotifications();
            }
          });
          AwesomeNotifications().createNotification(

            content: NotificationContent(
                id: 10,
                channelKey: 'call_channel',
                backgroundColor: Colors.greenAccent,
                title: "Calling by "+"ArpitSaxena",
                body: 'Appointment id '+"10001",


                payload: {'AppointmentId':"ArpitSaxena",
                  'DoctorId':"1081",
                  'PatientName':"Anandjjjjj",
                  'DoctorName':"ArpitSaxena",
                  'RegistrationId':"606624",
                  'UniqueValue':"ASPL1081606624202221161326226",
                  'NotificationType':"VideoCall",
                }),


          );

        }*/
        SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
      }
      break;
    default:
      {
        print("OnClick event of $tag");
        //FlutterRingtonePlayer.stop();
      }
  }


  print(tag);

}
class MyApp extends StatefulWidget{
  Color c = const Color(CompanyColors.appbar_color);
  final String? title;

  // This widget is the root of your application.
  MyApp({Key? key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  String firebaseToken = "";
  String lastMessageTitle = "";
  String lastMessageBody = "";
  static SendPort? uiSendPort;

  @override
  void initState() {
    super.initState();

    CommonStrAndKey.isLaunchMode = false;
    CommonStrAndKey.videoReceivedMode = false;
    initialize();

   // SQLiteDbProvider.db.initDB();
    SQLiteDbProvider.db.getAllProducts();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {

    });

    FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("message block");

      CommonStrAndKey.videocallcounter=0;
      String channelName = message.data.entries.elementAt(0).value.toString();
      String DoctorName = message.data.entries.elementAt(1).value.toString();
      String DoctorId = message.data.entries.elementAt(2).value.toString();
      String MyAppointmentId =
          message.data.entries.elementAt(4).value.toString();
      String RegistrationId =
          message.data.entries.elementAt(5).value.toString();
      String notificationType =
          message.data.entries.elementAt(6).value.toString();
      String PatientName = message.data.entries.elementAt(7).value.toString();
      //String  priority = message.data.entries.elementAt(8).value.toString();
      String notificationMessage =
          message.data.entries.elementAt(8).value.toString();
      String notificationTitle =
          message.data.entries.elementAt(9).value.toString();
      CommonStrAndKey.videoReceivedMode = true;
      if (notificationType.toString().trim().toLowerCase() == "videocall") {
        CommonStrAndKey.isConnecting = true;
        CommonStrAndKey.isConferenceFlg = false;
       // CommonStrAndKey.videocallcounter=0;
        GlobalVariable.navState.currentState!.push(
          MaterialPageRoute(
            builder: (_) => CallPage(
              MyAppointmentId: MyAppointmentId.toString(),
              MyDoctorId: DoctorId.toString(),
              MyDoctorName: DoctorName.toString(),
              MyPatientName: PatientName.toString(),
              channelName: channelName.toString(),
              MyNotificationType: "videocall",
              MyEntingType: "true",
              role: _role,
              engine: _engine,
            ),

         /*   CallPage(
              MyAppointmentId: "ArpitSaxena",
              MyDoctorId: "1081",
              MyDoctorName:"Anandjjjjj",
              MyPatientName: "ArpitSaxena",
              channelName: "ASPL1081606624202221161326226",
              MyNotificationType: "videocall",
              MyEntingType: "true",
              role: _role,
              engine: _engine,
            ),*/

          ),
        );
      }
    });
    _initPlatformState();
    _requestPermissions();
    SystemAlertWindow.registerOnClickListener(callBack);

   /* FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("message open block");
      CommonStrAndKey.videocallcounter=0;
      String  channelName = message.data.entries.elementAt(0).value.toString();
      String  DoctorName = message.data.entries.elementAt(1).value.toString();
      String  DoctorId = message.data.entries.elementAt(2).value.toString();
      String  MyAppointmentId = message.data.entries.elementAt(4).value.toString();
      String  RegistrationId = message.data.entries.elementAt(5).value.toString();
      String  notificationType = message.data.entries.elementAt(6).value.toString();
      String  PatientName = message.data.entries.elementAt(7).value.toString();
      //String  priority = message.data.entries.elementAt(8).value.toString();
      String  notificationMessage = message.data.entries.elementAt(8).value.toString();
      String  notificationTitle= message.data.entries.elementAt(9).value.toString();
      CommonStrAndKey.videoReceivedMode = true;
      print(DoctorName.toString()+"@@@@@@@@@@@@@@@@@@@@@@@@====="+DoctorName.toString());

      CommonStrAndKey.isConnecting = true;
      CommonStrAndKey.isConferenceFlg = false;

      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          // This is just a basic example. For real apps, you must show some
          // friendly dialog box before call the request method.
          // This is very important to not harm the user experience
          AwesomeNotifications().requestPermissionToSendNotifications();

        }
      });
      AwesomeNotifications().createNotification(

        content: NotificationContent(
            id: 10,
            channelKey: 'call_channel',
            backgroundColor: Colors.greenAccent,
            title: "Calling by "+"Incomingvideocall",
            body: 'Appointment id '+"ArpitSaxena",
            payload: {'AppointmentId':"ArpitSaxena",
              'DoctorId':"1081",
              'PatientName':"Anandjjjjj",
              'DoctorName':"ArpitSaxena",
              'RegistrationId':"606624",
              'UniqueValue':"ASPL1081606624202221161326226",
              'NotificationType':"VideoCall",
            }),

      );

    });*/
  }

  static Future<void> systemOverlayOnClickListner(String value) async {
    if (value == 'button_app_to_foreground') {
      await SystemAlertWindow.closeSystemWindow();
      // how can I send a message to te main isolate here?
    }
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Future<void> initialize() async {
    _engine = await RtcEngine.create(APP_ID);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      navigatorKey: GlobalVariable.navState,
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(

          //primarySwatch:  Colors.lightBlue,
          ),
      home: Splash(),
      //  home : Splash_Screen(),
      //home : IndexPage(),

      //  home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Future<void> _initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = (await SystemAlertWindow.platformVersion)!;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _requestPermissions() async {
    await SystemAlertWindow.requestPermissions(prefMode: prefMode);
    await SystemAlertWindow.checkPermissions;
    ReceivePort _port = ReceivePort();
    IsolateManager.registerPortWithName(_port.sendPort);
    _port.listen((dynamic callBackData) {
      String tag= callBackData[0];
      switch (tag) {
        case "personal_btn":
          print("Personal button click : Do what ever you want here. This is inside your application scope");
          break;
        case "simple_button":
          print("Simple button click : Do what ever you want here. This is inside your application scope");
          break;
        case "focus_button":
          print("Focus button click : Do what ever you want here. This is inside your application scope");
          break;
      }
    });
  }

}

void _showOverlayWindow(String doctorName) {
 // CommonStrAndKey.videodata = mymessage;
// if (_isShowingWindow) {

  SystemWindowHeader header = SystemWindowHeader(
      title: SystemWindowText(
          text: "Incoming Call", fontSize: 18, textColor: Colors.black45),
      padding: SystemWindowPadding.setSymmetricPadding(12, 12),
      subTitle: SystemWindowText(
          text: doctorName.toString(),
          fontSize: 18,
          fontWeight: FontWeight.BOLD,
          textColor: Colors.black87),
      decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
/* button: SystemWindowButton(
            text: SystemWindowText(
                text: "ANSWER", fontSize: 10, textColor: Colors.black45),
            tag: "personal_btn"),*/
      buttonPosition: ButtonPosition.TRAILING);
/*SystemWindowBody body = SystemWindowBody(
      rows: [
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Some body", fontSize: 12, textColor: Colors.black45),
            ),
          ],
          gravity: ContentGravity.CENTER,
        ),
        EachRow(columns: [
          EachColumn(
              text: SystemWindowText(
                  text: "Long data of the body",
                  fontSize: 12,
                  textColor: Colors.black87,
                  fontWeight: FontWeight.BOLD),
              padding: SystemWindowPadding.setSymmetricPadding(6, 8),
              decoration: SystemWindowDecoration(
                  startColor: Colors.black12, borderRadius: 25.0),
              margin: SystemWindowMargin(top: 4)),
        ], gravity: ContentGravity.CENTER),
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Notes", fontSize: 10, textColor: Colors.black45),
            ),
          ],
          gravity: ContentGravity.LEFT,
          margin: SystemWindowMargin(top: 8),
        ),
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Some random notes.",
                  fontSize: 13,
                  textColor: Colors.black54,
                  fontWeight: FontWeight.BOLD),
            ),
          ],
          gravity: ContentGravity.LEFT,
        ),
      ],
      padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
    );*/
      SystemWindowFooter footer = SystemWindowFooter(
      buttons: [
        SystemWindowButton(
          text: SystemWindowText(
              text: "DECLINE", fontSize: 12, textColor: Colors.white),
          tag: "simple_button",
          padding: SystemWindowPadding(left: 10, right: 10, bottom: 7, top: 7),
          margin: SystemWindowMargin(left: 0, right: 0, bottom: 0, top: 10),
          width: 0,
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: Color.fromRGBO(250, 139, 97, 1),
              endColor: Color.fromRGBO(250, 139, 97, 1),
              borderWidth: 0,
              borderRadius: 5.0),
        ),
        SystemWindowButton(
          text: SystemWindowText(
              text: "ANSWER", fontSize: 12, textColor: Colors.white),
          tag: "focus_button",

          width: 0,
          padding: SystemWindowPadding(left: 10, right: 10, bottom: 7, top: 7),
          margin: SystemWindowMargin(left: 10, right: 0, bottom: 0, top: 10),
          height: SystemWindowButton.WRAP_CONTENT,
          decoration: SystemWindowDecoration(
              startColor: Color.fromRGBO(150, 239, 127, 1),
              endColor: Color.fromRGBO(147, 228, 118, 1),
              borderWidth: 0,
              borderRadius: 5.0),
        ),

      ],
      padding: SystemWindowPadding(left: 26, right: 26, bottom: 2),
      decoration: SystemWindowDecoration(startColor: Colors.white),
      buttonsPosition: ButtonPosition.CENTER);
       SystemAlertWindow.showSystemWindow(
      height: 165,
      header: header,
     //body: body,
      footer: footer,
      margin: SystemWindowMargin(left: 2, right: 2, top: 10, bottom: 0),
      gravity: SystemWindowGravity.TOP,
      notificationTitle: "Incoming Call",
      notificationBody: "+1 646 980 4741",
      prefMode: prefMode);

/* setState(() {
      _isShowingWindow = true;
    });*/
/*  } else if (!_isUpdatedWindow) {
    SystemWindowHeader header = SystemWindowHeader(
        title: SystemWindowText(
            text: "Outgoing Call", fontSize: 10, textColor: Colors.black45),
        padding: SystemWindowPadding.setSymmetricPadding(12, 12),
        subTitle: SystemWindowText(
            text: "8989898989",
            fontSize: 14,
            fontWeight: FontWeight.BOLD,
            textColor: Colors.black87),
        decoration: SystemWindowDecoration(startColor: Colors.grey[100]),
        button: SystemWindowButton(
            text: SystemWindowText(
                text: "Personal", fontSize: 10, textColor: Colors.black45),
            tag: "personal_btn"),
        buttonPosition: ButtonPosition.TRAILING);
    SystemWindowBody body = SystemWindowBody(
      rows: [
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Updated body",
                  fontSize: 12,
                  textColor: Colors.black45),
            ),
          ],
          gravity: ContentGravity.CENTER,
        ),
        EachRow(columns: [
          EachColumn(
              text: SystemWindowText(
                  text: "Updated long data of the body",
                  fontSize: 12,
                  textColor: Colors.black87,
                  fontWeight: FontWeight.BOLD),
              padding: SystemWindowPadding.setSymmetricPadding(6, 8),
              decoration: SystemWindowDecoration(
                  startColor: Colors.black12, borderRadius: 25.0),
              margin: SystemWindowMargin(top: 4)),
        ], gravity: ContentGravity.CENTER),
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Notes", fontSize: 10, textColor: Colors.black45),
            ),
          ],
          gravity: ContentGravity.LEFT,
          margin: SystemWindowMargin(top: 8),
        ),
        EachRow(
          columns: [
            EachColumn(
              text: SystemWindowText(
                  text: "Updated random notes.",
                  fontSize: 13,
                  textColor: Colors.black54,
                  fontWeight: FontWeight.BOLD),
            ),
          ],
          gravity: ContentGravity.LEFT,
        ),
      ],
      padding: SystemWindowPadding(left: 16, right: 16, bottom: 12, top: 12),
    );
    SystemWindowFooter footer = SystemWindowFooter(
        buttons: [
          SystemWindowButton(
            text: SystemWindowText(
                text: "Updated Simple button",
                fontSize: 12,
                textColor: Color.fromRGBO(250, 139, 97, 1)),
            tag: "updated_simple_button",
            padding:
            SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
            width: 0,
            height: SystemWindowButton.WRAP_CONTENT,
            decoration: SystemWindowDecoration(
                startColor: Colors.white,
                endColor: Colors.white,
                borderWidth: 0,
                borderRadius: 0.0),
          ),
          SystemWindowButton(
            text: SystemWindowText(
                text: "Focus button", fontSize: 12, textColor: Colors.white),
            tag: "focus_button",
            width: 0,
            padding:
            SystemWindowPadding(left: 10, right: 10, bottom: 10, top: 10),
            height: SystemWindowButton.WRAP_CONTENT,
            decoration: SystemWindowDecoration(
                startColor: Color.fromRGBO(250, 139, 97, 1),
                endColor: Color.fromRGBO(247, 28, 88, 1),
                borderWidth: 0,
                borderRadius: 30.0),
          )
        ],
        padding: SystemWindowPadding(left: 16, right: 16, bottom: 12),
        decoration: SystemWindowDecoration(startColor: Colors.white),
        buttonsPosition: ButtonPosition.CENTER);
    SystemAlertWindow.updateSystemWindow(
        height: 230,
        header: header,
        body: body,
        footer: footer,
        margin: SystemWindowMargin(left: 8, right: 8, top: 200, bottom: 0),
        gravity: SystemWindowGravity.TOP,
        notificationTitle: "Outgoing Call",
        notificationBody: "+1 646 980 4741",
        prefMode: prefMode);
   */ /* setState(() {
      _isUpdatedWindow = true;
    });
  } else {
    setState(() {
      _isShowingWindow = false;
      _isUpdatedWindow = false;
    });*/ /*
    SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
  }*/

  /// SystemAlertWindow.closeSystemWindow(prefMode: prefMode);
}

