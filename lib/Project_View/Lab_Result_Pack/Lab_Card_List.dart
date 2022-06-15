

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabVisitResponse.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Request.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/RadilogyReport.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Result_List.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Lab_Report_Response res = new Lab_Report_Response();

class Lab_Card_List extends StatefulWidget {
  String? encounterNo;
  VisitHistory? visit;

  Lab_Card_List({
    this.encounterNo,
    this.visit,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        encounterNo: this.encounterNo,
        visit: this.visit,
      );
}

class _CardListScreenState extends State<Lab_Card_List> {
  String? encounterNo;
  VisitHistory? visit;

  _CardListScreenState({
    this.encounterNo,
    this.visit,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
   // Categroies.ctrDoctorName.text=visit.doctorName.toString();
   // LabReport.ctrEncounterNo.text=visit.encounterNo.toString();
    return FutureBuilder<Lab_Report_Response>(
      future: callApi(visit!), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Lab_Report_Response> data) {
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
                        color: Color(CompanyColors.bluegray),
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                  ),
                ));
          else
            return layout();
        }
      },
    );
  }


  PreferredSize patientDetails( VisitHistory myDoctor) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(CompanyColors.grey),
           ),
        height: 50,
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
                        /*SizedBox(
                          height: 10,
                        ),*/
                       /* Visibility(
                          visible: (myDoctor.isRadiology.toString().toLowerCase().trim() == "y")? true : false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child :Text("Radiology Reports" ,
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RadilogyReports(
                                      IPOPno:myDoctor.encounterId,
                                      Fromdate:myDoctor.encDate,
                                      Todate:myDoctor.dischargeDate,



                                    )),


                                  );

                                }, // handle your image tap here
                                child: Image.asset(
                                  'assets/icons/radiology.png',
                                  fit: BoxFit.cover, // this is the solution for border
                                  width: 35.0,
                                  height: 35.0,
                                ),
                              )

                            ],
                          ),
                        ),*/
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


  Widget layout() {
    return Scaffold(
      backgroundColor: Color(CompanyColors.grey),
      appBar: patientDetails(visit!),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,8.0),
            itemCount: res.mobLabInfoArray!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Result_List(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      labResult: res.mobLabInfoArray!.elementAt(index),
                      pos: index,
                      LabInfoArray: res.mobLabInfoArray!,
                      regId: "",
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
  Future<Lab_Report_Response> callApi(VisitHistory data) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Lab_Report_Request objddd = new Lab_Report_Request();

    objddd.encounterId = "" + visit!.encounterId.toString();
    objddd.hospitalId = "" + visit!.hospitalId!.toString();
    objddd.facilityId = "" + visit!.facilityID.toString();
    objddd.registrationId = "" + visit!.registrationId.toString();
    objddd.fromDate = "1900-01-01 00:00";
    objddd.todate = "2079-01-01 23:59";
    objddd.labType = "LIS";
    objddd.oPIP = "" + visit!.oPIP.toString();
    print("Request  \n" + objddd.toJson().toString());
    Lab_Report_Request objj = new Lab_Report_Request.fromJson(objddd.toJson());
    Response<Lab_Report_Response> responserrr =
        (await myService.PatientLabInfo(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new Lab_Report_Response.fromJson(postt!.toJson());
    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}


