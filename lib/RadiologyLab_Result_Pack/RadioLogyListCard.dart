import 'package:flutter/material.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitResponseRadio.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/RadilogyReport.dart';


class RadioLogyListCard extends StatelessWidget {
  final double? width;
  final double? height;
  final VisitHistory? PatientDetails;
  final int? pos;

  const RadioLogyListCard({
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
        /*   Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MasterCategoriesPatient(
              PatientDetails: PatientDetails,
              pos: pos,
            )));*/

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RadilogyReports(
            IPOPno:PatientDetails!.encounterId,
            Fromdate:PatientDetails!.encDate,
            Todate:PatientDetails!.dischargeDate,

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Name : ${PatientDetails!.doctorName!.toString()}",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black, fontWeight: FontWeight.bold),
                          ),

                        ],
                      ),

                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Encounter Date : ${PatientDetails!.encounterDate!.toString()} ",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "Encounter Id: ${PatientDetails!.encounterId!.toString()} ",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.w300),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //Text("Dr R. Verma  "+ dateValue, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                    ],
                  ),

                  Container(
                    height: 60.0,
                    width: 60.0,
                    color: Colors.white,
                    child:  Image.asset(
                        'assets/icons/view-doc.png',
                        height: 30,
                        width: 30,
                        fit: BoxFit.fill,

                      ),
                      //onPressed: onDelete,

                  )
                ],
              ),
            ],
          )),

    );
  }





}
