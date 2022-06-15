import 'dart:async';
import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCResponse.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/settings.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'package:flutter_svg/flutter_svg.dart';

late BuildContext myContext, loaderContext;
late RtcEngine _engine;
class CanferenceCall extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;
  final String? MyAppointmentId;
  final String? MyDoctorId;
  final String? MyDoctorName;
  final String? MyPatientName;
  final String? MyNotificationType;
  final String? MyEntingType;
  final  ClientRole? role;

  /// Creates a call page with given channel name.
  const CanferenceCall(
      {Key? key,
      this.channelName,
      this.MyAppointmentId,
      this.MyDoctorName,
      this.MyPatientName,
      this.MyDoctorId,
      this.MyNotificationType,
      this.MyEntingType,
      this.role

      })
      : super(key: key);

  @override
  _CallPageState createState() => _CallPageState(
      //AppointmentDetails: AppointmentDetails,
      channelName: channelName,
      MyDoctorId: MyDoctorId,
      MyAppointmentId: MyAppointmentId,
      MyDoctorName: MyDoctorName,
      MyPatientName: MyPatientName,
      MyNotificationType: MyNotificationType,
      MyEntingType: MyEntingType,
      role:role

  );
}

class _CallPageState extends State<CanferenceCall> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  final GlobalKey<ScaffoldState> InvitationKey = new GlobalKey<ScaffoldState>();

  //AppointmentListJSon AppointmentDetails;
  String? channelName;
  String? MyAppointmentId;
  String? MyDoctorId;
  String? MyDoctorName;
  String? MyPatientName;
  String? MyNotificationType;
  String? MyEntingType;
  ClientRole? role;
  _CallPageState(
      {this.MyAppointmentId,
      this.MyDoctorId,
      this.MyDoctorName,
      this.MyPatientName,
      this.channelName,
      this.MyNotificationType,
      this.MyEntingType,
      this.role

      });

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk
   _engine.leaveChannel();
   _engine.destroy();
    FlutterRingtonePlayer.stop();
    CommonStrAndKey.isConnecting = false;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    /// permissionHandling();
    FlutterRingtonePlayer.playNotification();
    // CommonStrAndKey.isConnecting=true;
    callbackDispatcher();

    initialize();
  }

  void permissionHandling() async {
    await _handleCameraAndMic();
  }

  Future<void> _handleCameraAndMic() async {
    await [Permission.microphone, Permission.camera].request();
  }

  Future<void> initialize() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    /*await_engine.enableWebSdkInteroperability(true);
    await_engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await_engine.joinChannel(null, widget.channelName, null, 0);*/
    await _engine.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    int? x=1920;
    int? y=1080;
    configuration.dimensions = VideoDimensions(width: x, height: y);
    await _engine.setVideoEncoderConfiguration(configuration);
    //widget.channelName!.toString()
    await _engine.joinChannel(null,widget.channelName!.toString(), null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {
   /* await_engine.create(APP_ID);
    if (!CommonStrAndKey.videoReceivedMode) {
      await_engine.enableVideo();
    }*/
    _engine = await RtcEngine.create(APP_ID);
    _addAgoraEventHandlers();
    print("333333");
    if(!CommonStrAndKey.videoReceivedMode) {
      //await AgoraRtcEngine.enableVideo();
      await _engine.enableVideo();
      await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
      await _engine.setClientRole(widget.role!);
    }
  }

  Future<void> _initAgoraRtcEngineVideo() async {
    //await_engine.create(APP_ID);
   // await_engine.enableVideo();

    CommonStrAndKey.videocallcounter++;
    await _engine.enableVideo();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(widget.role!);
    FlutterRingtonePlayer.stop();

    if(CommonStrAndKey.videocallcounter>=2)
    {
      setState(() {

      });
    }
    else{
      setState(() {
        _engine.muteLocalAudioStream(CommonStrAndKey.mymutefalse);

      });
    }
  }

  /// Add agora event handlers
/*
  void _addAgoraEventHandlers() {
   _engine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

   _engine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

   _engine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

   _engine.onUserJoined = (int uid, int elapsed) {
      FlutterRingtonePlayer.stop();
      setState(() {
        CommonStrAndKey.isConferenceFlg = true;
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

   _engine.onUserOffline = (int uid, int reason) {
      setState(() {
        CommonStrAndKey.isConnecting = false;
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

   _engine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }
*/
  List<Widget> _getRenderViews() {

    final List<StatefulWidget> list = [];
    if (widget.role! == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid,channelId: widget.channelName!,)));
    return list;
  }
  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(error: (code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    }, joinChannelSuccess: (channel, uid, elapsed) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    }, leaveChannel: (stats) {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      setState(() {
        CommonStrAndKey.isConferenceFlg=true;
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    }, userOffline: (uid, elapsed) {
      // FlutterRingtonePlayer.stop();
      setState(() {
        CommonStrAndKey.isConnecting=false;
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    }, firstRemoteVideoFrame: (uid, width, height, elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    }));
  }
  /// Video view wrapper
  Widget _videoView(view) {
    return Expanded(child: Container(child: view));
  }

  /// Video view row wrapper
  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: Row(
        children: wrappedViews,
      ),
    );
  }

  /// Video layout wrapper
  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return CurrentView(MyDoctorName!, MyPatientName!);
      case 2:
        return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _expandedVideoRow([views[1]]),
                _expandedVideoRow([views[0]])
              ],
            ));
      case 3:
        return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 3))
              ],
            ));
      case 4:
        return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _expandedVideoRow(views.sublist(0, 2)),
                _expandedVideoRow(views.sublist(2, 4))
              ],
            ));
      default:
    }
    return Container();
  }

  /// Toolbar layout
  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: _onToggleMute,
            child: Icon(
              muted ? Icons.mic_off : Icons.mic,
              color: muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          RawMaterialButton(
            onPressed: () => _onCallEnd(context),
            child: Icon(
              Icons.call_end,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(15.0),
          ),
          RawMaterialButton(
            onPressed: _onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }



  void _onCallEnd(BuildContext context) {
    if (MyEntingType.toString().toLowerCase().trim() == "true") {
      Navigator.pop(context);
    } else {
      exit(0);
    }
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
   _engine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
   _engine.switchCamera();
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;

    return Scaffold(
      appBar: AppBar(
        title: Text('Conference Video Call'),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: receivedCallView(MyDoctorName!, MyPatientName!),
      ),
    );
  }

  void callbackDispatcher() {
    print('callbackDispatcher');
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true,
      // Android only - API >= 28
      volume: 0.7,
      // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
  }

  Widget receivedCallView(String DoctorName, String PatientName) {
    if (CommonStrAndKey.videoReceivedMode) {
      return new Container(
        color: Colors.white,
        child: Stack(children: [
          _viewRows(),
          CallReceiver(DoctorName, PatientName),
        ]),
      );
    } else {
      return Stack(
        children: [
          _viewRows(),
          // _panel(),
          _toolbar(),

        ],
      );
    }
  }

  Widget ConnectToCallView(String DoctorName, String PatientName) {
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 300,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Center(
          /*children: <Widget>[_videoView(views[0])],*/

          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                color: Colors.white,
                child: new SvgPicture.asset(
                  "assets/New_Icons/patient-call.svg",
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                child: Center(
                  child: Text(
                    "Doctor Name : " +
                        DoctorName.toString() +
                        "\nPatient Name :" +
                        PatientName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),
                ),
              ),
              Text(
                "Please wait,    \nyou are connecting...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ));
  }

  Widget DisconnectToCallView() {
    new Future.delayed(new Duration(seconds: 5), () {
      if (MyEntingType.toString().toLowerCase().trim() == "true") {
        Navigator.of(context)
            .popUntil(ModalRoute.withName("/CategoriesPatient"));
      } else {
        exit(0);
      }
    });
    return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 300,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Center(
          /*children: <Widget>[_videoView(views[0])],*/

          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                color: Colors.white,
                child: new SvgPicture.asset(
                  "assets/New_Icons/patient-call_cross.svg",
                  height: 200,
                  width: 200,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                "Thank you,  \nyour call is disconnected.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
            ],
          ),
        ));
  }

  Widget CallReceiver(String DoctorName, String PatientName) {
    return new Container(
      color: Colors.white,
      child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 300,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Center(
            /*children: <Widget>[_videoView(views[0])],*/

            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 100, 20, 20),
                  color: Colors.white,
                  child: new SvgPicture.asset(
                    "assets/New_Icons/patient-call.svg",
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Center(
                    child: Text(
                      "Doctor Name : " +
                          MyDoctorName.toString() +
                          "\nPatient Name :" +
                          MyPatientName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),
                  ),
                ),
                Text(
                  "Please wait,    \nyou are connecting...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(20, 60, 20, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new GestureDetector(
                        child: Container(
                          child: new SvgPicture.asset(
                            "assets/New_Icons/call_icon_decline.svg",
                            height: 60,
                            width: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                        onTap: () {
                          _onCallEnd(context);
                          //
                        },
                      ),
                      new SizedBox(
                        width: 120,
                      ),
                      new GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                new SvgPicture.asset(
                                  "assets/New_Icons/call_icon_accept.svg",
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fill,
                                ),
                                //Text("Accept"),
                              ],
                            ),
                          ),
                          onTap: () {
                            CommonStrAndKey.videoReceivedMode = false;
                            _initAgoraRtcEngineVideo();
                          }),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Widget CurrentView(String DoctorName, String AppointName) {
    if (CommonStrAndKey.isConnecting) {
      return ConnectToCallView(DoctorName, AppointName);
    } else {
      return DisconnectToCallView();
    }
  }


  void _myLoading(BuildContext pcontext) {
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
                      child: SpinKitCubeGrid(
                          size: 51.0,
                          color: Color(CompanyColors.appbar_color))),
                  new Text(
                    "Please wait...",
                    style: TextStyle(
                        fontSize: 25, color: Color(CompanyColors.appbar_color)),
                  ),
                ],
              ),
            ),
          )),
        );
      },
    );
  }

  void showAlerDialog(type, title, message, bool timeNoOff) {
    AwesomeDialog dialog;

    dialog = AwesomeDialog(
      context: myContext,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {
        //Navigator.of(myContext, rootNavigator: false).pop();
        timeNoOff = false;
      },
    )..show();
    if (timeNoOff) {
      Timer(Duration(seconds: 3), () {
        if (timeNoOff) {
          Navigator.of(myContext, rootNavigator: false).pop();
        }
      });
    }
  }
}
