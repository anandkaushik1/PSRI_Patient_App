import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/CaseSheet_List.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/CustomPdfReader.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Discharge_Summary_Request.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Discharge_Summary_Response.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/FullCaseReport.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Full_Data_Request.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_List.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Prescription_Full_Data_Response.dart';
import 'VisitHistoryResponse.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

Prescription_Full_Data_Response res = new Prescription_Full_Data_Response();
Discharge_Summary_Response dataDischarge_Summary =
    new Discharge_Summary_Response();
String encounterNo = "";
Prescription_Full_Data_Request? visit;

class Prescription_Card_List extends StatefulWidget {
  String? encounterNo = "";
  VisitHistory? visit;

  Prescription_Card_List({
    Key? key,
    this.encounterNo,
    this.visit,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        encounterNo: this.encounterNo,
        visit: this.visit,
      );
}

class _CardListScreenState extends State<Prescription_Card_List> {
  String? encounterNo = "";
  VisitHistory? visit;

  _CardListScreenState({
    Key? key,
    this.encounterNo,
    this.visit,
  });

  @override
  Widget build(BuildContext context) {
    return DoxperDischargeSummeryOrPrescription(visit!.oPIP!.toString(), visit!);
  }

  Widget casesheetlayout(BuildContext context, List<FullCaseReport> labData) {
    return Scaffold(
      appBar: patientDetails(context,visit!),
      backgroundColor: Color(CompanyColors.grey),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: labData.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                        minHeight: 100,
                        maxWidth: MediaQuery.of(context).size.width,
                      ),
                      child: CaseSheet_List(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        PreResult: labData.elementAt(index),
                        //  DataLabDetails:res.doctorLabDetails.elementAt(index),
                        pos: index,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget ApiHit(VisitHistory visit) {
    return FutureBuilder<Discharge_Summary_Response>(
      future: DischargeSummeryRequest(visit), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<Discharge_Summary_Response> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(
                        color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ));
          else {
            if (data.requireData.patientSummary != null &&
                data.requireData.patientSummary != "") {
              return DisChargeSummrylayout(data.requireData.patientSummary.toString());
            } else {
              return new Container(
                decoration: BoxDecoration(color: Colors.white),
                child: new Center(
                  child: new Text(
                    "No Record Found ",
                    style: TextStyle(
                        color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              );
            }
          }
        }
      },
    );
  }
  Widget DoxperDischargeSummeryOrPrescription(String flg, VisitHistory data) {
    if (flg.toLowerCase() == "o") {
      // return layout();
      return ApiHitCaseSheet(data);
    } else {
      return ApiHit(data);
    }
  }
  Widget ApiHitCaseSheet(VisitHistory visit) {
    return FutureBuilder<Prescription_Full_Data_Response>(
      future: callApi(visit), // function where you call your api
      builder: (BuildContext context,
          AsyncSnapshot<Prescription_Full_Data_Response> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(
                        color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ));
          else {
            if (data.requireData.cashesheetSummary != null &&
                data.requireData.cashesheetSummary != "" &&
                data.requireData.cashesheetSummary!.length > 0) {
              List<FullCaseReport> caseTempData =
              setCasesheetData(data.requireData);
              if (caseTempData != null) {
                return casesheetlayout(context, caseTempData);
              } else {
                return new Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: new Center(
                    child: new Text(
                      "No Record Found ",
                      style: TextStyle(
                          color: Color(CompanyColors.appbar_color),
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                );
              }
            } else {
              return new Container(
                decoration: BoxDecoration(color: Colors.white),
                child: new Center(
                  child: new Text(
                    "No Record Found ",
                    style: TextStyle(
                        color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              );
            }
          }
        }
      },
    );
  }

  Widget DisChargeSummrylayout(String dataHtml) {
    if (dataHtml == null && dataHtml == "") {
      dataHtml =
      "<html>    <body>  <p>This is a paragraph.</p>  </body>  </html>";
    }
    return Scaffold(
      backgroundColor: Color(CompanyColors.grey),
      appBar: patientDetails(context ,visit!),
      body: SafeArea(
        child: AnimationLimiter(
          child: SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  new Center(
                    child: new Text(
                      "Discharge Summary",
                      style: TextStyle(
                          color: Color(CompanyColors.appbar_color),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Html(
                      data: dataHtml,
                    ),
                  ),
                ],
              )),


        ),
      ),
    );
  }
  Widget layout() {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(

        child: AnimationLimiter(
          child: /*WebViewLibPlagin(),*/

          ListView.builder(

            padding: const EdgeInsets.all(8.0),
            itemCount: res.cashesheetSummary!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Prescription_List(
                      width: MediaQuery.of(context).size.width,
                      height: 88.0,
                      PreResult: res.cashesheetSummary!.elementAt(index),
                      pos: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}





Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(
          size: 71.0, color: Color(CompanyColors.appbar_color)));
}

/*Widget webViewData() {
  return WebView(
      initialUrl:
          "https://doxper.com/doc/visit_patient_prescription/?patient_id=534489&visit_id=1423036&organisation=BLK&token=c6bf1fc14da7a418b1da84d0f3a19a2f35e3f17d");
}*/

Widget WebViewLibPlagin() {
  return new Container(
    child: new WebviewScaffold(
      url:
          "https://doxper.com/doc/visit_patient_prescription/?patient_id=534489&visit_id=1423036&organisation=BLK&token=c6bf1fc14da7a418b1da84d0f3a19a2f35e3f17d",
      withZoom: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    ),
    margin: EdgeInsets.only(top: 120),
  );
}



PreferredSize patientDetails(BuildContext context,VisitHistory myDoctor) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(CompanyColors.grey),
      ),
      height: 60,
      child: Column(
        children: [

          new Container(
            margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
            child: Row(
              children: [

                Expanded(
                  flex: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Flexible(
                            child :Text("" + myDoctor.doctorName.toString(),
                              style: TextStyle(
                                  color: Color(CompanyColors.appbar_color),fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                               overflow: TextOverflow.ellipsis,
                            ),

                          ),
                          Text("Encounter No : " + myDoctor.encounterNo.toString(),
                              style: TextStyle(
                                  color: Color(CompanyColors.appbar_color),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),

                        ],
                      ),

                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: (myDoctor.oPIP.toString().toLowerCase().trim() == "o" && myDoctor.isTeleconsultation!)? true : false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child :Text("Download Prescription" ,
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),fontSize: 16,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SizedBox(
                              width: 10.0,
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CustomPdfReader(
                                  encounterNo: myDoctor.encounterNo,
                                  regNo: myDoctor.regNo,
                                ))

                                );

                              }, // ndle your image tap here
                              child: Image.asset(
                                'assets/icons/newdownload.png',
                                fit: BoxFit.cover, // this is the solution for border
                                width: 35.0,
                                height: 35.0,
                              ),
                            )

                          ],
                        ),
                      ),




                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Future<Discharge_Summary_Response> DischargeSummeryRequest(VisitHistory data) async {
  String url = BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  Discharge_Summary_Request objddd = new Discharge_Summary_Request();

  objddd.encounterId = "" + data.encounterId!.toString();
  objddd.registrationNo = "" + data.regNo!.toString();

  Discharge_Summary_Request objj =
      new Discharge_Summary_Request.fromJson(objddd.toJson());
  Response<Discharge_Summary_Response> responserrr =
      (await myService.GetPatientDischargeSummary(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  dataDischarge_Summary =
      new Discharge_Summary_Response.fromJson(postt!.toJson());
  return Future.value(dataDischarge_Summary);
}

Future<Prescription_Full_Data_Response> callApi(VisitHistory data) async {
  String url = BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  Prescription_Full_Data_Request objddd = new Prescription_Full_Data_Request();

  objddd.encounterId = "" + data.encounterId!.toString();
  objddd.hospitalId = "" + data.hospitalId!.toString();
  objddd.facilityId = "" + data.facilityID.toString();
  objddd.registrationId = "" + data.registrationId!.toString();
  objddd.fromDate = "1900-01-01 00:00";
  objddd.todate = "2079-01-01 23:59";
  print("Request  \n" + objddd.toJson().toString());
  Prescription_Full_Data_Request objj =
      new Prescription_Full_Data_Request.fromJson(objddd.toJson());
  Response<Prescription_Full_Data_Response> responserrr =
      (await myService.GetPatientCashsheet(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new Prescription_Full_Data_Response.fromJson(postt!.toJson());
  return Future.value(res);
}

List<FullCaseReport> setCasesheetData(Prescription_Full_Data_Response setData) {
  List<FullCaseReport> viewAryListData= <FullCaseReport>[];
  for (int a = 0; a < setData.cashesheetSummary!.length; a++) {
    if (setData != null) {
      if (setData.cashesheetSummary != null) {
        if (setData.cashesheetSummary!.length > 0) {
          if (setData.cashesheetSummary!
                  .elementAt(a)
                  .status
                  .toString()
                  .toLowerCase() ==
              "true") {
            CashesheetSummary casesheetData =
                setData.cashesheetSummary!.elementAt(a);



            if (casesheetData.allergyStatus.toString().trim().toLowerCase() ==
                "true") {
                viewAryListData.addAll(GetAllergyData(casesheetData.allergy!));

            }
            if (casesheetData.eMRPatientOrdersStatus.toString().toLowerCase() ==
                "true") {
              viewAryListData.addAll(
                  GetEMRPatientOrdersData(casesheetData.eMRPatientOrders!));
            }
            if (casesheetData.chiefComplainStatus.toString().toLowerCase() ==
                "true") {
              viewAryListData
                  .addAll(GetChiefComplainData(casesheetData.chiefComplain!));
            }
            if (casesheetData.diagnosisStatus.toString().toLowerCase() ==
                "true") {
              viewAryListData.addAll(GetDiagnosisData(casesheetData.diagnosis!));
            }
            if (casesheetData.progressNotesStatus.toString().toLowerCase() ==
                "true") {
              viewAryListData
                  .addAll(GetProgressNotesData(casesheetData.progressNotes!));
            }
            if (casesheetData.patientReferralHistoryStatus
                    .toString()
                    .toLowerCase() ==
                "true") {
              viewAryListData.addAll(GetPatientReferralHistoryData(
                  casesheetData.patientReferralHistory!));
            }

            if (casesheetData.patientMedicationStatus
                    .toString()
                    .toLowerCase() ==
                "true") {
              viewAryListData.addAll(
                  GetPatientMedicationData(casesheetData.patientMedication!));
            }
            if (casesheetData.vitalStatus.toString().toLowerCase() == "true") {
              viewAryListData.addAll(GetVitalData(casesheetData.vital!));
            }
            if (casesheetData.templateStatus.toString().toLowerCase() ==
                "true") {
              viewAryListData.addAll(GetGtratmentGiven(casesheetData.template!));
            }
            /*if(casesheetData.fieldStatus.toString().toLowerCase()=="true")
                   {
                    //// viewAryListData.addAll(Getf);
                   }*/
          }
        }
      }
    }
  }
  return viewAryListData;
}

List<FullCaseReport> GetAllergyData(List<Allergy> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {

    if (data.elementAt(i).status.toString().trim().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i==0) {
        returnData.titleName = "Allergy";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName = "";
      returnData.firstLinedetails =
          "" + data.elementAt(i).allergyName.toString();
      returnData.secLinedetails = "" + data.elementAt(i).remarks.toString();
      returnData.thirdLinedetails = "";
      returnData.date = "" + data.elementAt(i).allergyDate.toString();
      returnData.enterBy = "";
      tempList.add(returnData);
    }
  }

  return tempList;
}

List<FullCaseReport> GetChiefComplainData(List<ChiefComplain> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i == 0) {
        returnData.titleName = "Chief Complaint";
      } else {
        returnData.titleName = "";
      }
     /* returnData.subTitleName = "" +removeAllHtmlTags( data
          .elementAt(i)
          .problemDescription
          .toString());*/
      returnData.firstLinedetails =
          "" + data.elementAt(i).problemDescription.toString().replaceAll("<br/>", "\n");
      returnData.secLinedetails =
          "" + data.elementAt(i).duration.toString().replaceAll("<br/>", "\n");
      returnData.thirdLinedetails = ""+data.elementAt(i).location.toString().replaceAll("<br/>", "\n");;
      returnData.date = "" +
          data.elementAt(i).encodedDate.toString().replaceAll("<br/>", "\n");
      returnData.enterBy = "";
      tempList.add(returnData);
    }
  }

  return tempList;
}

List<FullCaseReport> GetDiagnosisData(List<Diagnosis> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i == 0) {
        returnData.titleName = "Diagnosis";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName =
          "" + data.elementAt(i).iCDDescription.toString();
      returnData.firstLinedetails = "";
      returnData.secLinedetails = "" + data.elementAt(i).remarks.toString();
      returnData.thirdLinedetails = "";
      returnData.date = "" + data.elementAt(i).onsetDate.toString();
      returnData.enterBy = "";
      tempList.add(returnData);
    }
  }
  return tempList;
}

List<FullCaseReport> GetProgressNotesData(List<ProgressNotes> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i == 0) {
        returnData.titleName = "Progress Notes";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName = data.elementAt(i).progressNote.toString();
      returnData.firstLinedetails =
          "" + data.elementAt(i).doctorName.toString();
      returnData.secLinedetails = "" + data.elementAt(i).encodedDate.toString();
      returnData.thirdLinedetails = "";
      returnData.date = "" + data.elementAt(i).encodedDate.toString();
      returnData.enterBy = "";
      tempList.add(returnData);
    }
  }
  return tempList;
}

List<FullCaseReport> GetPatientReferralHistoryData(
    List<PatientReferralHistory> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i == 0) {
        returnData.titleName = "Referral History";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName =
          "" + data.elementAt(i).reasonforReferral.toString();
      returnData.firstLinedetails =
          "" + data.elementAt(i).referralReply.toString();
      returnData.secLinedetails =
          "" + data.elementAt(i).referralReplyBy.toString();
      returnData.thirdLinedetails = "";
      returnData.date = "" + data.elementAt(i).referralDate.toString();
      returnData.enterBy = "" + data.elementAt(i).referralDoctor.toString();
      tempList.add(returnData);
    }
  }
  return tempList;
}

List<FullCaseReport> GetEMRPatientOrdersData(List<EMRPatientOrders> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];


  for (int i = 0; i < data.length; i++) {
    FullCaseReport returnData = new FullCaseReport();
    if (data.elementAt(i).status.toString().toLowerCase() == "success") {
      String subDeptName = data.elementAt(i).subDepartment.toString();
      List<SubEMRPatientOrders> subEMRPatientOrders =
          data.elementAt(i).subEMRPatientOrders!;
      for (int j = 0; j < subEMRPatientOrders.length; j++) {
        if (subEMRPatientOrders.elementAt(j).status.toString().toLowerCase() ==
            "true") {
          returnData = new FullCaseReport();
          if (j == 0) {
            if (i == 0) {
              returnData.titleName = "Orders";
            } else {
              returnData.titleName = "";
            }
            returnData.subTitleName = "\n" + subDeptName.toString();
          } else {
            returnData.subTitleName = "";
            returnData.titleName = "";
          }
          returnData.firstLinedetails =
              subEMRPatientOrders.elementAt(j).orders.toString();

          returnData.secLinedetails = "";
          returnData.thirdLinedetails = "";
          returnData.date =
              "\n " + subEMRPatientOrders.elementAt(j).date.toString();
          returnData.enterBy =
              "\n " + subEMRPatientOrders.elementAt(j).enteredby.toString();
          tempList.add(returnData);
        }
      }
    }
  }
  return tempList;
}

List<FullCaseReport> GetPatientMedicationData(List<PatientMedication> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    FullCaseReport returnData = new FullCaseReport();
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      if (i == 0) {
        returnData.titleName = "Medication";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName = "" + data.elementAt(i).itemName.toString();
      returnData.firstLinedetails =
          "" + data.elementAt(i).prescriptionDetails.toString();
      returnData.secLinedetails =
          "" + data.elementAt(i).instructions.toString();
      returnData.thirdLinedetails = "";
      returnData.date = "" + data.elementAt(i).indentDate.toString();
      returnData.enterBy = "" + data.elementAt(i).enteredby.toString();
      tempList.add(returnData);
    }
  }
  return tempList;
}

List<FullCaseReport> GetVitalData(List<Vital> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();
      if (i == 0) {
        returnData.titleName = "Vital";
      } else {
        returnData.titleName = "";
      }
      returnData.subTitleName = "";
      returnData.firstLinedetails = "1. Height " +
          data.elementAt(i).height.toString() +
          "</br>2. Weight " +
          data.elementAt(i).weight.toString() +
          "</br>3. Temperature " +
          data.elementAt(i).temperature.toString();
      returnData.secLinedetails = "4. Pulse " +
          data.elementAt(i).pulse.toString() +
          "</br>5. BP Diastolic " +
          data.elementAt(i).bPDiastolic.toString() +
          "</br>6. BP Systolic " +
          data.elementAt(i).bPSystolic.toString();
      returnData.thirdLinedetails = "</br>7. Head Circumference " +
          data.elementAt(i).headCircumference.toString() +
          "</br>8. BMI " +
          data.elementAt(i).bMI.toString() +
          "</br>9. SPO2 " +
          data.elementAt(i).sPO2.toString() +
          "</br>10. MAC" +
          data.elementAt(i).mAC.toString();
      returnData.date = "" + data.elementAt(i).vitalDate.toString();
      returnData.enterBy = ""+data.elementAt(i).enteredby.toString();
      tempList.add(returnData);
    }
  }
  return tempList;
}

List<FullCaseReport> GetTemplateData(List<Template> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];
  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().trim().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();

      List<Section> tempSection= <Section>[];
      tempSection = data.elementAt(i).section!;
      if (tempSection != null) {
        if (tempSection.length > 0) {
          for (int j = 0; j < tempSection.length; j++) {
            if (tempSection.elementAt(j).sectionId.toString().isNotEmpty) {
              List<FieldData> tempField= <FieldData>[];
              tempField = tempSection.elementAt(j).field!;
              if (tempField != null) {
                if (tempField.length > 0) {
                  for (int k = 0; k < tempField.length; k++) {
                    returnData = new FullCaseReport();
                    if (i == 0) {
                      returnData.titleName = data.elementAt(0).templateName;
                    } else {
                      returnData.titleName = "";
                    }
                    if (j == 0) {
                      returnData.subTitleName = tempSection
                          .elementAt(0)
                          .sectionName
                          .toString()
                          .replaceAll("<br/>", "\n");
                    } else {
                      returnData.subTitleName = "";
                    }
                    returnData.firstLinedetails = "";
                    returnData.secLinedetails = "" +
                        tempField
                            .elementAt(k)
                            .fieldName
                            .toString()
                            .replaceAll("<br/>", "\n")
                            .replaceAll("<br />", "");
                    returnData.thirdLinedetails = "" +
                        tempField
                            .elementAt(k)
                            .textValue
                            .toString()
                            .replaceAll("<br/>", "\n")
                            .replaceAll("<br />", "");
                    returnData.date =
                        "" + tempField.elementAt(k).groupDate.toString();
                    returnData.enterBy =
                        "" + tempField.elementAt(k).enterBy.toString();
                    tempList.add(returnData);
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return tempList;
}

List<FullCaseReport> GetSectionData(List<Section> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];

  for (int i = 0; i < data.length; i++) {
    FullCaseReport returnData = new FullCaseReport();
    if (i == 0) {
      returnData.titleName = "" + data.elementAt(i).sectionName!.toString();
    } else {
      returnData.titleName = "";
    }
    returnData.subTitleName = data.elementAt(i).sectionName;
    returnData.firstLinedetails = "";
    returnData.secLinedetails = "";
    returnData.thirdLinedetails = "";
    returnData.date = "" + data.elementAt(i).sectionId.toString();
    returnData.enterBy = "";
    tempList.add(returnData);
  }
  return tempList;
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
  );

  return htmlText.replaceAll(exp, '');
}

List<FullCaseReport> GetGtratmentGiven(List<Template> data) {
  List<FullCaseReport> tempList= <FullCaseReport>[];
  for (int i = 0; i < data.length; i++) {
    if (data.elementAt(i).status.toString().trim().toLowerCase() == "true") {
      FullCaseReport returnData = new FullCaseReport();

      List<Section> tempSection= <Section>[];
      tempSection = data.elementAt(i).section!;
      if (tempSection != null) {
        if (tempSection.length > 0) {
          for (int j = 0; j < tempSection.length; j++) {
            if (tempSection.elementAt(j).sectionId.toString().isNotEmpty) {
              List<FieldData> tempField= <FieldData>[];
              tempField = tempSection.elementAt(j).field!;
              if (tempField != null) {
                if (tempField.length > 0) {
                  for (int k = 0; k < tempField.length; k++) {
                    returnData = new FullCaseReport();
                    if(tempField
                        .elementAt(k)
                        .textValue
                        .toString()
                        .replaceAll("<br/>", "\n")
                        .replaceAll("<br />", "").isEmpty) {
                    }else{
                      if (i == 0 && k==0) {
                        returnData.titleName = data.elementAt(0).templateName;
                      } else {
                        returnData.titleName = "";
                      }
                      print('chotu 2 :${data.elementAt(0).templateName}');

                      if (j == 0) {
                        returnData.subTitleName = tempSection
                            .elementAt(0)
                            .sectionName
                            .toString()
                            .replaceAll("<br/>", "\n");
                      } else {
                        returnData.subTitleName = "";
                      }

                      returnData.firstLinedetails = "";
                      returnData.secLinedetails = "" +
                          tempField
                              .elementAt(k)
                              .fieldName
                              .toString()
                              .replaceAll("<br/>", "\n")
                              .replaceAll("<br />", "");
                      returnData.thirdLinedetails = "" +
                          tempField
                              .elementAt(k)
                              .textValue
                              .toString()
                              .replaceAll("<br/>", "\n")
                              .replaceAll("<br />", "");

                      returnData.date =
                          "" + tempField.elementAt(k).groupDate.toString();
                      returnData.enterBy =
                          "" + tempField.elementAt(k).enterBy.toString();
                      tempList.add(returnData);
                    }

                  }
                }
              }
            }
          }
        }
      }
    }
  }
  return tempList;
}