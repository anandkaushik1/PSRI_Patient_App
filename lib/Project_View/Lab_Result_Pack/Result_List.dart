import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_details_List.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Lab_Report_Response.dart';

String lastDate = "";
int nextIndex = 0;
double selectMargn = 0;

class Result_List extends StatelessWidget {
  final List<MobLabInfoArray>? LabInfoArray;
  final double? width;
  final double? height;
  final MobLabInfoArray? labResult;
  final int? pos;
  final String? regId;

  const Result_List({
    Key? key,
    this.width,
    this.height,
    this.labResult,
    this.pos,
    this.LabInfoArray,
    this.regId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        print("Container clicked");
        if ((labResult!.status.toString().toLowerCase().trim() ==
            "ready") ||
            (labResult!.status.toString().toLowerCase().trim() ==
                "finalized"||labResult!.status.toString().toLowerCase().trim() ==
                "provisional")
             ) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Lab_details_List(
                  labData: labResult,
                  pos: pos,
                  regId: regId,
                )),
          );
        }
    },
      child: ConstrainedBox(

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

          children: <Widget>[
            new Center(
              child: dateTitle(pos!.toInt(), labResult!, LabInfoArray!),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 80,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        labResult!.serviceName.toString()/* +
                            "\n" +
                            labResult.serviceId.toString()*/,
                        style: TextStyle(
                          color: Color(CompanyColors.bluegray),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                new Expanded(
                  flex: 20,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new GestureDetector(
                         /* onTap: () {

                          },*/
                          child: fillColorReadyOrNot(labResult!.status.toString().trim()))
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),),
    );
  }

  Widget dateTitle(
      int pos, MobLabInfoArray date, List<MobLabInfoArray> ListData) {
    nextIndex = pos + 1;
    if (nextIndex < ListData.length && nextIndex != 0) {
      nextIndex = pos + 1;
      lastDate = ListData.elementAt(nextIndex).encodedDate!;
    } else {
      nextIndex = pos;
      lastDate = ListData.elementAt(nextIndex).encodedDate!;
    }
    if (date.encodedDate != lastDate || pos == 0) {
      selectMargn = 0;
      return layoutHeaderDate(date.encodedDate!.toString());
    } else {
      selectMargn = 0;
      return new Visibility(visible: false, child: new Text(""));
    }
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
          height: 30,
          width: 130,
          margin: EdgeInsets.only(bottom: 10),
          alignment: Alignment.center),
    );
  }

  Widget fillColorReadyOrNot(String status) {
    if ((status.toLowerCase() == "ready") ||
    (status.toLowerCase() == "finalized")) {
      return new Container(
        margin: EdgeInsets.only(top: selectMargn),
        child: Text(
          labResult!.status.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          maxLines: 1,
        ),
      );
    } else if(status.toLowerCase() == "provisional") {
      return new Container(
        margin: EdgeInsets.only(top: selectMargn),
        child: Text(
          labResult!.status.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
          maxLines: 1,
        ),
      );
    }else{
      return new Container(
        margin: EdgeInsets.only(top: selectMargn),
        child: Text(
          "" + labResult!.status.toString(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          maxLines: 2,
        ),
      );
    }
  }
}
