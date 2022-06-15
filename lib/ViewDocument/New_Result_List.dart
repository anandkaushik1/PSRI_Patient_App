import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/ViewDocument/DocumnetList_Response.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';


String? lastDate = "";
int nextIndex = 0;
double selectMargn = 0;

class New_Result_List extends StatelessWidget {
  final List<PatientDocList>? LabInfoArray;
  final double? width;
  final double? height;
  final PatientDocList? labResult;
  final int? pos;
  final String? regId;

  const New_Result_List({
    Key? key,
    this.width,
    this.height,
    this.labResult,
    this.pos,
    this.LabInfoArray,
    this.regId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){

    },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: height!.toDouble(),
          maxWidth: MediaQuery.of(context).size.width,
        ),
      child: Container(
     /*   width: width,
        height: height,*/
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(CompanyColors.shadow_color),
              blurRadius: 4.0,
              offset: const Offset(0.0, 4.0),
            ),
          ],
        ),
        child: new Column(
          children: <Widget>[

            InkWell(

              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Text(
                          getUploadedText(),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            color: Colors.white,
                            child: getView(),
                          ),
                        ),
                        // actions: [
                        //   RaisedButton(
                        //       child: Text("Cancle"),
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //       })
                        // ],
                      );
                    });
              },
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name : ${labResult!.patientName.toString()}",
                            style: TextStyle(
                                color: Colors.black54, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Doctor : ${labResult!.doctorName.toString()} ",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(getUploadedText(),
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300)),

                        ],
                      ),

                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Doc Type : ${labResult!.docNameType.toString()} ",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),



                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Date/Time  : ${labResult!.uploadedOn.toString()} ",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),

                      //Text("Dr R. Verma  "+ dateValue, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                    ],
                  ),

                  new Container(
                    height: 60.0,
                    width: 60.0,
                    color: Colors.white,
                    child: new SvgPicture.asset(
                        'assets/New_Icons/view-doc.svg',
                        height: 50,
                        width: 50,
                        fit: BoxFit.fill,
                      ),
                      //onPressed: onDelete,

                  ),
                  new GestureDetector(
                    onTap: () {
                      String? path =
                          BasicUrl.baseUrlDoc+'/API/ShowFile/DownloadAttachmentNew?fileName='+labResult!.document.toString();
                      _save(context,path);
                    }, // Image tapped
                    child: Image.asset(
                      'assets/New_Icons/download.png',
                      fit: BoxFit.cover, // Fixes border issues
                      width: 40.0,
                      height: 40.0,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),),
    );
  }
  _save(BuildContext context,String? url) async {
    var response = await Dio().get(url.toString(),
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      //quality: 60,
      // name: "hello"
    );
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Image Dowanload Sucessfully")));
    print(result);
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // FlatButton(
  // onPressed: () {
  // launchURL(BasicUrl.sendUrlTestingImage() +
  // labResult.encryptedDocument);
  // },
  // child: Text(
  // "Download",
  // ),
  // )

  getView(){

    if (labResult!.document!.toString().contains('.pdf')) {

      return Container(
        child: Center(
            child:  RaisedButton(
              color: Color(CompanyColors.appbar_color),
                child: Text("Download", style: (
                TextStyle(color: Colors.white)
                ),),
                onPressed: () {
                  launchURL(BasicUrl.sendUrlTestingImage() + labResult!.encryptedDocument!.toString());
                },
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0))
            )
        ),



      );

    } else {
      return Container(
          child: Image.network(
            BasicUrl.sendUrlTestingImage() +
                labResult!.encryptedDocument.toString(),
            fit: BoxFit.fill,
          ));
    }



  }


  getUploadedText() {
    if (labResult!.documentType == "Patient") {
      return 'Uploaded By ${labResult!.patientName.toString()}';
    } else {
      return 'Uploaded By ${labResult!.doctorName.toString()}';
    }
  }



  Widget layoutHeaderDate(String? Date) {
    return new Visibility(
      visible: true,
      child: new Container(
          child: new Text(
            Date.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 13.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(6.0),
            color: Color(CompanyColors.appbar_color),
          ),
          height: 30,
          width: 130,
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center),
    );
  }


}
