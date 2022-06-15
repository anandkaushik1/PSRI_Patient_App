import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/PatientViewCategories/MasterCategoriesPatient.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MultiPatientCard extends StatelessWidget {
  final double? width;
  final double? height;
  final VerifyPatinetList? PatientDetails;
  final int? pos;

  const MultiPatientCard({
    Key? key,
    this.width,
    this.height,
    this.PatientDetails,
    this.pos,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print("Container clicked");
        saveData(PatientDetails!);
        /*   Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MasterCategoriesPatient(
              PatientDetails: PatientDetails,
              pos: pos,
            )));*/

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                settings:
                RouteSettings(name: "/CategoriesPatient"),
                builder: (context) => CategoriesPatient(
                  PatientDetails: PatientDetails!,
                  pos: pos!,
                )),
                (Route<dynamic> route) => true);
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
                    flex: 15, // color: Colors.green,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      child:new Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 2),
                        child :  new SvgPicture.asset(
                          'assets/icons/male_icon.svg',
                          height: 40,
                          width: 20,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(

                    flex: 70,

                    child: GestureDetector(

                      /* onTap: ()
                          {
                            print("Container clicked");


                           *//* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Categroies(

                                  IpPatient: IpPatient,
                                  pos: pos,
                                )));*//*
                          },*/
                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Name : "+PatientDetails!.patientName.toString(),
                              style: TextStyle(
                                  color:  Color(CompanyColors.appbar_color),
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            new Text(
                              "Age : "+PatientDetails!.age.toString(),
                              style: TextStyle(color: Colors.grey, fontSize: 14),
                              maxLines: 1,
                            ),



                            new Text(
                              (PatientDetails!.isUnRegPat!?"Guest ID : " : "UHID : " )+
                                  PatientDetails!.registrationNo.toString() +
                                  " | " +
                                  PatientDetails!.mobileNo.toString(),
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              maxLines: 1,
                            ),

                          ],
                        )),),
                  /*  Expanded(
                      flex: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                             new Container(
                              child: new Image.asset(
                                'assets/icons/ipd-patient.svg',
                                height: 17,
                                width: 17,
                                fit: BoxFit.fill,
                              ),
                              margin: const EdgeInsets.only(bottom: 20.0),
                            ),

                        ],
                      )),*/
                ],
              ),
            ],
          )),

    );
  }

  _launchCaller(String mobileNo) async {
    var mob = "tel:" + mobileNo;
    //url = mob;
    if (await canLaunch(mob)) {
      await launch(mob);
    } else {
      throw 'Could not launch $mob';
    }
  }

  void saveData(VerifyPatinetList IpPatientobject) async
  {
    final SharedPreferences setPatientInfo = await SharedPreferences.getInstance();
    // setPatientInfo.setString(CommonStrAndKey.loginId, "");
    // setPatientInfo.setString(CommonStrAndKey.password, "");
    setPatientInfo.setString(CommonStrAndKey.registration_id, ""+IpPatientobject.registrationId.toString());
    setPatientInfo.setString(CommonStrAndKey.registration_no, ""+IpPatientobject.registrationNo.toString());
    setPatientInfo.setString(CommonStrAndKey.patient_name, ""+IpPatientobject.patientName.toString().trim());
    setPatientInfo.setString(CommonStrAndKey.hospital_id, IpPatientobject.hospitalLocationId.toString());
    setPatientInfo.setString(CommonStrAndKey.hospital_name, "PSRI Hospital");
    setPatientInfo.setString(CommonStrAndKey.facility_id, IpPatientobject.facilityID.toString());
    setPatientInfo.setString(CommonStrAndKey.gender, IpPatientobject.gender.toString());
    setPatientInfo.setString(CommonStrAndKey.age, IpPatientobject.age.toString());
    setPatientInfo.setString(CommonStrAndKey.email, IpPatientobject.emailId.toString());
    setPatientInfo.setString(CommonStrAndKey.encounter_id, IpPatientobject.encounterId.toString());
    setPatientInfo.setString(CommonStrAndKey.encounter_no, IpPatientobject.encounterId.toString());
    setPatientInfo.setString(CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
    setPatientInfo.setString(CommonStrAndKey.patient_type, IpPatientobject.patientType.toString());
    setPatientInfo.setString(CommonStrAndKey.IsUnRegPat, IpPatientobject.isUnRegPat.toString());

  }

}
