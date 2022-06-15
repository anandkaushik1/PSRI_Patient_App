import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/SensitivityResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class Lab_Sensitivity_Card__List extends StatelessWidget {
  final double? width;
  final double? height;
  final SensitivityDetailsarray? DataLabDetails;
  final int? pos;
  const Lab_Sensitivity_Card__List({
    Key? key,
    this.width,
    this.height,
    this.DataLabDetails,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return


      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: height!.toDouble(),
          maxWidth: MediaQuery.of(context).size.width,
        ),

        child:
        Container(
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
              new Container(
                child:

                 Visibility(

                   child:  Align(

                     child:  Text(
                     ""+DataLabDetails!.organismName.toString(),
                     textAlign: TextAlign.start,

                     style: TextStyle(
                       color: Color(CompanyColors.appbar_color),
                       fontWeight: FontWeight.bold,
                       fontSize: 12,

                     ),
                     maxLines: 2,
                   ),
                   alignment: Alignment.center,
                 ),
                   visible: (pos==0)?true:false,

                ),
              ),
              new Container(
                child: Row(
                  children: [
                   new  Expanded(

                      child:Text(
                        ""+DataLabDetails!.antibioticName.toString(),
                        textAlign: TextAlign.start,

                        style: TextStyle(
                          color: Color(CompanyColors.appbar_color),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,

                        ),
                        maxLines: 2,
                      ),
                     flex: 40,
                    ),
                    Expanded(
                      flex: 30,
                      child: Text(
                        ""+DataLabDetails!.interpretation.toString(),
                        textAlign: TextAlign.start,

                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,

                        ),
                        maxLines: 1,
                      ),
                    ),
                    Expanded(
                      flex: 30,
                      child: Text(
                        ""+DataLabDetails!.mIC.toString(),
                        textAlign: TextAlign.start,

                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,

                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

}

