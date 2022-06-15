import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/CommonClass/MyDateUtil.dart';
import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentResponse.dart';
import 'package:flutter_patient_app/RescheduleAppointment/RescheduleAppointment_Slot.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Tele_Appointment_Slot.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Teleempty_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'date_picker_timeline.dart';

String? mydoctorId, facilityId, hospitalId, registrationId,registrationNo;
TeleAppmt_Slot_Response res = new TeleAppmt_Slot_Response();
DeleteAppointmentResponse resDelete = new DeleteAppointmentResponse();


class Reschedule_Appointment extends StatefulWidget {
  final String? doctorId;
  final String? nameDoctor;
  final String? strFacitily;
  final String? strHospital;
  //final String strEducation;
  //final String strSpecialiSation;
  final AppointmentListJSon? myAppointData;

  Reschedule_Appointment({
    this.doctorId,
    this.nameDoctor,
    this.strFacitily,
    this.strHospital,
    this.myAppointData,
    Key? key,
  }) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState(
      doctorId: this.doctorId,
      nameDoctor: this.nameDoctor,
      strFacitily: strFacitily,
      strHospital: strHospital,
      myAppointData:myAppointData,

  );
}

class _NestedTabBarState extends State<Reschedule_Appointment>
    with TickerProviderStateMixin {
  String? doctorId;
  String? nameDoctor;
  var dateFormate;
  String? strFacitily;
  String? strHospital;
  AppointmentListJSon? myAppointData;
  TeleAppmt_Slot_Response? objectSlot ;

  _NestedTabBarState(
      {this.doctorId, this.nameDoctor, this.strFacitily,
        this.strHospital,this.myAppointData,
      //dateFormate = DateFormat("yyyy-MM-dd").format(DateTime.parse("2019-09-30"));
      });

  @override
  void initState() {
    super.initState();
    // _selectedValue = DateTime.tryParse("20200213");
    facilityId = strFacitily;
    hospitalId = strHospital;
    mydoctorId=doctorId;
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
          'Reschedule Appointment'/* + nameDoctor*/,
          style: TextStyle(fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: Color(CompanyColors.appbar_color),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(CompanyColors.appbar_color).withOpacity(.1),
                    offset: Offset(0.0, 1.0),
                    blurRadius: 1.0)
              ]),
        ),
        bottom: DoctorDetails(context, myAppointData!),
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
          child: RescheduleAppointment_Slot(
            doctorId: doctorId!,
            globelDate: CommonStrAndKey.globelDate,
            nameDoctor: nameDoctor!,
            strFacitily: strFacitily!,
            strHospital: strHospital!,
            myAppointData: myAppointData!,

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
    mydoctorId = doctorId;
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
        child: SpinKitThreeBounce(size: 71.0, color: Color(0xFF76c8f0)));
  }
 PreferredSize DoctorDetails(BuildContext context, AppointmentListJSon myPatient) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: Container(
        width: double.infinity,
     /*   decoration: BoxDecoration(
            color: Color(CompanyColors.appbar_color),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            )),*/
        height: 60,
        child:  new Container(
              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                            Text("" + myPatient.doctorName!.toString(),
                                maxLines: 1,

                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text("" + myPatient.paymentStatus!.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                          SizedBox(
                        height: 5,
                      ),
                    Flexible(
                      child :Text("" + myPatient.appointmentDate!.toString()+" "+myPatient.fromTime!.toString(),
                        style: TextStyle(
                            color: Colors.white,fontSize: 10,
                            fontWeight: FontWeight.bold),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text("Hospital name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                    ],
                    ),
                  ),
                ],
              ),
            ),

        ),

    );
  }

}
