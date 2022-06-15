import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Book_Appointment.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/PatientOther_Class/FavDoctorResponse.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
String? doctorId, facilityId,hospitalId,registrationId;
class Doctor_list_special_empty_card extends StatelessWidget {
  final double? width;
  final double? height;
  final GetDoctorListArrayy? doctorList;
  final int? pos;

  const Doctor_list_special_empty_card({
    Key? key,
    this.width,
    this.height,
    this.doctorList,
    this.pos,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {



     getDataSharePre();
    return new GestureDetector(
      onTap: () {
        print("Container clicked");
        CommonStrAndKey.doctorForAppointment=doctorList!.doctorId.toString();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Book_Appointment(
           doctorId: doctorList!.doctorId.toString(),
            nameDoctor:doctorList!.doctorName.toString() ,
          )),
        );
      },
      child: Container(
          width: width,
          height: height,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            /*  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,*/
            children: <Widget>[

              new Row(
                children: <Widget>[

                  Expanded(

                      flex: 100,

                      child: GestureDetector(

                       /* onTap: ()
                          {
                            print("Container clicked");


                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Categroies(

                                )));
                          },*/
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            doctorList!.doctorName.toString(),
                            style: TextStyle(
                                color:  Color(0xff5056ca),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),

                          new Text(
                            doctorList!.designation.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      )),),

                ],
              ),
            ],
          )),

    );
  }


}

void getDataSharePre() async
{
  CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
  doctorId=CommonStrAndKey.doctorForAppointment ;
  facilityId=CommonStrAndKey.galobsharedPrefs! .getString(CommonStrAndKey.facility_id) ?? '';
  hospitalId=CommonStrAndKey.galobsharedPrefs! .getString(CommonStrAndKey.hospital_id) ?? '';
  registrationId=CommonStrAndKey.galobsharedPrefs! .getString(CommonStrAndKey.registration_id) ?? '';
}