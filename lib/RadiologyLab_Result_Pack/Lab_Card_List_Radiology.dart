

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitResponseRadio.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/RadilogyReport.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Lab_Card_List_Radiology extends StatefulWidget {
  String? encounterNo;
  VisitHistory? visit;

  Lab_Card_List_Radiology({
    this.encounterNo,
    this.visit,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        encounterNo: this.encounterNo,
        visit: this.visit,
      );
}

class _CardListScreenState extends State<Lab_Card_List_Radiology> {
  String? encounterNo;
  VisitHistory? visit;

  _CardListScreenState({
    this.encounterNo,
    this.visit,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
   return patientDetails(visit!);
  }

  Widget patientDetails(VisitHistory myDoctor) {
    return /*//PreferredSize(
      child:*/ Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(CompanyColors.white),
           ),
        child: Column(

          children: [
            new Container(
              margin: EdgeInsets.fromLTRB(20, 0, 5, 0),
              alignment: Alignment.topCenter,
              child: Row(
                children: [

                  Expanded(
                    flex: 100,
                    child: Column(
                      children: [

                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Flexible(
                              child :Text("" + myDoctor.doctorName.toString(),
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                 overflow: TextOverflow.ellipsis,
                              ),

                            ),
                            Text("" + myDoctor.encounterDate.toString(),
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),

                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),
                     // Visibility(
                        //visible: (myDoctor.isRadiology.toString().toLowerCase().trim() == "y")? true : false,
                        /*child: Container(
                          height: 400,
                          width: 350,
                          child: RadilogyReports(
                            IPOPno:myDoctor.encounterId,
                            Fromdate:myDoctor.encDate,
                            Todate:myDoctor.dischargeDate,
                          ),
                        )*/
                       // child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              child :Text("Radiology Reports" ,
                                style: TextStyle(
                                    color: Color(CompanyColors.appbar_color),fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),

                            SizedBox(
                              width: 10.0,
                            ),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RadilogyReports(
                                  IPOPno:myDoctor.encounterId,
                                    Fromdate:myDoctor.encDate,
                                    Todate:myDoctor.dischargeDate,



                                  )),


                                );

                              }, // handle your image tap here
                              child: Image.asset(
                                'assets/icons/radiology.png',
                                fit: BoxFit.cover, // this is the solution for border
                                width: 50.0,
                                height: 50.0,
                              ),
                            )

                          ],
                        ),

                     // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
     // ),
    );
  }



}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}


