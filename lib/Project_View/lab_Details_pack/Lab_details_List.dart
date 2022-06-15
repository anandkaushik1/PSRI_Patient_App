import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/Graph/Vertical_bar_label_New.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Card__List.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Request.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

String doctorId = "", facilityId = "", hospitalId = "";
String saveRegId = "",
    saveRegNo = "",
    savePateintName = "",
    saveGender = "",
    saveAge = "",
    saveDoctor="",
    saveEncounter="",
    saveLastVisit = "";

Lab_Details_Response res = new Lab_Details_Response();
List<CommonVitalsDropDown> listFieldData= <CommonVitalsDropDown>[];
/*String encounterNo="";
 VisitHistory visit;*/
Lab_GraphView_Field_Response? resGraphResult;

class Lab_details_List extends StatefulWidget {
  MobLabInfoArray? labData;
  int? pos;
  String? regId;

  Lab_details_List({
    Key? key,
    this.labData,
    this.pos,
    this.regId,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
      labData: this.labData, pos: this.pos, regId: this.regId);
}

class _CardListScreenState extends State<Lab_details_List> {
  MobLabInfoArray? labData;
  int? pos = 0;
  String? regId;

  _CardListScreenState({
    this.labData,
    this.pos,
    this.regId,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

  }

  @override
  Widget build(BuildContext context) {
   // getDataSharePre();
    getPatientDetails();
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return FutureBuilder<Lab_Details_Response>(
        future: callApiLab_Details(""), // function where you call your api
        builder:
            (BuildContext context, AsyncSnapshot<Lab_Details_Response> data) {
          // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError)
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                  ));
            else {
              bool isGraph=false;
              for(int i=0;i<data.requireData.doctorLabDetails!.length;i++)
                {
                  if(data.requireData.doctorLabDetails!.elementAt(i).isGraph.toString().trim()=="1")
                    {
                      isGraph=true;
                    }
                }
              return layout(context, labData!,isGraph);
            }
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

  Future<Lab_Details_Response> callApiLab_Details(String data) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Lab_Details_Request objddd = new Lab_Details_Request();

    objddd.diagSampleId = "" + labData!.diagSampleId.toString();
    objddd.encodedDate = "" + labData!.encodedDate.toString();
    objddd.facilityId = "" + facilityId;
    objddd.hospitalId = "" + hospitalId;
    objddd.registrationId = "" + saveRegId;
    objddd.serviceId = "" + labData!.serviceId.toString();
    objddd.serviceName = "" + labData!.serviceName.toString();
    objddd.labNo = "" + labData!.labNo.toString();
    objddd.oPIP = "" + labData!.oPIP.toString();
    print("Request  \n" + objddd.toJson().toString());
    Lab_Details_Request objj =
        new Lab_Details_Request.fromJson(objddd.toJson());
    Response<Lab_Details_Response> responserrr =
        (await myService.PatientLabInfoDetails(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new Lab_Details_Response.fromJson(postt!.toJson());

    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

Widget layout(BuildContext context, MobLabInfoArray labData,isGraphVisiable) {
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

      bottom: patientDetails(context,labData),

    ),
    floatingActionButton:Visibility(
      visible: isGraphVisiable,
    child: new FloatingActionButton.extended(

      onPressed: () {
        print("Container clicked");
        if(isGraphVisiable) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Vertical_bar_label_New(
                      LabDetails: res.doctorLabDetails!.elementAt(0),
                      patientName: patientName.toString(),
                      forLabDataList: res.doctorLabDetails!,
                      dataForFilter: dataForFilter,
                    )),
          );
        }
      },

      label:Visibility(
        visible: isGraphVisiable,
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


      backgroundColor:(isGraphVisiable)? Color(CompanyColors.appbar_color): Colors.white,
    ),),

    body:
        SafeArea(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: res.doctorLabDetails!.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child:  ConstrainedBox(

                        constraints: BoxConstraints(

                          minWidth: MediaQuery.of(context).size.width,
                          minHeight: 30,
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Lab_Details_Card__List(

                          width: MediaQuery.of(context).size.width,
                          height: 30.0,
                          DataLabDetails: res.doctorLabDetails!.elementAt(index),
                          pos: index,
                          sizeAry: res.doctorLabDetails!.length,
                          patientName: savePateintName,
                          regID: saveRegId,
                          listData: res.doctorLabDetails,
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

Widget customBottomBar(MobLabInfoArray labData) {
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
                "" + labData.serviceName.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
            )),
            Expanded(
              child: new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text(
                  "" + labData.diagSampleId.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
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

void getDataSharePre() {
 /* doctorId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_no) ??
          '';*/
  facilityId = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.facility_id) ??
      '';
  hospitalId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
          '';
 // String ddd = doctorId;
}

void getPatientDetails() {
  // String saveRegId="",saveRegNo="",savePateintName="",saveGender="",saveAge="",saveLastVisit="";
  saveRegId = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.registration_id) ??
      '';
  saveRegNo = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.registration_no) ??
      '';
  savePateintName = CommonStrAndKey.galobsharedPrefs!
          .getString(CommonStrAndKey.patient_name) ??
      '';
 /* saveDoctor = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_name) ??
      '';
  saveEncounter = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.encounter_no) ??
      '';*/
  saveGender =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.gender) ?? '';
  saveAge =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.age) ?? '';
  saveLastVisit =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.last_visit) ??
          '';
  String ddd = savePateintName;
}

Future getVatilsDetailsFordropDown(DoctorLabDetails data) async {
  String url = BasicUrl.sendUrlGraph();
  final myService = MyServicePost.create(url);
  Lab_GraphView_Field setObj = new Lab_GraphView_Field();
  setObj.facilityId = "2" /*+facilityId*/;
  setObj.hospitalLocationId = "1" /*+hospitalId*/;
  setObj.fieldId = "0" /*+data.fieldId.toString()*/;
  setObj.serviceId = "2315" /*+data.serviceId.toString()*/;
  // {"FacilityId":"2","FieldId":"0","HospitalLocationId":"1","ServiceId":"778"}
  print("Request  \n" + setObj.toJson().toString());
  Lab_GraphView_Field obj = new Lab_GraphView_Field.fromJson(setObj.toJson());
  Response<Lab_GraphView_Field_Response> response =
      (await myService.LabResultGraphField(obj));
  print(response.body);
  var post = response.body;
  resGraphResult = new Lab_GraphView_Field_Response.fromJson(post!.toJson());
  if (resGraphResult != null) {
    listFieldData.clear();
    if (resGraphResult!.resultGraphFieldList!.length != 0) {
      for (int i = 0; i < resGraphResult!.resultGraphFieldList!.length; i++) {
        ResultGraphFieldList obj =
            resGraphResult!.resultGraphFieldList!.elementAt(i);

        CommonVitalsDropDown dataField =
            new CommonVitalsDropDown(obj.fieldName.toString(), obj.fieldId.toString());
        listFieldData.add(dataField);
      }
    }
  }
}
PreferredSize patientDetails(BuildContext context,MobLabInfoArray data) {
  return PreferredSize(
    preferredSize: Size.fromHeight(120.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(CompanyColors.appbar_color),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      height: 120,
      child: Column(
        children: [
          new Row(
            children: [
              /* new Container(
                   margin:EdgeInsets.fromLTRB(30, 40, 5, 10) ,
                   width: 30,
                   height: 20,
                   child: IconButton(
                    // icon: new Icon(Icons.arrow_back),

                     onPressed: () {},
                   ),
                 ),*/

//              new Container(
//                margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
//                child: InkWell(
//                  onTap: () {
//                    Navigator.of(context).pop();
//                  },
//                  child: new SvgPicture.asset(
//                    'assets/icons/leftarrow.svg',
//                    height: 15,
//                    width: 20,
//                    alignment: Alignment.centerLeft,
//                    fit: BoxFit.fill,
//                    color: Colors.white,
//                  ),
//                ),
//              ),
            ],
          ),
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
                          Text("" + savePateintName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text("" + data.encodedDate.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))
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
                            child :Text("",
                              style: TextStyle(
                                  color: Colors.white,fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                            ),),
                          Text("" ,
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
                          child: Text(""+data.serviceName.toString(),style: TextStyle(fontSize: 12,color: Colors.white),),
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
                    flex: 40,
                    child: Text(
                      "  Test Name",
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
                    flex: 60,
                    child: Text(
                      "  Result|Unit|Range",
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

