import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/TakeDoc_Screen.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/UploadDocWithType.dart';
import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentRequest.dart';
import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentResponse.dart';
import 'package:flutter_patient_app/Payment_pack/KKCHPayment.dart';
import 'package:flutter_patient_app/RescheduleAppointment/Reschedule_Appointment.dart';
import 'package:flutter_patient_app/Video_Call/pages/MyVideocallScreen.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/appointment_view_new/documentupload/file_crop.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploaddoc_request.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploadeddoc_response.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_request.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentList extends StatefulWidget {
  final AppointmentListJSon? patientDetails;
  const AppointmentList({
    Key? key,
    this.patientDetails,
  }) : super(key: key);
  @override
  _AppointmentListState createState() => _AppointmentListState(patientDetails: patientDetails);
}

class _AppointmentListState extends State<AppointmentList> {
  AppointmentListJSon? patientDetails;

  ViewAppointmentResponse? responseData ;
  DeleteAppointmentResponse? responseDelete ;

  UploadedDocResponse? responseDataDoc;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late  BuildContext mcontext;
  _AppointmentListState({
    this.patientDetails,
  });
  @override
  void initState() {
    getViewAppointmentList();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    mcontext = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Appointment',
          style: TextStyle(fontSize: 16.0),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(CompanyColors.appbar_color), Color(CompanyColors.appbar_color)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(CompanyColors.appbar_color).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: layout(),
    );
  }

  getViewAppointmentList() async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    String mobileno = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobileNo) ??
        '';
    print('registrationId : $registrationId');
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    ViewAppointmentRequest payload = new ViewAppointmentRequest();
    // payload.registrationId = "573057";
    // payload.MobileNo = "9468129931";
    //payload.registrationId = registrationId;
    payload.MobileNo= mobileno;
    payload.registrationId = "0";
    print('############################################################################');
    print("Request  \n" + payload.toJson().toString());
    print('---------------------------------------------------------------------------');
    ViewAppointmentRequest payloadata =
    new ViewAppointmentRequest.fromJson(payload.toJson());
    var response = await myService.AppointmentList(payloadata);
    setState(() {
      responseData = response.body;
      print('Appointment response\n${responseData!.toJson().toString()}');
      print('############################################################################');
    });
  }

  layout() {
    if (responseData != null) {
      if (responseData!.status!.toString().contains("Success")) {

        return new ListView.builder(
            shrinkWrap: true,
            itemCount: responseData!.appointmentListJSon!.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return showContentView(index);
            });
      } else {
        //return showErrorView(responseData!.msg);
        return showErrorView("No Record Found");
      }
    } else {
      return Loading();
    }
  }

  Widget Loading() {
    return Center(
      child: new Container(
          color: Colors.white,
          child: SpinKitCubeGrid(size: 71.0, color: Color(0xffc9c9c9))),
    );
  }

  showMessage(String message) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 10),
    ));
  }

  showErrorView(String message) {
    return Center(
      child: new Text(message),
    );
  }

  showContentView(int index) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        new Text(
                            responseData!.appointmentListJSon!.elementAt(index).doctorName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        new Text(
                            '(' +
                                responseData!.appointmentListJSon!.elementAt(index)
                                    .specialisationName.toString() +
                                ')',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        new Text(
                            "Patient Name :" +
                                responseData!
                                    .appointmentListJSon!.elementAt(index).patientName.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        new Text(
                            'Appointment Date : ' +
                                responseData!.appointmentListJSon!.elementAt(index)
                                    .appointmentDate.toString() +
                                ',' +
                                responseData!
                                    .appointmentListJSon!.elementAt(index).fromTime.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                        new Text(
                            'Payment Status : ' +
                                responseData!
                                    .appointmentListJSon!.elementAt(index).paymentStatus.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),

                        new Text(
                            'Remarks : ' +
                                responseData!
                                    .appointmentListJSon!.elementAt(index).Remarks.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),


                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //Hide video call Button visible invisible
                        //getVideoCallView(index),
                        SizedBox(
                          width: 10,
                        ),
                        getDeleteButton(index),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                      Visibility(
                        // visible: responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase()=="paid"?true:false,
                        child: getViewReschedule(index),
                      ),),
                    SizedBox(
                      width: 5,
                    ),

                    Expanded(
                      child:
                      Visibility(
                        //visible: responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase()=="paid"?true:false,
                        visible:visibleOfDocAndupload(responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase(),responseData!.appointmentListJSon!.elementAt(index).registrationNo.toString()),
                        child: getuploadDocument(index),
                      ),),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child:
                      Visibility(
                        // visible: responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase()=="paid"?true:false,
                        visible:visibleOfDocAndupload(responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase(),responseData!.appointmentListJSon!.elementAt(index).registrationNo.toString()),
                        child: getViewDocument(index),
                      ),),

                    SizedBox(
                      width: 5,
                    ),
                    //rahul payment hide
                    Expanded(
                      child: getPayButton(index),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  getColorforButton(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).paymentStatus == "Paid") {
      return Color(0xff1E88E5);
    } else {
      return Color(0xff9E9E9E);
    }
  }

  getVideoCallView(index) {
    if (getStatusofvideoCall(index)) {
      return ClipOval(
        child: Material(
          color: getColorforButton(index), // button color
          child: InkWell(
            // inkwell color
            child: SizedBox(
                width: 35,
                height: 35,
                child: Icon(
                  Icons.video_call,
                  color: Colors.white,
                  size: 18,
                )),
            onTap: () {
              if (responseData!.appointmentListJSon!.elementAt(index).paymentStatus == "Paid") {
                CommonStrAndKey.isConnecting=true;
                CommonStrAndKey.isConferenceFlg=false;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyVideocallScreen(
                    channelName:"ASPL"+ responseData!.appointmentListJSon!.elementAt(index).doctorId.toString().trim()+""+responseData!.appointmentListJSon!.elementAt(index).registrationNo.toString().trim(),
                    MyDoctorId:responseData!.appointmentListJSon!.elementAt(index).doctorId.toString().trim() ,
                    MyAppointmentId:responseData!.appointmentListJSon!.elementAt(index).appointmentId.toString().trim() ,
                    MyDoctorName:responseData!.appointmentListJSon!.elementAt(index).doctorName.toString().trim() ,
                    MyPatientName:responseData!.appointmentListJSon!.elementAt(index).patientName.toString().trim() ,
                    MyNotificationType: "videocall",
                    MyEntingType: "true",
                    //  AppointmentDetails:responseData!.appointmentListJSon.elementAt(index),
                    // channelName: "123456789",
                  ),),
                );
              }
            },
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  getDeleteButton(index) {
    return ClipOval(
      child: Material(
        color: Colors.red, // button color
        child: InkWell(
          // inkwell color
          child: SizedBox(
              width: 35,
              height: 35,
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 18,
              )),
          onTap: () {
            print('calling delete');
            if (responseData!.appointmentListJSon!.elementAt(index).paymentStatus.toString().toLowerCase() ==
                "paid") {
              _modalBottomSheetMenu(index);
            } else {
              loadNormalDelete(responseData!.appointmentListJSon!.elementAt(index));
            }
          },
        ),
      ),
    );
  }

  getStatusofvideoCall(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).appointmentType!.toString()
        .contains("Tele Medication")) {
      if (responseData!.appointmentListJSon!.elementAt(index).paymentStatus!.toString()
          .contains("Paid")) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  getPayButton(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).paymentStatus == "Un-Paid") {
      return RaisedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => KKCHPayment(
              myOrderId: ""+responseData!.appointmentListJSon!.elementAt(index).appointmentId.toString().trim(),
              myUserId: ""+responseData!.appointmentListJSon!.elementAt(index).appointmentId.toString().trim(),
            ),),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(CompanyColors.appbar_color), Color(CompanyColors.appbar_color)]),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            // min sizes for Material buttons
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Pay Now",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  getView(index){
    if (responseDataDoc!.patientDocList!.elementAt(index).document.toString().contains('.pdf')) {
      return Container(
        child: Center(
            child: RaisedButton(
                color: Color(CompanyColors.appbar_color),
                child: Text("Download", style: (
                    TextStyle(color: Colors.white)
                ),),
                onPressed: () {
                  launchURL(BasicUrl.sendUrlTestingImage() + responseDataDoc!.patientDocList!.elementAt(index).encryptedDocument.toString());
                },
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0))
            )
        ),
      );

    } else {
      return Container(
        child: Image.network(
          BasicUrl.sendUrlTestingImage() +
              responseDataDoc!.patientDocList!.elementAt(index).encryptedDocument.toString(),
          fit: BoxFit.fill,
          scale: double.maxFinite,
        ),
      );
    }

  }

  bool visibleOfDocAndupload(String paymentStatus,String registrationNo)
  {
    String registration_no = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ??
        '';
    if(paymentStatus == "paid" && registrationNo.toString() == registration_no) {
      return true;
    }else{
      return false;
    }
  }


  getViewDocument(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).appointmentType ==
        "Tele Medication") {
      return
        RaisedButton(
          onPressed: () {
            getUploadedDoc(responseData!.appointmentListJSon!.elementAt(index));
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(CompanyColors.appbar_color), Color(CompanyColors.appbar_color)]),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Container(
              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
              // min sizes for Material buttons
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("View Document",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.white)),
              ),
            ),
          ),
        );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
  getViewReschedule(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).appointmentType ==
        "Tele Medication") {
      return
        RaisedButton(
          onPressed: () {
            //getUploadedDoc(responseData!.appointmentListJSon[index]);
            CommonStrAndKey.isTeleConsultFlg = true;
            CommonStrAndKey.doctorForAppointment=responseData!.appointmentListJSon!.elementAt(index).doctorId.toString();


            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                Reschedule_Appointment(
                  doctorId: responseData!.appointmentListJSon!.elementAt(index).doctorId.toString(),
                  nameDoctor: responseData!.appointmentListJSon!.elementAt(index).doctorName.toString(),
                  strFacitily:responseData!.appointmentListJSon!.elementAt(index).facilityID.toString(),
                  myAppointData: responseData!.appointmentListJSon!.elementAt(index),
                  strHospital: "",
                ))).then((value) {
              setState(() {
                // refresh state
              });
            });
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          padding: const EdgeInsets.all(0.0),
          child: Ink(
            decoration: const BoxDecoration(
              color: Color(CompanyColors.appbar_color),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Container(
              constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
              // min sizes for Material buttons
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Reschedule",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10, color: Colors.white)),
              ),
            ),
          ),
        );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
  getuploadDocument(index) {
    if (responseData!.appointmentListJSon!.elementAt(index).appointmentType ==
        "Tele Medication") {
      return RaisedButton(
        onPressed: () {
          /* Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChooseAndCrop(responseData!.appointmentListJSon[index])),
          );*/
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UploadDocWithType(
                  title: "",
                  myDoctorId: responseData!.appointmentListJSon!.elementAt(index).doctorId.toString(),
                  myAppointmentId:responseData!.appointmentListJSon!.elementAt(index).appointmentId.toString(),
                  regID: responseData!.appointmentListJSon!.elementAt(index).RegistrationId.toString(),
                )),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(CompanyColors.appbar_color), Color(CompanyColors.appbar_color)]),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
            // min sizes for Material buttons
            alignment: Alignment.center,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text("Upload Document",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10, color: Colors.white)),
            ),
          ),
        ),
      );
    } else {
      return SizedBox(
        height: 0,
        width: 0,
      );
    }
  }

  getUploadedDoc(AppointmentListJSon data) async {
    _onLoading();
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    UploadedDocRequest payload = new UploadedDocRequest();
   // payload.registrationId = registrationId;
    payload.registrationId= data.RegistrationId.toString();

    payload.appointmentId = data.appointmentId.toString();
    payload.encounterId = "";
    payload.doctorId = data.doctorId.toString();
    payload.facilityId = data.facilityID.toString();
    payload.hospitalLocationId = data.hospitalLocationId.toString();

    print('############################################################################');
    print('doc : ${payload.toJson()}');

    UploadedDocRequest payloadata =
    new UploadedDocRequest.fromJson(payload.toJson());
    var response = await myService.appointmentViewDoc(payloadata);
    setState(() {
      responseDataDoc = response.body;
      print('doc resp \n: ${response.body!.toJson()}');
      print('############################################################################');
      if (responseDataDoc != null) {
        Navigator.of(context, rootNavigator: true).pop();
        showBottomSheet();
      }
    });
  }

  Future<Future> _onLoading() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                content: Container(
                  width: 100,
                  height: 100,
                  child: Loading(),
                ),
              );
            },
          );
        });
  }

  showBottomSheet() {

    var alertStyle = AlertStyle(
      overlayColor: Colors.transparent,
      animationType: AnimationType.fromTop,
      isCloseButton: true,

      isOverlayTapDismiss: true,
      // descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      /* titleStyle: TextStyle(
        color: Color.fromRGBO(91, 55, 185, 1.0),
      ),*/
    );
    Alert(
        context: context,
        title: "",
        style: alertStyle,
        content: bottomSheetBody(),
        buttons: []).show();
  }

  bottomSheetBody() {
    if (responseDataDoc == null) {
      return Loading();
    } else if (responseDataDoc!.status.toString() == "fail") {
      return Center(
        child: new Text(responseDataDoc!.msg.toString()),
      );
    } else {
      String ctrUploadby="";
      if(responseDataDoc!.patientDocList!.elementAt(0).documentType.toString().toLowerCase().trim()=="patient")
      {
        ctrUploadby="Uploaded By\nPatient"/*responseDataDoc.patientDocList.elementAt(0).patientName*/;
      }else
      {
        ctrUploadby="Uploaded By\nDoctor"/*responseDataDoc.patientDocList.elementAt(0).doctorName*/;
      }
      return  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          CarouselSlider.builder(
            itemCount: responseDataDoc!.patientDocList!.length,
            options: CarouselOptions(
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              autoPlay: true,
            ),
            itemBuilder: (ctx, index, realIdx) {
              return  getView(index);
            },
          ),
          new Container(
            child: new Container(
              child : Text(ctrUploadby,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(CompanyColors.appbar_color),fontSize: 10,),),
              height: 25,
              margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
            ),
          ),

        ],
      );


    }
  }

  void _modalBottomSheetMenu(index) {
    var alertStyle = AlertStyle(
      overlayColor: Colors.transparent,
      animationType: AnimationType.fromTop,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Color.fromRGBO(91, 55, 185, 1.0),
      ),
    );
    Alert(
        context: mcontext,
        style: alertStyle,
        type: AlertType.info,
        title: "Alert",
        desc:"Paid Appointment cannot be cancelled. Please contact the hospital( Phone :"  ")to cancel the appointment.",
        buttons: []).show();
  }

  Future<Future> loadNormalDelete(
      AppointmentListJSon appointmentListJSon) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Cancel Appointment with reasons'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: Text('Cancel'),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                      if (posvalue == 0) {
                        mobCancelAppointment(
                            fList[posvalue].name.toString(), appointmentListJSon);
                        print('datareason :${fList[posvalue].name}');
                      } else {
                        print('datareason :${fList[posvalue - 1].name}');
                        mobCancelAppointment(
                            fList[posvalue - 1].name.toString(), appointmentListJSon);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
                content: Container(
                  width: double.minPositive,
                  height: 180,
                  child: Column(
                    children: fList
                        .map((data) => RadioListTile<int?>(
                      title: Text("${data.name.toString()}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          posvalue = val as int;
                          radioItem = data.name.toString();
                          print('data post : ${radioItem}');
                          id = data.index!;

                        });
                      },
                    ))
                        .toList(),
                  ),
                ),
              );
            },
          );
        });
  }

  String radioItem = 'Personal reason';
  int id = 1;
  int posvalue = 0;

  List<ReasonList> fList = [
    ReasonList(
      index: 1,
      name: "Personal reason",
    ),
    ReasonList(
      index: 2,
      name: "Finances",
    ),
    ReasonList(
      index: 3,
      name: "Doctor do not available",
    ),
  ];

  mobCancelAppointment(String reason,
      AppointmentListJSon appointmentListJSon) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    DeleteAppointmentRequest payload = new DeleteAppointmentRequest();
    payload.appointmentId = appointmentListJSon.appointmentId.toString();
    payload.registrationNo = appointmentListJSon.registrationNo.toString();
    payload.reasons = reason;
    DeleteAppointmentRequest payloadata =
    new DeleteAppointmentRequest.fromJson(payload.toJson());
    var response = await myService.MobCancelAppointment(payloadata);
    setState(() {
      responseDelete = response.body;
      if (deleteAlert != null) {
        deleteAlert();
      }
    });
  }

  Future<Future> deleteAlert() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Alert'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                      getViewAppointmentList();
                    },
                    child: Text('Ok'),
                  ),
                ],
                content: Container(
                  height: 100,
                  child: Center(
                    child: Text(responseDelete!.cancelMessage.toString()),
                  ),
                ),
              );
            },
          );
        });
  }
}

class ReasonList {
  String? name;
  int? index;

  ReasonList({this.name, this.index});
}
Widget noDataFound(BuildContext context) {
  /*new Future.delayed(new Duration(seconds: 2), () {
    Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
  });*/
  return new Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'No Record Found',
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ));
}