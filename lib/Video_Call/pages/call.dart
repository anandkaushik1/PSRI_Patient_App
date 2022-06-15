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
import 'package:flutter_patient_app/Book_Appointment_pack/Book_Appointment.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/SQLiteDbProvider.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCResponse.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/settings.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
late BuildContext myContext,loaderContext,inviteContext;
var ctrInvitation=new TextEditingController();
 //RtcEngine? _engine;
const String ViewCall = "MyAppPortViewCall";
class CallPage extends StatefulWidget {
  /// non-modifiable channel name of the page
  final String? channelName;
  final String? MyAppointmentId;
  final String? MyDoctorId;
  final String? MyDoctorName;
  final String? MyPatientName;
  final String? MyNotificationType;
  final String? MyEntingType;
  final ClientRole? role;
  final RtcEngine? engine;
  /// Creates a call page with given channel name.
  const CallPage({Key? key,
    this.channelName,
    this.MyAppointmentId,
    this.MyDoctorName,
    this.MyPatientName,
    this.MyDoctorId,
    this.MyNotificationType,
    this.MyEntingType,
    this.role,
    this.engine,
  }) : super(key: key);

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
      role: role,
      engine: engine

  );



}

class _CallPageState extends State<CallPage> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  final GlobalKey<ScaffoldState> InvitationKey = new GlobalKey<ScaffoldState>();
  //AppointmentListJSon AppointmentDetails;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? channelName;
  String? MyAppointmentId;
  String? MyDoctorId;
  String? MyDoctorName;
  String? MyPatientName;
  String? MyNotificationType;
  String? MyEntingType;
  RtcEngine? engine;
  ClientRole? role;
  _CallPageState(
      {
        this.MyAppointmentId,
        this.MyDoctorId,
        this.MyDoctorName,
        this.MyPatientName,
        this.channelName,
        this.MyNotificationType,
        this.MyEntingType,
        this.role,
        this.engine,
      }
      );

  @override
  void dispose() {

    CommonStrAndKey.videocallcounter=0;
    // clear users
    _users.clear();
    // destroy sdk
    engine!.leaveChannel();
    engine!.destroy();
    FlutterRingtonePlayer.stop();
    CommonStrAndKey.isConnecting=false;
    CommonStrAndKey.Notificationcallcounter=0;
    SQLiteDbProvider.db.delete(1);
    SQLiteDbProvider.db.delete(2);
    SQLiteDbProvider.db.delete(3);
    SQLiteDbProvider.db.delete(4);
    super.dispose();
  }

  @override
  void initState() {

    callbackDispatcher();
    super.initState();
    SQLiteDbProvider.db.delete(1);
    SQLiteDbProvider.db.delete(2);
    SQLiteDbProvider.db.delete(3);
    SQLiteDbProvider.db.delete(4);
    // initialize agora sdk
     permissionHandling();
   // FlutterRingtonePlayer.playNotification();
    // CommonStrAndKey.isConnecting=true;

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

    await engine!.enableWebSdkInteroperability(true);
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    int? x=1920;
    int? y=1080;
    configuration.dimensions = VideoDimensions(width: x, height: y);
    await engine!.setVideoEncoderConfiguration(configuration);
    // "ASPL1081606624202221161326226";
    await engine!.joinChannel(null,widget.channelName!.toString().trim(), null, 0);

  }

  /// Create agora sdk instance and initialize
  Future<void> _initAgoraRtcEngine() async {


    engine = await RtcEngine.create(APP_ID);
    _addAgoraEventHandlers();

    if(!CommonStrAndKey.videoReceivedMode) {
      //await AgoraRtcEngine.enableVideo();
      await engine!.setEnableSpeakerphone(true);
      await engine!.enableVideo();
      await engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
      await engine!.setClientRole(widget.role!);
    }
  }
  Future<void> _initAgoraRtcEngineVideo() async {

   // CommonStrAndKey.videocallcounter++;

    //await_engine.create(APP_ID);
   // await_engine.enableVideo();
    await engine!.enableVideo();
   // await engine!.setDefaultAudioRoutetoSpeakerphone(true);
    await engine!.setEnableSpeakerphone(true);

    await engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine!.setClientRole(widget.role!);

    FlutterRingtonePlayer.stop();

    if(CommonStrAndKey.videocallcounter>=2)
      {
        setState(() {

        });
      }
    else{
      setState(() {
        engine!.muteLocalAudioStream(CommonStrAndKey.mymutefalse);

      });
    }

  }
  /// Add agora event handlers


  void _addAgoraEventHandlers() {
    engine!.setEventHandler(RtcEngineEventHandler(error: (code) {
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
        CommonStrAndKey.isConnecting=false;
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    }, userJoined: (uid, elapsed) {
      // FlutterRingtonePlayer.stop();
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
  /// Helper function to get list of native views
  List<Widget> _getRenderViews() {

    final List<StatefulWidget> list = [];
    if (widget.role! == ClientRole.Broadcaster) {
      list.add(RtcLocalView.SurfaceView());
    }
   // "ASPL1081606624202221161326226"
    _users.forEach((int uid) => list.add(RtcRemoteView.SurfaceView(uid: uid,channelId: channelName!.toString().trim())));
    return list;
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
        engine!.muteLocalAudioStream(CommonStrAndKey.mymutetrue);
        return CurrentView(MyDoctorName!.toString(),MyPatientName!.toString());
      case 2:
        CommonStrAndKey.videocallcounter++;
        if(CommonStrAndKey.videocallcounter==2)
          {
            engine!.muteLocalAudioStream(CommonStrAndKey.mymutefalse);
          }
       //engine!.muteLocalAudioStream(CommonStrAndKey.mymutefalse);
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

  /// Info panel to show logs


  void _onCallEnd(BuildContext context) {
    print("11-11-11-11-11-11");

    if(MyEntingType.toString().toLowerCase().trim()=="true")
    {
      Navigator.pop(context);
    }else
    {

      exit(0);
    }

  }

  void _onToggleMute() {

    setState(() {
      muted = !muted;
    });
    engine!.muteLocalAudioStream(muted);
    //AgoraRtcEngine.muteLocalAudioStream(CommonStrAndKey.mymutefalse);

  }

  void _onSwitchCamera() {
    engine!.switchCamera();
  }


  @override
  Widget build(BuildContext context) {
   // myContext=context;
    return layout(context);

    /*FutureBuilder<RtcEngine>(
      future: createAppId(""), // function where you call your api
      builder:(BuildContext context, AsyncSnapshot<RtcEngine> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return noDataFound(context);
          else if (data.requireData == null) {
            return noDataFound(context);
          } else {
              initialize();
              return layout(context);

          }
        }
      },
    );*/

  }

  Future<RtcEngine> createAppId(String ai) async {
    engine = await RtcEngine.create(APP_ID);
    return Future.value(engine);
  }

  Widget layout(BuildContext context) {
    myContext=context;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Video Call'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.video_call),
        ),
      ),
      backgroundColor: Colors.white,

      body: Center(
        child: receivedCallView(MyDoctorName!.toString(),MyPatientName!.toString()),
      ),
    );
  }

  void callbackDispatcher() {
    print("12-12-12-12-12-12");

    print('callbackDispatcher');
    FlutterRingtonePlayer.play(
      android: AndroidSounds.ringtone,
      ios: IosSounds.glass,
      looping: true, // Android only - API >= 28
      volume: 0.7, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );

  }
  Widget noDataFound(BuildContext context) {
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
    });
    return new Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'No Record Found',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ));
  }


  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(
            size: 71.0, color: Color(CompanyColors.appbar_color)));

  }
  Widget receivedCallView(String DoctorName,String PatientName)
  {
    //print("13-13-13-13-13-13");

    if(CommonStrAndKey.videoReceivedMode) {
      return new Container(
        color: Colors.white,
        child:  Stack(
            children:[

              _viewRows(),
              CallReceiver(DoctorName, PatientName),
            ]
        ),

      );
    }else{
      return Stack(
        children: [
          _viewRows(),
          // _panel(),
          _toolbar(),
          Align(
            alignment: Alignment.topRight,
            child:  Visibility(
              // visible: CommonStrAndKey.isConferenceFlg,
              //visible: true,
              visible: CommonStrAndKey.videocallcounter>1?false:true,

              child: new Container(
                margin: EdgeInsets.fromLTRB(5,10,5,5),
                child: new FloatingActionButton.extended(

                  onPressed: () {
                    print("Container clicked");
                    invitatiForCall(context,MyDoctorId!,MyAppointmentId!, channelName!);
                  },

                  label:Visibility(
                    visible: true,
                    child: new Container(
                      child: Row(
                        children: [
                          new Container(
                            child: Icon(
                              Icons.call,
                              color: Color(CompanyColors.white),
                              size: 15,
                            ),
                            margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                          ),
                          new Text(
                            "ADD",
                            style: TextStyle(
                                color: Color(
                                  CompanyColors.button_txt_color,
                                ),
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),),
          ),
        ],
      );
    }
  }

  Widget ConnectToCallView(String DoctorName,String PatientName)
  {
    print("14-14-14-14-14-14");

    return  ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 300,
          maxWidth: MediaQuery.of(context).size.width,

        ),
        child: Center(
          /*children: <Widget>[_videoView(views[0])],*/


          child:   Column(

            children: [

              Container(
                margin: EdgeInsets.fromLTRB(20,100,20,20),
                color: Colors.white,
                child: new SvgPicture.asset("assets/New_Icons/patient-call.svg",
                  height: 200,
                  width: 200,
                  fit:BoxFit.fill,
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                child: Center(
                  child: Text("Doctor Name : "+DoctorName.toString()+
                      "\nPatient Name :"+PatientName.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                  ),),
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

  Widget DisconnectToCallView()
  {
    print("15-15-15-15-15-15");

    new Future.delayed(new Duration(seconds: 2), () {
      if(MyEntingType.toString().toLowerCase().trim()=="true")
      {
        Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
      }else
      {
        exit(0);
      }

    });
    return  ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 300,
          maxWidth: MediaQuery.of(context).size.width,

        ),
        child: Center(
          /*children: <Widget>[_videoView(views[0])],*/


          child:   Column(

            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20,100,20,20),
                color: Colors.white,
                child: new SvgPicture.asset("assets/New_Icons/patient-call_cross.svg",
                  height: 200,
                  width: 200,
                  fit:BoxFit.fill,
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

  Widget CallReceiver(String DoctorName,String PatientName)
  {
    return new Container(
      color: Colors.white,
      child:
      ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 300,
            maxWidth: MediaQuery.of(context).size.width,

          ),
          child: Center(
            /*children: <Widget>[_videoView(views[0])],*/


            child:   Column(

              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20,100,20,20),
                  color: Colors.white,
                  child: new SvgPicture.asset("assets/New_Icons/patient-call.svg",
                    height: 200,
                    width: 200,
                    fit:BoxFit.fill,
                  ),
                ),
                new Container(
                  margin: EdgeInsets.fromLTRB(10, 2, 10, 10),
                  child: Center(
                    child: Text("Doctor Name : "+MyDoctorName.toString()+
                        "\nPatient Name :"+MyPatientName.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 3,
                    ),),
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

                          child:
                          new SvgPicture.asset("assets/New_Icons/call_icon_decline.svg",
                            height: 60,
                            width: 60,
                            fit:BoxFit.fill,
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
                                new SvgPicture.asset("assets/New_Icons/call_icon_accept.svg",
                                  height: 60,
                                  width: 60,
                                  fit:BoxFit.fill,
                                ),
                                //Text("Accept"),
                              ],
                            ),

                          ),
                          onTap: () {
                            CommonStrAndKey.videoReceivedMode=false;
                            _initAgoraRtcEngineVideo();

                          }
                      ),
                    ],
                  ),
                )

              ],
            ),
          )
      ),
    );

  }

  Widget CurrentView(String DoctorName,String AppointName)
  {
    print("16-16-16-16-16-16");

    print ("rahulanand"+CommonStrAndKey.isConnecting.toString());
    if(CommonStrAndKey.isConnecting && CommonStrAndKey.videocallcounter<2)
    {
      return ConnectToCallView(DoctorName, AppointName);
    }else
    {
      return DisconnectToCallView();
    }
  }

  Future<void> invitatiForCall(
      BuildContext myContext, String doctorId,String appointId,String UniqueKey) async {
    List<Color> _colors = [Color(0xff0096b9),Color(0xff0096b9), Color(0xff00a69d)];
    List<double> _stops = [0.0,0.3, 0.4];
    ctrInvitation.text="";
    return showDialog<void>(

      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        inviteContext=context;
        return AlertDialog(
          key:InvitationKey   ,
          title: Text('Enter Mobile Number'),
          backgroundColor: Color(0xfff9f9f9),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  width: 180,

                  child:TextField(
                    autocorrect: true,
                    controller: ctrInvitation,
                    style: TextStyle(color: Colors.black,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,

                    keyboardType: TextInputType.number,
                    //maxLength:4 ,

                    decoration: InputDecoration(
                      //hintText: 'Type Text Here',
                      enabledBorder: UnderlineInputBorder(

                        borderSide: BorderSide(color: Color(0xff1d9bb4),
                            style: BorderStyle.solid
                        ),

                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1d9bb4),
                            style: BorderStyle.solid),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel',style: TextStyle(color: Color(0xff1d9bb4)),),
              onPressed: () {
                ctrInvitation.clear();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Submit',style: TextStyle(color: Color(0xff1d9bb4))),
              onPressed: () {
                if(validationMobileNo(ctrInvitation.text.toString())) {
                  gotoNextView(myContext,doctorId,appointId,UniqueKey,ctrInvitation.text.toString());

                }
              },
            ),
          ],
        );
      },
    );
  }

  bool  validationMobileNo(String mobile)
  {
    bool valid = true;
    String toastMsg="";
    if (mobile == "" || mobile == "null" || mobile == null) {
      valid=false;
      toastMsg="Please enter UHID";

    } /*else  if (mobile.length<10) {
      valid=false;
      toastMsg="Please enter valid mobile";
    }*/
    if(!valid) {

    }
    return valid;
  }
  Future gotoNextView(
      BuildContext myContext, String doctorId,String appointId,String UniqueKey,String strMobile) async {
    _myLoading(myContext);
    String myRegId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';

    String url = BasicUrl.sendUrl();

    final myService = MyServicePost.create(url);
    SendInivitationVCRequest setObj = new SendInivitationVCRequest();
    setObj.hospitalLocationId = 1;
    setObj.appointmentId = int.parse(appointId.toString()) ;
    setObj.senderRegId = int.parse(myRegId) ;
    setObj.encounterId = 0;
    setObj.facilityId = 3;
    setObj.source="P";
    setObj.doctorId= int.parse(doctorId.toString());
    setObj.recieverRegId=int.parse(strMobile);
    setObj.uniqueValue=UniqueKey;
    print("Request  \n" + setObj.toJson().toString());
    SendInivitationVCRequest obj = new SendInivitationVCRequest.fromJson(setObj.toJson());
    Response<SendInivitationVCResponse> response = (await myService.SendVCInvitation(obj));
    print("response.body : ${response.body}");
    var post = response.body;
    if (response != null) {
      Navigator.pop(loaderContext);
      Navigator.pop(inviteContext);

      if(response.body!.status.toString().toString().toLowerCase()=="success")
      {
        showAlerDialog(DialogType.SUCCES, 'Info', response.body!.msg,true);
      } else {
        showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg,false);
      }

    } else {
      Navigator.pop(loaderContext);
      Navigator.pop(inviteContext);
      showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg,false);

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
                              size: 51.0, color: Color(CompanyColors.appbar_color))),
                      new Text(
                        "Please wait...",
                        style: TextStyle(fontSize: 25, color: Color(CompanyColors.appbar_color)),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );

  }
  void showAlerDialog(type, title, message,bool timeNoOff) {
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
        timeNoOff=false;

      },
    )..show();
    if (timeNoOff){
      Timer(
          Duration(seconds: 3),
              () {
            if (timeNoOff) {
              Navigator.of(myContext, rootNavigator: false).pop();

            }
          }

      );
    }
  }
}
