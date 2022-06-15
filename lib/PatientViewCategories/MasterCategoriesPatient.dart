import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/SpecialisationAndDoctorList.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/PatientViewCategories/Categories_emptycard.dart';
import 'package:flutter_patient_app/Profile/Profile.dart';
import 'package:flutter_patient_app/Writes/WritesUs.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/src/widgets/icon.dart';

var titleName;
class MasterCategoriesPatient extends StatefulWidget {
  PatientList? PatientDetails;
  int? pos;

  MasterCategoriesPatient({this.PatientDetails, this.pos, Key? key}) : super(key: key);

  @override
  _CardGridScreenState createState() => _CardGridScreenState(
        PatientDetails:  this.PatientDetails,
        pos: this.pos,
      );
}

class _CardGridScreenState extends State<MasterCategoriesPatient> {
  PatientList? PatientDetails;
  int? pos;

  _CardGridScreenState({this.PatientDetails, this.pos, Key? key});

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    var columnCount = 3;
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/CategoriesPatient',

      home: new CategoriesPatient(
        //PatientDetails: PatientDetails,
        pos: pos,
      ),
      routes: <String, WidgetBuilder> {
        '/CategoriesPatient': (BuildContext context) => new CategoriesPatient(
         // PatientDetails: PatientDetails,
          pos: pos,
        ),
        '/WritesUs': (BuildContext context) => new WritesUs(),
        '/SpecialisationAndDoctorList': (BuildContext context) => new SpecialisationAndDoctorList(),
        '/Profile': (BuildContext context) => new Profile(),

    },
    );
  }

}
