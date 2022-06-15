import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/DoctorList_Only_screen.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Specialisation_list_empty_card extends StatelessWidget {
  final double? width;
  final double? height;
  final SpecialisationDoctorListArray? SpecialisationData;
  final int? pos;

  const Specialisation_list_empty_card({
    Key? key,
    this.width,
    this.height,
    this.SpecialisationData,
    this.pos,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {




    return new GestureDetector(
      onTap: () {
        print("Container clicked");
         Navigator.push(  context,
                                MaterialPageRoute(builder: (context) => DoctorList_Only_screen(
                                   DeptId: SpecialisationData!.iD.toString(),
                                )));

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

                        /*onTap: ()
                          {
                            print("Container clicked");


                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DoctorList_Only_screen(
                                   DeptId: SpecialisationData.iD.toString(),
                                )));
                          },*/
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            SpecialisationData!.name.toString(),
                            style: TextStyle(
                                color:  Color(0xff5056ca),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),

                        /*  new Text(
                            SpecialisationData.doctorName,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                          ),*/
                        ],
                      )),),

                ],
              ),
            ],
          )),

    );
  }


}
