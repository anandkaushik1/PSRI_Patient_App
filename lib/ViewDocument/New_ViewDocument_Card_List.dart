

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabVisitResponse.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Request.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Result_List.dart';
import 'package:flutter_patient_app/ViewDocument/DocumnetList_Request.dart';
import 'package:flutter_patient_app/ViewDocument/DocumnetList_Response.dart';
import 'package:flutter_patient_app/ViewDocument/New_Result_List.dart';
import 'package:flutter_patient_app/ViewDocument/viewDocument_Response.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

DocumnetList_Response res = new DocumnetList_Response();

class ViewDocument_Card_List extends StatefulWidget {
  String? encounterNo;
  UploadedDocVisit? visit;

  ViewDocument_Card_List({
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

class _CardListScreenState extends State<ViewDocument_Card_List> {
  String? encounterNo;
  UploadedDocVisit? visit;

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
    return FutureBuilder<DocumnetList_Response>(
      future: callApi(visit!), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<DocumnetList_Response> data) {
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


  PreferredSize patientDetails( UploadedDocVisit myDoctor) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(CompanyColors.white),
           ),
        height: 40,
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
                              child :Text("" + myDoctor.doctorName!.toString(),
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                 overflow: TextOverflow.ellipsis,
                              ),

                            ),
                            Text("Encounter No : " + myDoctor.encounterNo!.toString(),
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),

                          ],
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


  Widget layout() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: patientDetails(visit!),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(8.0,2.0,8.0,8.0),
            itemCount: res.patientDocList!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: New_Result_List(
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      labResult: res.patientDocList!.elementAt(index),
                      pos: index,
                      LabInfoArray: res.patientDocList,
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
  Future<DocumnetList_Response> callApi(UploadedDocVisit data) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    DocumnetList_Request objddd = new DocumnetList_Request();

    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String registrationIdData = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';

    print('sarav docdata ${data.registrationId}');

    objddd.doctorId = data.doctorId;
    objddd.encounterId = data.encounterId;
    objddd.facilityId = data.facilityID;
    objddd.hospitalLocationId = data.hospitalId;
    //objddd.registrationId = registrationIdData;
    objddd.registrationId = data.registrationId;

    print("Request  \n" + objddd.toJson().toString());
    DocumnetList_Request objj = new DocumnetList_Request.fromJson(objddd.toJson());
    Response<DocumnetList_Response> responserrr =
        (await myService.DcoumentListData(objj));
    var postt = responserrr.body;
    print(responserrr.body!.patientDocList);
     res = new DocumnetList_Response.fromJson(postt!.toJson());
    print("Response  \n" + res.toJson().toString());

    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}


