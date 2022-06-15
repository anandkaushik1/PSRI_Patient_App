import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/CustomDropDown.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeResponse.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Model/UploadDocumentRequest.dart';
import 'Model/UploadDocumentResponse.dart';

late BuildContext loaderContext,myContext,alertContext;
String? doctorId,hospitalLocationId,registrationId,facilityId,myAppmnt;
String uploadDoc="";
bool buttonVisibleFlg=false;
final ImagePicker _picker = ImagePicker();
class TakeDoc_Screen extends StatefulWidget {

  final String? myAppointmentId;
  final String? myDoctorId;
  final String? title;
  final String? RegistrationID;
  final DocTypeResponse? dropDownData;

  TakeDoc_Screen({
    Key? key,
    this.title,
    this.myDoctorId,
    this.myAppointmentId,
    this.dropDownData,
    this.RegistrationID
  }) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState(title:title ,
    myAppointmentId: myAppointmentId,myDoctorId: myDoctorId,dropDownData: dropDownData,RegistrationID: RegistrationID
  );
}

class _MyHomePageState extends State<TakeDoc_Screen> {
  //final ImagePicker _imagePicker = ImagePickerChannel();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  XFile? _imageFile;
  final picker = ImagePicker();
  String? myAppointmentId;
  String? myDoctorId;
  String? title;
  String? RegistrationID;
  DocTypeResponse? dropDownData;
  _MyHomePageState({
    Key? key,
    this.title,
    this.myDoctorId,
    this.myAppointmentId,
    this.dropDownData,
    this.RegistrationID
  });
  Future<void> captureImage(ImageSource? imageSource) async {
    try {
      final imageFile = await _picker.pickImage(source: imageSource!);

      setState(() {

        _imageFile = imageFile!;
        if(_imageFile!=null) {
          buttonVisibleFlg = true;
          }else{
          buttonVisibleFlg = false;
        }
      });
      if(_imageFile!=null) {
        List<int> imageBytes = await _imageFile!.readAsBytes();
        String base64Image = base64Encode(imageBytes);
        uploadDoc=base64Image;
        print(base64Image);
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _buildImage() {
    if (_imageFile != null) {
      return new Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child:  Image.file(File(_imageFile!.path)),
      );
    } else {
      return  GestureDetector(
        child:  new Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text('Take an image', style: TextStyle(fontSize: 18.0)),
          ),
        ),
        onTap: () {
          captureImage(ImageSource.gallery);
        },
      );

    }
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
       // _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // imageSelectorGallery() async {
  //   fileProfilePicture = await ImagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );
  //
  //   if(fileProfilePicture != null) {
  //     setState(() {
  //       uploadPicture();
  //     });
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buttonVisibleFlg=false;
    myAppmnt=myAppointmentId;
    hospitalLocationId =CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
    facilityId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ?? '';
    registrationId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ?? '';
    doctorId=myDoctorId;

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    buttonVisibleFlg=false;
  }

  @override
  Widget build(BuildContext context) {
    myContext=context;
    alertContext=context;
    return Scaffold(

      /*  appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Upload Prescriptions',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),*/
      body:new Stack(
        children: [
          Align(

            child: new Container(
              margin: EdgeInsets.fromLTRB(30, 70, 30, 100),
              child: Column(
                children: [
                  /*Expanded(
                    flex: 10,
                    child:CustomDropDown(patientlist:dropDownData.documentTypeList) ,
                  ),*/
                  Expanded(
                      flex: 90,
                      child: Center(
                    child: Column(
                      children: [
                        new Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: _buildImage(),
                        ),

                        new  Visibility(
                        visible: true,
                          child:new Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: Colors.blueAccent,
                            alignment: Alignment.center,
                            child: GestureDetector(
                            child: Text("Upload Document",style: TextStyle(color: Colors.white),),
                            onTap: () {
                              callApi(context);

                              /*if(CommonStrAndKey.typeOfDocDropDown.documentId!=0)
                                {
                                  callApi(context);
                                }else
                                  {
                                    showAlerDialogOnlyMsg(DialogType.ERROR,"Validation","Please select document type",false);
                                 }
*/
                            },
                          ),),


                        ),
                      ],
                    ),
                  )
                  ),

                ],
              ),
            ),
            alignment: Alignment.center,
          ),

         /* Align(
            alignment: Alignment.bottomCenter,
            child:_buildButtons(),
          ),*/
          Align(
            alignment: Alignment.bottomCenter,
            child: new Container(
              height: 55,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: new Container(
                      height: 55,
                      child: new RaisedButton(
                        color: Color(0xff009900),
                        textColor: Colors.black,
                        splashColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                            side: BorderSide(color: Color(0xffffffff))),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Gallery',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                // decoration: TextDecoration(BlendMode.color))
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          captureImage(ImageSource.gallery);
                        },
                      ),
                    ),


                  ),
                  Expanded(
                    flex: 1,
                    child: new Container(
                      height: 55,
                      child: new RaisedButton(
                        color: Color(0xffeb3436),
                        textColor: Colors.black,
                        splashColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(3.0),
                            side: BorderSide(color: Color(0xffeb3436))),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Camera',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                // decoration: TextDecoration(BlendMode.color))
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          captureImage(ImageSource.camera);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )



    );
  }

/*
  Widget _buildButtons() {
    return ConstrainedBox(
        constraints: BoxConstraints.expand(height: 80.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildActionButton(
                key: Key('retake'),
                text: 'Photos',
                onPressed: () => captureImage(ImageSource.gallery),
              ),
              _buildActionButton(
                key: Key('upload'),
                text: 'Camera',
                onPressed: () => captureImage(ImageSource.camera),
              ),
            ]));
  }

  Widget _buildActionButton({Key? key, String? text, Function? onPressed}) {
    return Expanded(
      child: FlatButton(
          key: key,
          child: Text(text.toString(), style: TextStyle(fontSize: 20.0)),
          shape: RoundedRectangleBorder(),
          color: Colors.blueAccent,
          textColor: Colors.white,
          onPressed: onPressed),
    );
  }
*/

  Future  callApi(BuildContext context)
  async {
    _onLoading(context);
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    UploadDocumentRequest setObj=new UploadDocumentRequest();
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registrationIdData = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    setObj.doctorId=""+doctorId!.toString();
    setObj.appointmentId=""+myAppmnt!.toString();
    setObj.hospitalLocationId="1";
    setObj.fileType=".jpg";
    setObj.registrationId=""+RegistrationID!.toString();
    setObj.encodedBy="1";
    setObj.document=""+uploadDoc;
    //setObj.document="abc";

    setObj.facilityId="3";
   // setObj.documentTypeId= CommonStrAndKey.typeOfDocDropDown.documentId;
    setObj.documentTypeId= 6;



    print("==========================================================================");
    print("Request  \n"+setObj.toJson().toString());
    UploadDocumentRequest obj=new UploadDocumentRequest.fromJson(setObj.toJson());
    print("Request  \n"+setObj.toJson().toString());
    Response<UploadDocumentResponse> response = (await myService.SavePatientDocumentNew(obj));

    var post = response.body;
    UploadDocumentResponse res=new UploadDocumentResponse.fromJson(post!.toJson());


    print("Response ${post.toJson().toString()}");
    if(response!=null)
    {
     // Navigator.pop(myContext);
      if(response.body!.status !=null) {
      if(response.body!.status!.toString().toString().toLowerCase()=="success")
        {
        showAlerDialog(DialogType.SUCCES, 'Info', response.body!.msg,true);
      } else {
        showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg,false);
      }
      }else{
      showAlerDialog(DialogType.ERROR, 'Error', response.body!.msg,false);

    }
    }


  }

  void showAlerDialog(type, title, message,bool timeNoOff) {
    AwesomeDialog dialog;

    dialog = AwesomeDialog(
      context: loaderContext,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {

        Navigator.of(myContext, rootNavigator: true).pop();
      },
    )..show();
    if (timeNoOff){
      Timer(
          Duration(seconds: 3),
              () {
            //Navigator.of(myContext).pop();
           // Navigator.of(myContext).pop();
            Navigator.of(myContext)
                .popUntil(ModalRoute.withName("/MyBook_Appointment"));
          }

      );
    }
  }

  void showAlerDialogOnlyMsg(type, title, message,bool timeNoOff) {
    AwesomeDialog dialog;

    dialog = AwesomeDialog(
      context: alertContext,
      animType: AnimType.SCALE,
      dialogType: type,
      title: title,
      body: Center(
        child: Text(
          message,
        ),
      ),
      btnOkOnPress: () {

        //Navigator.of(alertContext, rootNavigator: true).pop();
        //dialog.dissmiss();
      },
    )..show();

  }

  void saveData(UploadDocumentResponse patientDetails) async
  { /// save Doctor details
    /*final SharedPreferences setDoctorInfo = await SharedPreferences.getInstance();
    setDoctorInfo.setString(CommonStrAndKey.myRegistrationId, ""+patientDetails.registrationId.toString());
    setDoctorInfo.setString(CommonStrAndKey.myRegistrationNo, ""+patientDetails.registrationId.toString());
    Navigator.pop(context);*/
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

