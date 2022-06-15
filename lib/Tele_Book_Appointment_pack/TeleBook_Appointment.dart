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
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Tele_Appointment_Slot.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Teleempty_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'date_picker_timeline.dart';

String? doctorId, facilityId, hospitalId, registrationId,registrationNo;
TeleAppmt_Slot_Response res = new TeleAppmt_Slot_Response();
DeleteAppointmentResponse resDelete = new DeleteAppointmentResponse();


class TeleBook_Appointment extends StatefulWidget {
  String? doctorId;
  String? nameDoctor;
  String? strFacitily;
  String? strHospital;
  String? strEducation;
  String? strSpecialiSation;

  TeleBook_Appointment({
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

class _NestedTabBarState extends State<TeleBook_Appointment>
    with TickerProviderStateMixin {
  String? doctorId;
  String? nameDoctor;
  var dateFormate;
  String? strFacitily;
  String? strHospital;
  TeleAppmt_Slot_Response? objectSlot ;

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
      backgroundColor: Color(CompanyColors.grey),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(CompanyColors.appbar_color),
        title: Text(
          'Choose Appointment\n' + nameDoctor.toString(),
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
      ),
      body:layout(),
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

    Widget layout() {
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 15,
          child: buttonVisiableOrNot(),
        ),
        Expanded(
          flex: 85,
          child: Tele_Appointment_Slot(
            doctorId: doctorId,
            globelDate: CommonStrAndKey.globelDate,
            nameDoctor: nameDoctor,
            strFacitily: strFacitily,
            strHospital: strHospital,
          ),
        )
      ],
    );
  }

  Widget buttonVisiableOrNot() {
    return new Container(
      height: 80,
      child: DatePickerTimeline(
        CommonStrAndKey.globelDate,
        selectionColor: Color(CompanyColors.appbar_color60),
        onDateChange: (date) {
          // New date selected
          setState(() {
            CommonStrAndKey.globelDate = date;
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

  }



  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
  }
}
