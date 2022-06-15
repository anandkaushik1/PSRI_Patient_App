import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Request.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/vertical_bar_label_vitals.dart';

int nextIndex = 0;
String lastDate = "";
Vital_Graph_Sign_Response res = new Vital_Graph_Sign_Response();
int listsize=0;
class Vital_List extends StatelessWidget {
  final List<PatietnListArray>? ListArray;
  final double? width;
  final double? height;
  final PatietnListArray? VitalResult;
  final int? pos;
  final String? hospitalId;

  const Vital_List({
    Key? key,
    this.width,
    this.height,
    this.VitalResult,
    this.pos,
    this.ListArray,
    this.hospitalId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    callVitalsSignApi(context, hospitalId!.toString());
    listsize=ListArray!.length-1;
    return new GestureDetector(
      /*onTap: () {
        print("Container clicked");

      },*/
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: height!.toDouble(),
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Container(
            /* width: width,
          height: height,*/
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Center(
                    child:dateTitle(pos!.toInt(), VitalResult!, ListArray!),
            ),
                new Container(
                  child: Height(VitalResult!),
                ),
                new Container(
                  child: Weight(VitalResult!),
                ),
                new Container(
                  child: Respiration(VitalResult!),
                ),
                new Container(
                  child: Pulse(VitalResult!),
                ),
                new Container(
                  child: Temperature(VitalResult!),
                ),
                new Container(
                  child: BPSystolic(VitalResult!),
                ),
                new Container(
                  child: BpDiastolic(VitalResult!),
                ),
                new Container(
                  child: HeadCircumference(VitalResult!),
                ),

               /* new Container(
                  child: PainStore(VitalResult),
                ),*/
                new Container(
                  child: bMI(VitalResult!),
                ),
                new Container(
                  child: bSA(VitalResult!),
                ),
                new Container(
                  child: sPO2(VitalResult!),
                ),
                new Container(
                  child: mAC(VitalResult!),
                ),
                new Container(
                  child: gRBS(VitalResult!),
                ),
                new Container(
                  child: PainScorePre(VitalResult!),
                ),
                new Container(
                  child: UnStandable(VitalResult!),
                ),
                new Container(
                  child: Critical(VitalResult!),
                ),

                //new Text(VitalResult.bMI),
                //  new Text(VitalResult.bPDiastolic),
              ],
            )),
      ),
    );
  }





  Widget dateTitle(
      int pos, PatietnListArray date, List<PatietnListArray> ListData) {
    nextIndex = pos + 1;
    if (nextIndex < ListData.length && nextIndex != 0) {
      nextIndex = pos + 1;
      lastDate = ListData.elementAt(nextIndex).vitalDate!;
    } else {
      nextIndex = pos;
      lastDate = ListData.elementAt(nextIndex).vitalDate!;
    }
    if (date.vitalDate != lastDate || pos == 0) {
      return new Container(
          child:  new Text(
            date.vitalDate!.toString(),
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(6.0),
            color: Color(CompanyColors.appbar_color),
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          height: 30,
          width: 200,
          margin: EdgeInsets.only(bottom: 20),
          alignment: Alignment.center);


    } else {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    }
  }

  Widget Respiration(PatietnListArray data) {
    if (data.respiration.toString().trim() == "" || data.respiration == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Respiration", data.respiration!.toString());
    }
  }

  Widget Pulse(PatietnListArray data) {
    if (data.pulse.toString().trim() == "" || data.pulse == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Pulse", data.pulse.toString());
    }
  }

  Widget Height(PatietnListArray data) {
    if (data.height.toString().trim() == "" || data.height == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Height", data.height.toString());
    }
  }

  Widget Weight(PatietnListArray data) {
    if (data.weight.toString().trim() == "" || data.weight == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Weight", data.weight.toString());
    }
  }

  Widget HeadCircumference(PatietnListArray data) {
    if (data.headCircumference.toString().trim() == "" ||
        data.headCircumference == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("HeadCircumference", data.headCircumference.toString());
    }
  }

  Widget Temperature(PatietnListArray data) {
    if (data.temperature.toString().trim() == "" || data.temperature == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Temperature", data.temperature.toString());
    }
  }

  Widget BPSystolic(PatietnListArray data) {
    if (data.bPSystolic.toString().trim() == "" || data.bPSystolic == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("BPSystolic", data.bPSystolic.toString());
    }
  }

  Widget BpDiastolic(PatietnListArray data) {
    if (data.bPDiastolic.toString().trim() == "" || data.bPDiastolic == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("BPDiastolic", data.bPDiastolic.toString());
    }
  }

 /* Widget PainStore(PatietnListArray data) {
    if (data.painScore.toString().trim() == "" || data.painScore == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("PainScore", data.painScore);
    }
  }*/

  Widget bMI(PatietnListArray data) {
    if (data.bMI.toString().trim() == "" || data.bMI == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("BMI", data.bMI.toString());
    }
  }

  Widget bSA(PatietnListArray data) {
    if (data.bSA.toString().trim() == "" || data.bSA == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("BSA", data.bSA.toString());
    }
  }

  Widget sPO2(PatietnListArray data) {
    if (data.sPO2.toString().trim() == "" || data.sPO2 == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("SPO2", data.sPO2.toString());
    }
  }

  Widget mAC(PatietnListArray data) {
    if (data.mAC.toString().trim() == "" || data.mAC == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("MAC", data.mAC.toString());
    }
  }

  Widget gRBS(PatietnListArray data) {
    if (data.gRBS.toString().trim() == "" || data.gRBS == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("GRBS", data.gRBS.toString());
    }
  }
  Widget PainScorePre(PatietnListArray data) {
    if (data.painScore.toString().trim() == "" || data.painScore == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Pain Score", data.painScore.toString());
    }
  }

  Widget UnStandable(PatietnListArray data) {
    if (data.unstandable.toString().trim() == "" || data.unstandable == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("UnStandable", data.unstandable.toString());
    }
  }

  Widget Critical(PatietnListArray data) {
    if (data.critical.toString().trim() == "" || data.critical == null) {
      return Visibility(
        visible: false,
        child: new Text(""),
      );
    } else {
      return RowView("Critical", data.critical.toString());
    }
  }

  Widget RowView(String title, String value) {
    return new Container(
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            margin: EdgeInsets.only(top: 15),
            child: new Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      fontSize: 13.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Color(CompanyColors.bluegray),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    value,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      fontSize: 15.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      color: Color(CompanyColors.appbar_color),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Visibility(
            visible: (listsize==pos)?false : false,
            child:  new Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(1.0),
                  color: Color(CompanyColors.bluegray),
                ),
                height: 1,
                width: double.infinity,
                alignment: Alignment.center),
          ),
        ],
      ),
    );
  }
  Widget layoutHeaderDate(String Date) {
    return new Visibility(
      visible: true,
      child: new Container(
          child: new Text(
            Date,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 13.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(6.0),
            color: Color(CompanyColors.appbar_color),
          ),
          height: 40,
          width: 130,
          margin: EdgeInsets.only(bottom: 0),
          alignment: Alignment.center),
    );
  }
}

Future callVitalsSignApi(BuildContext context, String hospitalId) async {
  // _onLoading();
  String url = BasicUrl.sendUrlGraph();
  final myService = MyServicePost.create(url);
  Vital_Graph_Sign_Request setObj = new Vital_Graph_Sign_Request();
  setObj.hospitalLocationId = "" + hospitalId.toString();
  Vital_Graph_Sign_Request obj =
      new Vital_Graph_Sign_Request.fromJson(setObj.toJson());
  Response<Vital_Graph_Sign_Response> response =
      (await myService.GetVitalSignName(obj));
  print('santi val ${response.body}');
  var post = response.body;
  if (post != null) {
    res = new Vital_Graph_Sign_Response.fromJson(post.toJson());
    if (res != null) {
      if (res.status!.toString().toLowerCase() == "success") {
      } else {}
    }
  }
}
