import 'package:flutter/material.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Full_Data_Response.dart';


class Prescription_List extends StatelessWidget {
  final double? width;
  final double? height;
  final CashesheetSummary? PreResult;
  final int? pos;
  const Prescription_List({
    Key? key,
    this.width,
    this.height,
    this.PreResult,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        print("Container clicked");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoriesPatient()),
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

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              /* new IconButton(
              padding: new EdgeInsets.all(0.0),
              color: Colors.green,
              icon: new Icon(Icons.home, size: 18.0),
              //onPressed: onDelete,
            ),*/
              /*new Text("NAME Mr.Vinod 25/M"),
            new Text("MOBILE 9834578943"),
            new Text("UHID 8976"),*/
         /*     new Text(PreResult.allergy),
              new Text(PreResult.status),
              new Text(PreResult.allergy),*/
            ],
          )
      ),
    );
  }
}
