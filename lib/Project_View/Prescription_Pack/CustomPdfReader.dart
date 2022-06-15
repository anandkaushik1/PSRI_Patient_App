import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
//late
late PdfViewerController _pdfViewerController;
String MyencounterNo="", MyregNo= "";
final GlobalKey<SfPdfViewerState> _pdfViewerStateKey = GlobalKey();
class CustomPdfReader extends StatefulWidget {
  final String? encounterNo;
  final String? regNo;

  CustomPdfReader({
    Key? key,
    this.encounterNo,
    this.regNo,

  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
    encounterNo: encounterNo,
    regNo: regNo,


      );
}

class _CardListScreenState extends State<CustomPdfReader> {
  String? encounterNo;
  String? regNo;


  _CardListScreenState({
    Key? key,
    this.encounterNo,
    this.regNo,


  });

  @override
  void initState() {
    MyencounterNo=encounterNo!.toString();
    MyregNo= regNo!.toString();
    // TODO: implement initState
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Scaffold(
            body: SfPdfViewer.network(
                //'http://13.235.220.196:546/PatientDetails/PrintInvoicereceipt.aspx?InvId=94758&FacId=1',
                //'http://182.75.170.98:7878//PatientDetails/PrintPrescription.aspx?EncounterNo=830&RegNo=208543',

                'http://182.75.170.98:7878//PatientDetails/PrintPrescription.aspx?EncounterNo='+MyencounterNo+'&RegNo='+MyregNo,


                controller: _pdfViewerController,
                key: _pdfViewerStateKey),
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Pdf Viewer',
                style: TextStyle(fontSize: 16.0,color: Colors.white),
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(CompanyColors.appbar_color),
                          Color(CompanyColors.appbar_color)
                        ]),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(CompanyColors.appbar_color).withOpacity(.3),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 8.0)
                    ]),
              ),
              actions: <Widget>[
                // http://203.110.84.220:717/PatientDetails/PrintInvoicereceipt.aspx?InvId=896715&FacId=10

                IconButton(
                    onPressed: () {
                      MyencounterNo= encounterNo!.toString();
                      MyregNo= regNo!.toString();
                     // _launchURL('http://203.110.84.220:717/PatientDetails/PrintInvoicereceipt.aspx?InvId='+MyinvoiceId+'&FacId='+MyfacilityId);
                      _launchURL('http://182.75.170.98:7878//PatientDetails/PrintPrescription.aspx?EncounterNo='+MyencounterNo+'&RegNo='+MyregNo);

                      print('http://182.75.170.98:7878//PatientDetails/PrintPrescription.aspx?EncounterNo='+MyencounterNo+'&RegNo='+MyregNo);
                    },
                    icon: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    ))

                /*IconButton(
                    onPressed: () {
                      _pdfViewerController.zoomLevel = 1.25;
                    },
                    icon: Icon(
                      Icons.zoom_in,
                      color: Colors.white,
                    ))*/



              ],
            ),
          )),
    );



  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}





_launchURL(String url) async {
  //const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


