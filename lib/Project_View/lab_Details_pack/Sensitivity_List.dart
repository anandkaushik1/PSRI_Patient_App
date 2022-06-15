import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Sensitivity_Card__List.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/SensitivityRequest.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/SensitivityResponse.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

String? registration_id,
    registration_no,
    encounter_id,
    patient_name,
    encounter_no,
    doctor_name;

SensitivityResponse res = new SensitivityResponse();

/*String encounterNo="";
 VisitHistory visit;*/
class Sensitivity_List extends StatefulWidget {
  DoctorLabDetails? labData;
  int? pos;

  Sensitivity_List({
    Key? key,
    this.labData,
    this.pos,
  }) : super(key: key);

  @override
  _CardListScreenState createState() =>
      _CardListScreenState(labData: this.labData, pos: this.pos);
}

class _CardListScreenState extends State<Sensitivity_List> {
  DoctorLabDetails? labData;
  int? pos = 0;

  _CardListScreenState({
    this.labData,
    this.pos,
  });

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    registration_id = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    registration_no = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ??
        '';

    encounter_id = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_id) ??
        '';
    patient_name = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.patient_name) ??
        '';
    encounter_no = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_no) ??
        '';
    doctor_name = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_name) ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return FutureBuilder<SensitivityResponse>(
        future: callApiLab_Details(labData!), // function where you call your api
        builder:
            (BuildContext context, AsyncSnapshot<SensitivityResponse> data) {
          // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError) {
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ));
            } else
              return layout(context, labData!);
          }
        },
      );
    } else {
      return new Container(
          color: Colors.white,
          child: Center(
            child: Text(
              'No Record Found',
              style: TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ));
    }
  }

  Future<SensitivityResponse> callApiLab_Details(DoctorLabDetails data) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    SensitivityRequest objddd = new SensitivityRequest();

    objddd.diagSampleId = "" + data.diagSampleId.toString();
    objddd.source = "" + data.source.toString();
    objddd.resultId = "" + data.resultId.toString();
    print("Request  \n" + objddd.toJson().toString());
    SensitivityRequest objj = new SensitivityRequest.fromJson(objddd.toJson());
    Response<SensitivityResponse> responserrr =
        (await myService.SensitivityDetails(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new SensitivityResponse.fromJson(postt!.toJson());
    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

Widget layout(BuildContext context, DoctorLabDetails labData) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Color(CompanyColors.appbar_color),
      title: Text(
        'Lab Detail',
        style: TextStyle(fontSize: 16.0),
      ),
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop()),
      bottom: patientDetails(context, labData),
    ),
    body: SafeArea(
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: res.sensitivityDetailsarray!.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                  child: Lab_Sensitivity_Card__List(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    DataLabDetails:
                        res.sensitivityDetailsarray!.elementAt(index),
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

Widget customBottomBar(DoctorLabDetails labData) {
  return PreferredSize(
    preferredSize: Size.fromHeight(30.0),
    child: Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
                child: new Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Text(
                "" + labData.serviceName!.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
              child: new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  "" + labData.diagSampleId.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        /*  new Row(
          children: <Widget>[
            Expanded(
              child: new Container( margin : EdgeInsets.fromLTRB(10, 10, 0, 0),child:
              Text(""+IpPatient.doctorName,style:TextStyle(color: Colors.white,fontSize: 12,
                  fontWeight: FontWeight.bold),),
              ),
            ),
            Expanded(
              child: new Container( margin : EdgeInsets.only(left: 10),child:
              Text(""+IpPatient.encounterNo,style:TextStyle(color: Colors.white,fontSize: 12,
                  fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),*/
      ],
    ),
  );
}



PreferredSize patientDetails(BuildContext context, DoctorLabDetails data) {
  return PreferredSize(
    preferredSize: Size.fromHeight(130.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(CompanyColors.appbar_color),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      height: 130,
      child: Column(
        children: [
          new Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 7),

                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 2),
                      child: new SvgPicture.asset(
                        'assets/New_Icons/male_icon_white.svg',
                        height: 40,
                        width: 23,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //child: Icon(Icons.person_pin, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("" + patient_name.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight
                                      .bold)), /*
                          Text("" + data.organismName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))*/
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              "" + doctor_name.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text("" + encounter_no.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: new Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 20, 0),
                          child: Text(
                            "" + data.serviceName.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          new Container(
            child:
                new Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Row(
                    children: [
                      new Expanded(
                        child: Text(
                          "AntibioticName",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                        ),
                        flex: 40,
                      ),
                      Expanded(
                        flex: 30,
                        child: Text(
                          "Interpretation",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Text(
                          "MIC",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),


          ),
        ],
      ),
    ),
  );
}
