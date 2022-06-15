import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/CommonClass/MyDateUtil.dart';

import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Teleempty_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'date_picker_timeline.dart';

String? doctorId, facilityId, hospitalId, registrationId,registrationNo;
TeleAppmt_Slot_Response res = new TeleAppmt_Slot_Response();
DeleteAppointmentResponse resDelete = new DeleteAppointmentResponse();


class Tele_Appointment_Slot extends StatefulWidget {
  String? doctorId;
  String? nameDoctor;
  String? strFacitily;
  String? strHospital;
  String? strEducation;
  String? strSpecialiSation;
  DateTime? globelDate;

  Tele_Appointment_Slot({
    this.doctorId,
    this.nameDoctor,
    this.strFacitily,
    this.strHospital,
    this.globelDate,
    Key? key,
  }) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState(
      doctorId: this.doctorId,
      nameDoctor: this.nameDoctor,
      strFacitily: strFacitily,
      strHospital: strHospital,
      globelDate:globelDate

  );
}

class _NestedTabBarState extends State<Tele_Appointment_Slot>
    with TickerProviderStateMixin {
  String? doctorId;
  String? nameDoctor;
  var dateFormate;
  DateTime? globelDate;
  String? strFacitily;
  String? strHospital;
  TeleAppmt_Slot_Response? objectSlot ;

  _NestedTabBarState(
      {this.doctorId, this.nameDoctor, this.strFacitily, this.strHospital,this.globelDate,
      //dateFormate = DateFormat("yyyy-MM-dd").format(DateTime.parse("2019-09-30"));
      });

  @override
  void initState() {
    super.initState();
    // _selectedValue = DateTime.tryParse("20200213");
    facilityId = strFacitily;
    hospitalId = strHospital;
    getDataSharePre();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return new Scaffold(
      backgroundColor: Colors.white,

      body: ApiHitWithView(),
    );
  }

  Widget NoRecordFound() {
    return new Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Not Record Found',
          style: TextStyle(color: Colors.black, fontSize: 13),
        ),
      ),
    );
  }

  Widget layout(TeleAppmt_Slot_Response objectSlot, String doctorIDStr) {
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 100,
          child: SafeArea(
            child: new Container(
              color: Color(CompanyColors.grey),
              child: AnimationLimiter(
                child: GridView.count(
                  childAspectRatio: 2.0,
                  padding: const EdgeInsets.all(8.0),
                  crossAxisCount: 3,
                  children: List.generate(
                    objectSlot.getDoctorAppointmentSlotJsonListArray!.length,
                    (int index) {
                      return AnimationConfiguration.staggeredGrid(
                        columnCount: 3,
                        position: index,
                        duration: Duration(milliseconds: 375),
                        child: ScaleAnimation(
                          scale: 0.5,
                          child: FadeInAnimation(
                            child: Teleempty_card(
                              width: 64.0,
                              height: 25.0,
                              position: index,
                              objSlot: objectSlot
                                  .getDoctorAppointmentSlotJsonListArray!.elementAt(index),
                              RegId: registrationId.toString(),
                              RegNo: registrationNo.toString(),
                              doctorId: doctorIDStr,
                              DateForAppt: CommonStrAndKey.globelDate,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }


  String convertDateFromat(var date) {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(now);
    print(formatted); // something like 2013-04-20
    return formatted;
  }

  DateTime convertStringToDateFromat(var date) {
    var now = new DateTime.now();
    DateTime DATE = new DateFormat('yyyy-MM-dd') as DateTime;
    return DATE;
  }

  Future<TeleAppmt_Slot_Response> callApiAppointment(String StrDectorId,DateTime date) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    TeleAppmt_Slot_Request objddd = new TeleAppmt_Slot_Request();
    objddd.appointmentDate = "" + CommonStrAndKey.globelDate.toString();
    objddd.doctorId = "" + StrDectorId;
    objddd.facilityID =  int.parse(facilityId!.toString());
    objddd.isTeleConsultation=CommonStrAndKey.isTeleConsultFlg;
    print('objddd.toJson() : ${objddd.toJson()}');
    TeleAppmt_Slot_Request objj = new TeleAppmt_Slot_Request.fromJson(objddd.toJson());
    Response<TeleAppmt_Slot_Response> responserrr =
        (await myService.TeleMobGetDoctorWiseSlot(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new TeleAppmt_Slot_Response.fromJson(postt!.toJson());
    return Future.value(res);
  }

  getDataFor() async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    TeleAppmt_Slot_Request objddd = new TeleAppmt_Slot_Request();

    objddd.appointmentDate = "" + CommonStrAndKey.globelDate.toString();
    objddd.doctorId = "" + doctorId!.toString();
    objddd.facilityID = int.parse(facilityId.toString());
    print('objddd.toJson() : ${objddd.toJson()}');
    TeleAppmt_Slot_Request objj = new TeleAppmt_Slot_Request.fromJson(objddd.toJson());
    var response = await myService.TeleMobGetDoctorWiseSlot(objj);
    setState(() {
      objectSlot = response.body;
      print(
          'response : ${objectSlot!.getDoctorAppointmentSlotJsonListArray!.length}');
      layout(objectSlot!, doctorId!.toString());
    });
  }

  void getDataSharePre() async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    doctorId = CommonStrAndKey.doctorForAppointment;
    facilityId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ??
        '';
    hospitalId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
        '';
    registrationId = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_id) ??
        '';
    registrationNo= CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ??
        '';
    getDataFor();
  }

  Widget ApiHitWithView() {
    print("doctor id  " + doctorId!.toString());
    return new Center(
      child: FutureBuilder<TeleAppmt_Slot_Response>(
        future: callApiAppointment( doctorId.toString(),CommonStrAndKey.globelDate),
        // function where you call your api
        builder:
            (BuildContext context, AsyncSnapshot<TeleAppmt_Slot_Response> data) {
          // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError) {
              print('Data has error ');
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'No Record Found',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ));
            } else {
              if (data.requireData != null) {
                 if (data.requireData.status.toString().toLowerCase().trim() == "success") {
                   if (data.requireData.getDoctorAppointmentSlotJsonListArray !=
                       null) {
                     if (data.requireData.getDoctorAppointmentSlotJsonListArray!
                         .length !=
                         0) {
                       TeleAppmt_Slot_Response myObj = new TeleAppmt_Slot_Response();
                       List<GetDoctorAppointmentSlotJsonListArray> myApmtTime =
                      <GetDoctorAppointmentSlotJsonListArray>[];

                       bool dateFlg = MyDateMethod.isBeforeDatewithCurrentDate(
                           DateTime.now().toString(), CommonStrAndKey.globelDate.toString());

                       if (!dateFlg) {
                         for (int i = 0;
                         i <
                             data.requireData
                                 .getDoctorAppointmentSlotJsonListArray!.length;
                         i++) {
                           DateTime tempDate = MyDateMethod.convertStringToDateYMD(
                               "" + DateTime.now().toString());
                           bool timeFlg = MyDateMethod.compareTimewithCurrentTime(
                               "" +
                                   tempDate.year.toString() +
                                   "-" +
                                   tempDate.month.toString() +
                                   "-" +
                                   tempDate.day.toString(),
                               data.requireData
                                   .getDoctorAppointmentSlotJsonListArray!
                                   .elementAt(i)
                                   .appointmentTime
                                   .toString());
                           if (timeFlg) {
                             myApmtTime.add(data
                                 .requireData.getDoctorAppointmentSlotJsonListArray!
                                 .elementAt(i));
                           }
                         }
                         myObj.getDoctorAppointmentSlotJsonListArray = myApmtTime;
                         return layout(myObj,doctorId!.toString());
                       } else {
                         return layout(data.requireData,doctorId!.toString());
                       }
                     } else {
                       return NoRecordFound();
                     }
                   } else {
                     return NoRecordFound();
                   }
                 }else{
                   return NoRecordFound();
                 }
              } else {
                return NoRecordFound();
              }
            }
          }
        },
      ),
    );
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
  }
}
