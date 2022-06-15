import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeRequest.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeResponse.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/TakeDoc_Screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/UploadDocumentRequest.dart';
import 'Model/UploadDocumentResponse.dart';

late BuildContext loaderContext,myContext;
String? doctorId,hospitalLocationId,registrationId,facilityId,myAppmnt,myEncounterId;
String uploadDoc="";
bool buttonVisibleFlg=false;
final ImagePicker _picker = ImagePicker();
class UploadDocWithType extends StatefulWidget {

  final String? myAppointmentId;
  final String? myDoctorId;
  final String? title;
  final String? regID;

  UploadDocWithType({
    Key? key,
    this.title,
    this.myDoctorId,
    this.myAppointmentId,
    this.regID
  }) : super(key: key);





  @override
  _MyHomePageState createState() => _MyHomePageState(title:title ,
    myAppointmentId: myAppointmentId,myDoctorId: myDoctorId,regID: regID
  );
}

class _MyHomePageState extends State<UploadDocWithType> {
  //final ImagePicker _imagePicker = ImagePickerChannel();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  XFile? _imageFile;
  String? myAppointmentId;
  String? myDoctorId;
  String? title;
  String? regID;
  _MyHomePageState({
    Key? key,
    this.title,
    this.myDoctorId,
    this.myAppointmentId,
    this.regID,
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myAppmnt="";
    hospitalLocationId =CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
    facilityId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ?? '';
    registrationId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    myEncounterId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_id) ?? '';
    doctorId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_id) ?? '';

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    myContext=context;
    return  FutureBuilder<DocTypeResponse>(

      future: callApi(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<DocTypeResponse> data) {  // AsyncSnapshot<Your object type>
        if( data.connectionState == ConnectionState.waiting){
          return Loading(context);
        }else{
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10, fontWeight: FontWeight.w500),),
                )
            );
          else
            {
              if(data.requireData.status.toString().toLowerCase().trim()=="success")
                {
                  return  layout(data.requireData);
                }else{
                  return   new Container(
                      color: Colors.white,
                      child: Center(
                        child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10, fontWeight: FontWeight.w500),),
                      )
                  );
              }

            }

        }
      },
    );



  }



    Widget layout(DocTypeResponse dropDownData)
    {
      return   Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload Documents',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        body: TakeDoc_Screen(
          myAppointmentId: myAppointmentId,
          myDoctorId: myDoctorId,
          title: title,
          dropDownData:dropDownData ,
          RegistrationID: regID,
        ),
      );
    }

  showAlerDialog(type, title, message,bool timeNoOff) {
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

       // Navigator.of(myContext, rootNavigator: true).pop();
      },
    )..show();
    if (timeNoOff){
      Timer(
          Duration(seconds: 2),
              () {
           // Navigator.of(myContext, rootNavigator: false).pop();
                Navigator.of(context).popUntil(ModalRoute.withName("/Dashbroad"));
          }

      );
    }
  }

  Future<DocTypeResponse>  callApi()
  async {
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    DocTypeRequest objddd=new DocTypeRequest();

    objddd.hospitalId=int.parse(hospitalLocationId.toString());

    objddd.source="P";
    print("Request  \n" + objddd.toJson().toString());

    DocTypeRequest objj=new DocTypeRequest.fromJson(objddd.toJson());
    Response<DocTypeResponse> responserrr = (await myService.GetDocumentType(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    DocTypeResponse res=new DocTypeResponse.fromJson(postt!.toJson());
    print("Response"+res.toJson().toString());

    return Future.value(res);
  }


  Widget Loading(BuildContext forThis){

    return new Container(
        color: Colors.white,
        child:SpinKitCubeGrid(size: 71.0, color:Color(CompanyColors.appbar_color)
        ));
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
                        child: SpinKitFadingCircle(size: 51.0, color: Color(0xff37b5ff))),
                    new Text("Please wait...",style: TextStyle(fontSize: 25 ,color: Color(0xff37b5ff)),),
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

