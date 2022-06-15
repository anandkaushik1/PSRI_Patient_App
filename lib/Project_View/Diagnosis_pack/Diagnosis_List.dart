import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Response.dart';
class Diagnosis_List extends StatelessWidget {
  final double? width;
  final double? height;
  final PatientDiagnosisArray? DiagnosisResult;
  final int? pos;

  const Diagnosis_List({
    Key? key,
    this.width,
    this.height,
    this.DiagnosisResult,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print("Container clicked");
//      Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context) => Categroies()),
//      );
      },
      child:ConstrainedBox(
      constraints: BoxConstraints(
      minWidth: MediaQuery.of(context).size.width,
      minHeight: height!.toDouble(),
      maxWidth: MediaQuery.of(context).size.width,
      ),

      child: Container(

          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(CompanyColors.shadow_color),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(getTitleFornew(DiagnosisResult!.iCDCode.toString()),
                style: TextStyle(color: Color(CompanyColors.bluegray)),
              ),
              //  new Text(DiagnosisResult.primaryDiagnosis),
              new Text(
                DiagnosisResult!.iCDDescription!.toString().replaceAll("<br/>", "\n"),
                style: TextStyle(color: Color(CompanyColors.bluegray)),
              ),
            ],
          )),),
    );
  }

  String  getTitleFornew(String titlevalue){
    print('diagnosis val : $titlevalue');
    if(titlevalue.isEmpty){
      return "Provisional Diagnosis";
    }else{
      return "ICD Code " +  titlevalue.replaceAll("<br/>", "\n");
    }
  }
}
