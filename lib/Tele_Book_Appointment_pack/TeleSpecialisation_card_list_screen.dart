import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationRequest.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Specialisation_list_empty_card.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/specialisation_card.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleListofSpecialisationRequest.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleSpecialisation_card.dart';

import 'package:intl/intl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatient.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

TeleListofSpecialisationResponse res = new TeleListofSpecialisationResponse();

String tempTypeOfSearch = "";
String doctorId="", facilityId="", hospitalId="";

class TeleSpecialisation_card_list_screen extends StatefulWidget {
  TeleSpecialisation_card_list_screen({
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState();
}

class _CardListScreenState extends State<TeleSpecialisation_card_list_screen> {
  /* _CardListScreenState({

  });*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonStrAndKey.globelDate= DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return callBackApiResponse();
  }

  Widget callBackApiResponse() {
    return FutureBuilder<TeleListofSpecialisationResponse>(
      future: callApi(), // function where you call your api
      builder: (BuildContext context,
          AsyncSnapshot<TeleListofSpecialisationResponse> data) {
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
          else if (data.requireData.status!.toString().toLowerCase() == "success") {
            if (data.requireData.specialisationDoctorListArray != null) {
              if (data.requireData.specialisationDoctorListArray!.length > 0) {
                return layout(true);
              } else {
                return layout(false);
              }
            } else {
              return layout(false);
            }
          } else {
            return layout(false);
          }
        }
      },
    );
  }

  Widget layout(bool isVisible) {
    return Scaffold(
      backgroundColor: Color(CompanyColors.grey),
      body: ListLayout(isVisible),
    );
  }

  Widget ListLayout(bool isVisiable) {
    if (isVisiable) {
      return SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: res.specialisationDoctorListArray!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: TeleSpecialisation_card(
                      MediaQuery.of(context).size.width,
                      40.0,
                      res.specialisationDoctorListArray!.elementAt(index),
                      index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    } else {
      return  Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),);
    }
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

Future<TeleListofSpecialisationResponse> callApi() async {
  String url = BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  TeleListofSpecialisationRequest objddd = new TeleListofSpecialisationRequest();

  objddd.tCDoctor = CommonStrAndKey.isTeleConsultFlg.toString();
  TeleListofSpecialisationRequest objj =
      new TeleListofSpecialisationRequest.fromJson(objddd.toJson());
  Response<TeleListofSpecialisationResponse> responserrr =
      (await myService.TeleMobSpecialisationList(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new TeleListofSpecialisationResponse.fromJson(postt!.toJson());
  return Future.value(res);
}

String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}

void getDataSharePre() async {
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  doctorId = CommonStrAndKey.doctorForAppointment;
  facilityId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id) ??
          '';
  hospitalId =
      CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ??
          '';
}
