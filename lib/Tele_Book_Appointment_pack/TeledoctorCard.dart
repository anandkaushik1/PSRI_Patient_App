

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/LightColor.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/text_styles.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleFavDoctorResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleBook_Appointment.dart';

class TeledoctorCard extends StatefulWidget {
   double? width;
   double? height;
   DoctorList? doctorList;
   int? pos;

   TeledoctorCard(this.height,this.width,this.doctorList,this.pos);


  @override
  _DoctorCardState createState() => _DoctorCardState(this.height,this.width,this.doctorList,this.pos);
}

class _DoctorCardState extends State<TeledoctorCard> {
  double? width;
  double? height;
  DoctorList? doctorList;
  int? pos;

  _DoctorCardState(this.height,this.width,this.doctorList,this.pos);
  @override
  Widget build(BuildContext context) {
    return _doctorTile();
  }

  Widget _doctorTile() {
    return InkWell(
      onTap: (){
        CommonStrAndKey.doctorForAppointment=doctorList!.iD.toString();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TeleBook_Appointment(
            doctorId: doctorList!.iD.toString(),
            nameDoctor:doctorList!.name.toString() ,

          )),
        );
      },
      child: Container(

        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 10,
              color: LightColor.grey.withOpacity(.2),
            ),
            BoxShadow(
              offset: Offset(-3, 0),
              blurRadius: 15,
              color: LightColor.grey.withOpacity(.1),
            )
          ],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: randomColor(),
                ),
                child: getDocImage(),
              ),
            ),
            title: Text(doctorList!.name.toString(), style: TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300)),
            subtitle: Text(
              doctorList!.specialisationName.toString(),
              style: TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_right,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ),
    );
  }
  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.purpleExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }
  Widget getDocImage() {
    if(doctorList!.doctorImagePath!.isEmpty){
      return Image.asset(
        'assets/images/profile_p_img.png',
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      );
    }else{
      return CircleAvatar(
        radius: 30.0,
        backgroundImage:
        NetworkImage(doctorList!.doctorImagePath!),
        backgroundColor: Colors.transparent,
      );
    }
  }
}
