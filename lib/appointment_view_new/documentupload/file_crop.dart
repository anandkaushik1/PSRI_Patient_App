import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
final ImagePicker _picker = ImagePicker();
class ChooseAndCrop extends StatefulWidget {
  AppointmentListJSon? appointmentListJSon;

  ChooseAndCrop(this.appointmentListJSon);

  @override
  _ChooseAndCropState createState() =>
      _ChooseAndCropState(this.appointmentListJSon);
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ChooseAndCropState extends State<ChooseAndCrop> {
  AppointmentListJSon? appointmentListJSon;
  AppState? state;
  File? imageFile;
  String textfor = "Add Image";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? base64Image;
  String? status = '';
  String? errMessage = 'Error Uploading Image';
  String? uploadEndPoint =
      BasicUrl.baseUrl+'/SaveTeleConsultationDocument';

  _ChooseAndCropState(this.appointmentListJSon);

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Upload Image"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            getImageContainor(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: () {
                if (imageFile != null) {
                  if (null == imageFile) {
                    //setStatus(errMessage!);
                    showInSnackBar(errMessage!);
                    return;
                  }
                  String fileName = imageFile!.path.split('/').last;
                  upload(fileName);
                } else {
                  showInSnackBar("Please Select image first.");
                }
              },
              child: Text('Upload Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: () {
       /*   if (state == AppState.free)
            _chooseBottomSheet(context);
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();*/
        },
        label: _buildLable(),
        icon: _buildButtonIcon(),
      ),
    );
  }

  getImageContainor() {
    if (imageFile != null) {
      return Container(height: 250, child: Image.file(imageFile!));
    } else {
      return SizedBox(
        height: 10,
      );
    }
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free) {
      return Icon(
        Icons.add,
        color: Colors.white,
      );
    } else if (state == AppState.picked) {
      return Icon(Icons.crop, color: Colors.white);
    } else if (state == AppState.cropped) {
      return Icon(Icons.clear, color: Colors.white);
    } else {
      return Container();
    }
  }

  Widget _buildLable() {
    if (state == AppState.free) {
      return new Text(
        "Add Image",
        style: TextStyle(color: Colors.white),
      );
    } else if (state == AppState.picked) {
      return new Text(
        "Crop Image",
        style: TextStyle(color: Colors.white),
      );
    } else if (state == AppState.cropped) {
      return new Text(
        "Clear Image",
        style: TextStyle(color: Colors.white),
      );
    } else {
      return new Text(
        "Add Image",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState!
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Future<Null> _pickImage() async {
   /* imageFile = await ImagePicker!.pickImage(source: ImageSource.gallery!);
    if (imageFile != null) {
      setState(() {
        base64Image = base64Encode(imageFile!.readAsBytesSync());
        state = AppState.picked;
      });
    }*/
  }

  Future<Null> _camera() async {
   /* imageFile = await _pickImage.pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      setState(() {
        base64Image = base64Encode(imageFile!.readAsBytesSync());
        state = AppState.picked;
      });
    }*/
  }

  void _chooseBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150,
            child: new Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Center(
                  child: new Text(
                    "Choose Option ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                new ListTile(
                    leading: new Icon(
                      Icons.camera_alt,
                      color: Color(0xFF4a4a4a),
                    ),
                    title: Align(
                      child: new Text(" " + "Choose From Camera"),
                      alignment: Alignment(-1.2, 0),
                    ),
                    onTap: () => {Navigator.pop(context), _camera()}),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: SizedBox(
                    height: 0.5,
                    child: Container(
                      color: Color(0xFFc9c9c9),
                    ),
                  ),
                ),
                new ListTile(
                  leading: new Icon(
                    Icons.camera,
                    color: Color(0xFF4a4a4a),
                  ),
                  title: Align(
                    child:
                        new Text("Choose From Gallary" + " From Bottom"),
                    alignment: Alignment(-1.2, 0),
                  ),
                  onTap: () => {Navigator.pop(context), _pickImage()},
                ),
              ],
            ),
          );
        });
  }

 /* Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        base64Image = base64Encode(imageFile.readAsBytesSync());
        state = AppState.cropped;
      });
    }
  }*/

  void _clearImage() {
    imageFile = null;
    setState(() {
      base64Image = null;
      state = AppState.free;
    });
  }

  upload(String fileName) async {
//    "AppointmentId": "79170",
//    "DoctorId": "455",
//    "RegistrationId": "573057",
//    "Document": base64Image,
//    "EncodedBy": "1",
//    "HospitalLocationId": "1",
//    "FacilityId": "3",
//    "FileType":".jpg"

//    "AppointmentId": appointmentListJSon.appointmentId,
//    "DoctorId": appointmentListJSon.doctorId,
//    "RegistrationId": registrationId,
//    "Document": base64Image,
//    "EncodedBy": "1",
//    "HospitalLocationId": appointmentListJSon.hospitalLocationId,
//    "FacilityId": appointmentListJSon.facilityID,
//    "FileType": ".jpg"
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';

    Uri url =Uri.parse(uploadEndPoint!.toString());
    http.post(url, body: {
      "AppointmentId": appointmentListJSon!.appointmentId.toString(),
      "DoctorId": appointmentListJSon!.doctorId.toString(),
      "RegistrationId": registrationId.toString(),
      "Document": base64Image,
      "EncodedBy": "1",
      "HospitalLocationId": appointmentListJSon!.hospitalLocationId.toString(),
      "FacilityId": appointmentListJSon!.facilityID.toString(),
      "FileType": ".jpg"
    }).then((result) {
      if (result.statusCode == 200) {
        Navigator.of(context).pop();
      } else {
        //setStatus(result!.statusCode.toString() == 200 ? result!.body : errMessage);
      }
    }).catchError((error) {
      print('callinf eror : ${error.hashCode}');
      // setStatus(error);
    });
  }

 /* setStatus(String message) {
    print('message : $message');
    setState(() {
      status = message;
      if (status.contains("sucess")) {
      } else {
        showInSnackBar(status);
      }
    });
  }*/
}
