import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Appmt_Slot_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Appmt_Slot_Response.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/empty_card.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/CommonClass/MyDateUtil.dart';

import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentResponse.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Model/Appmt_Slot_Response.dart';
import 'date_picker_timeline.dart';

String? doctorId, facilityId, hospitalId, registrationId,registration_no;
Appmt_Slot_Response res = new Appmt_Slot_Response();
DeleteAppointmentResponse resDelete = new DeleteAppointmentResponse();
DateTime globelDate = DateTime.now();

class Book_Appointment extends StatefulWidget {
  String? doctorId;
  String? nameDoctor;
  String? strFacitily;
  String? strHospital;
  String? strEducation;
  String? strSpecialiSation;


  Book_Appointment({
    this.doctorId,
    this.nameDoctor,
    this.strFacitily,
    this.strHospital,
    Key? key,
  }) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState(
      doctorId: this.doctorId,
      nameDoctor: this.nameDoctor,
      strFacitily: strFacitily,
      strHospital: strHospital);
}

class _NestedTabBarState extends State<Book_Appointment>
    with TickerProviderStateMixin {
  String? doctorId;
  String? nameDoctor;
  var dateFormate;
  String? strFacitily;
  String? strHospital;
  Appmt_Slot_Response? objectSlot ;

  _NestedTabBarState(
      {this.doctorId, this.nameDoctor, this.strFacitily, this.strHospital
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Appointment\n' + nameDoctor.toString(),
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
      ),
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

  Widget layout(Appmt_Slot_Response objectSlot, String doctorIDStr) {
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 15,
          child: buttonVisiableOrNot(),
        ),
        Expanded(
          flex: 85,
          child: SafeArea(
            child: new Container(
              color: Colors.white,
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
                            child: EmptyCard(
                              width: 64.0,
                              height: 25.0,
                              position: index,
                              objSlot: objectSlot
                                  .getDoctorAppointmentSlotJsonListArray!.elementAt(index),
                              RegId: registrationId!.toString(),
                              RegNO: registration_no!.toString(),
                              doctorId: doctorIDStr,
                              DateForAppt: globelDate,
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

  Widget buttonVisiableOrNot() {
    return new Container(
      height: 80,

      child: DatePickerTimeline(
        globelDate,
        selectionColor: Color(CompanyColors.appbar_color60),
        onDateChange: (date) {
          // New date selected
          setState(() {
            globelDate = date;
          });
        },
      ),
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

  Future<Appmt_Slot_Response> callApiAppointment(String StrDectorId) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Appmt_slot_Request objddd = new Appmt_slot_Request();

    objddd.appointmentDate = "" + globelDate.toString();
    objddd.doctorId = "" + StrDectorId;
    objddd.facilityID = "" + facilityId!.toString();
    print('objddd.toJson() : ${objddd.toJson()}');
    Appmt_slot_Request objj = new Appmt_slot_Request.fromJson(objddd.toJson());

    Response<Appmt_Slot_Response> responserrr =
        (await myService.MobGetDoctorWiseSlot(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new Appmt_Slot_Response.fromJson(postt!.toJson());
    return Future.value(res);
  }

  getDataFor() async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Appmt_slot_Request objddd = new Appmt_slot_Request();

    objddd.appointmentDate = "" + globelDate.toString();
    objddd.doctorId = "" + doctorId!.toString();
    objddd.facilityID = "" + facilityId!.toString();
    print('objddd.toJson() : ${objddd.toJson()}');
    Appmt_slot_Request objj = new Appmt_slot_Request.fromJson(objddd.toJson());
    var response = await myService.MobGetDoctorWiseSlot(objj);
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
    registration_no = CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ??
        '';
    getDataFor();
  }

  Widget ApiHitWithView() {
    print("doctor id  " + doctorId!.toString());
    return new Center(
      child: FutureBuilder<Appmt_Slot_Response>(
        future: callApiAppointment("" + doctorId!.toString()),
        // function where you call your api
        builder:
            (BuildContext context, AsyncSnapshot<Appmt_Slot_Response> data) {
          // AsyncSnapshot<Your object type>
          if (data.connectionState == ConnectionState.waiting) {
            return Loading(context);
          } else {
            if (data.hasError) {
              print('Data has error ');
              return new Container(
                  color: Colors.white,
                  child: Center(
                    child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                  ));
            } else {
              if (data.requireData != null) {


               if (data.requireData.status.toString().toLowerCase().trim() == "success") {

                 if (data.requireData.getDoctorAppointmentSlotJsonListArray !=
                     null) {
                   if (data.requireData.getDoctorAppointmentSlotJsonListArray
                       !.length !=
                       0) {
                     Appmt_Slot_Response myObj = new Appmt_Slot_Response();
                     List<GetDoctorAppointmentSlotJsonListArray> myApmtTime =
                    <GetDoctorAppointmentSlotJsonListArray>[];

                     bool dateFlg = MyDateMethod.isBeforeDatewithCurrentDate(
                         DateTime.now().toString(), globelDate.toString());

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

  Widget Loading(BuildContext forThis){

    return new Container(
        color: Colors.white,
        child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
        ));
  }
}
