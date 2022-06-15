import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
class UploadDoc extends StatefulWidget {
  UploadDoc() : super();
  @override
  _UploadDocState createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  //
  static final String uploadEndPoint =
      BasicUrl.baseUrl+'/SaveTeleConsultationDocument';
  Future<File>? file;
  String status = '';
  String? base64Image;
  File? tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
    //  file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String? fileName = tmpFile!.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) {
    Uri uploadEndPoint =Uri.parse(fileName);
    http.post(uploadEndPoint, body: {
      "AppointmentId": "79170",
      "DoctorId": "455",
      "RegistrationId": "573057",
      "Document": base64Image,
      "EncodedBy": "1",
      "HospitalLocationId": "1",
      "FacilityId": "3",
      "FileType":".jpg"
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot!.data!) {
          tmpFile = snapshot!.data!;
          base64Image = base64Encode(snapshot.data!.readAsBytesSync());
          return Flexible(
            child: Image.file(
              snapshot!.data!,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Choose Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('Upload Image'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}