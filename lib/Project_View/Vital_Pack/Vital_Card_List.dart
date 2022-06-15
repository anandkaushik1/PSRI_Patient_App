import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Graph_Vital/Vital_Vertical_bar_label_New.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_List.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Request.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Response.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Visit_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Vital_Response res = new Vital_Response();
String patientName = "", registration = "", encounter_id = "", hospital_id = "";
List<String> shortItems = ['DD 0', 'WW 1', 'MM 1', 'MM 3', 'MM 6', 'YY 1'];
List<String> timesItems = [
  'Day',
  'Week',
  'Month',
  '3 Month',
  '6 month',
  'Year'
];
List<CommonVitalsDropDown> dataForFilter= <CommonVitalsDropDown>[];

class Vital_Card_List extends StatefulWidget {
  String? encounterNo = "";
  VitalVisit? visit;

  Vital_Card_List({
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

class _CardListScreenState extends State<Vital_Card_List> {
  String? encounterNo = "";
  VitalVisit? visit;

  _CardListScreenState({
    this.encounterNo,
    this.visit,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSharePre();
    forFilterDropDown();
  }

  void forFilterDropDown() {
    dataForFilter.clear();
    for (int i = 0; i < shortItems.length; i++) {
      CommonVitalsDropDown timep = new CommonVitalsDropDown(
          timesItems.elementAt(i), shortItems.elementAt(i));
      dataForFilter.add(timep);
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Vital_Response>(
      future: callApi(visit!), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Vital_Response> data) {
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
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ));
          else
            return layout();
        }
      },
    );
  }
  Widget layout() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: patientDetails(visit!),
      floatingActionButton:Visibility(
        visible: true,
        child: new FloatingActionButton.extended(

          onPressed: () {
            print("Container clicked");
            if(true) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Vital_Vertical_bar_label_New(
                          patientName: patientName.toString(),
                           dataForFilter: dataForFilter,
                          regId: "",
                        )),
              );
            }
          },

          label:Visibility(
            visible: true,
            child: new Container(
              child: Row(
                children: [
                  new Container(

                    child: Icon(
                      Icons.bar_chart,
                      color: Color(CompanyColors.white),
                      size: 15,
                    ),
                    margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                  ),
                  new Text(
                    "Graph",
                    style: TextStyle(
                        color: Color(
                          CompanyColors.button_txt_color,
                        ),
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),


          backgroundColor:(true)? Color(CompanyColors.appbar_color): Colors.white,
        ),),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: res.patietnListArray!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Vital_List(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      VitalResult: res.patietnListArray!.elementAt(index),
                      pos: index,
                      ListArray: res.patietnListArray!,
                      hospitalId: hospital_id,
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



PreferredSize patientDetails( VitalVisit myDoctor) {
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
            margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
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
Future<Vital_Response> callApi(VitalVisit data) async {
  String url = BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  Vital_Request objddd = new Vital_Request();

  //{"intEncounterId":"1480974","intFacilityId":"2","intHospitalId":"1","intRegId":"675347"}
  objddd.intEncounterId = "" + data.encounterId.toString();
  objddd.intHospitalId = "" + data.hospitalId.toString();
  objddd.intFacilityId = "" + data.facilityID.toString();
  objddd.intRegId = "" + data.registrationId.toString();

  Vital_Request objj = new Vital_Request.fromJson(objddd.toJson());
  Response<Vital_Response> responserrr =
      (await myService.PatientvitalDetail(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new Vital_Response.fromJson(postt!.toJson());
  return Future.value(res);
}

void getDataSharePre() async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  patientName = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.patient_name) ??
      '';
  registration = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.registration_id) ??
      '';
  encounter_id = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.encounter_id) ??
      '';
  hospital_id =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
          '';
}
