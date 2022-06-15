import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/DoctorList_Only_screen.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/LightColor.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/text_styles.dart';

class SpecialisationCard extends StatefulWidget {
  double? width;
  double? height;
  SpecialisationDoctorListArray? SpecialisationData;
  int? pos;

  SpecialisationCard(
      this.height, this.width, this.SpecialisationData, this.pos);

  @override
  _SpecialisationCardState createState() => _SpecialisationCardState(
      this.height, this.width, this.SpecialisationData, this.pos);
}

class _SpecialisationCardState extends State<SpecialisationCard> {
  double? width;
  double? height;
  SpecialisationDoctorListArray? SpecialisationData;
  int? pos;

  _SpecialisationCardState(
      this.height, this.width, this.SpecialisationData, this.pos);

  @override
  Widget build(BuildContext context) {
    return _specialisationTiles();
  }
  Widget _specialisationTiles() {
    return InkWell(
      onTap: (){
        Navigator.push(  context,
            MaterialPageRoute(builder: (context) => DoctorList_Only_screen(
              DeptId: SpecialisationData!.iD.toString(),
            )));
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
              title: Text(SpecialisationData!.name.toString(), style: TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300)),
              /*subtitle: Text(
                SpecialisationData.resultType.toString(),
                style: TextStyle(fontSize: FontSizes.body, fontWeight: FontWeight.w300),
              ),*/
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
    if(SpecialisationData!.specialisationImagePath!.isEmpty){
      return Image.asset(
        'assets/images/deseas.png',
        height: 50,
        width: 50,
        fit: BoxFit.contain,
      );
    }else{
      return CircleAvatar(
        radius: 30.0,
        backgroundImage:
        NetworkImage(SpecialisationData!.specialisationImagePath!.toString()),
        backgroundColor: Colors.transparent,
      );
    }
  }
}
