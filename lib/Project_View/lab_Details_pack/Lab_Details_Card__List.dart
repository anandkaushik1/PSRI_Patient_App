import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/CommonVitalsDropDown.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Sensitivity_List.dart';
import 'package:url_launcher/url_launcher.dart';

String? titleNameParameter, resultName, unitName, rangeName, methodName;
String resultValue = "", unitValue="", rangeValue="";
bool? resultVisiablity, webViewVisiablity, unitvisiablity, rangeVisiblity;

String saveRegId = "",
    saveRegNo = "",
    savePateintName = "",
    saveGender = "",
    saveAge = "",
    saveLastVisit = "";
//var result=new TextEditingController();
var result = "", lastDescription = "";
List<String> shortItems = ['DD 0', 'WW 1', 'MM 1', 'MM 3', 'MM 6', 'YY 1'];
List<String> timesItems = [
  'Day',
  'Week',
  'Month',
  '3 Month',
  '6 month',
  'Year'
];
List<CommonVitalsDropDown> dataForFilter= <CommonVitalsDropDown>[];

class Lab_Details_Card__List extends StatelessWidget {
  final double? width;
  final double? height;
  final DoctorLabDetails? DataLabDetails;
  final List<DoctorLabDetails>? listData;
  final int? pos;
  final int? sizeAry;
  final String? patientName;
  final String? regID;
  static String fieldMyValue="";
  const Lab_Details_Card__List({
    Key? key,
    this.width,
    this.height,
    this.DataLabDetails,
    this.pos,
    this.sizeAry,
    this.patientName,
    this.regID,
    this.listData,
  }) : super(key: key);

  void forFilterDropDown() {
    dataForFilter.clear();
    for (int i = 0; i < shortItems.length; i++) {
      CommonVitalsDropDown timep = new CommonVitalsDropDown(
          timesItems.elementAt(i), shortItems.elementAt(i));
      dataForFilter.add(timep);
    }
  }

  @override
  Widget build(BuildContext context) {
    lastDescription = "";
    forFilterDropDown();
    validDataDisplayLogic(DataLabDetails!, context);
    return ViewPart(context,pos!.toInt(),DataLabDetails!);
  }
  Widget ViewPart(BuildContext context,int pos,DoctorLabDetails DataLabDetails )
  {
      return new GestureDetector(

        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: height!.toDouble(),
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            /*  width: width,
          height: height,*/

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
            child: Column(
              children: [
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        flex: 40,
                        child:new Align(

                          child:   Text(
                            ""+DataLabDetails.fieldName.toString(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(CompanyColors.bluegray),
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            maxLines: 3,
                          ),
                          alignment: Alignment.centerLeft,
                        )


                    ),

                    Expanded(
                      flex:setExpentableSize(DataLabDetails),
                      child: Visibility(
                        visible:(DataLabDetails.fieldType.toString().toLowerCase() == "w")?false:true ,
                       child: new Align(
                        alignment: Alignment.centerRight,
                        child: resultTypeAndSetColor(DataLabDetails, context, pos),),)
                    ),


                  ],
                ),
                new Visibility(
                  visible:(DataLabDetails.fieldType.toString().toLowerCase() == "w")?true:false ,
                  child:   new Align(
                    alignment: Alignment.centerRight,
                    child: resultTypeAndSetColor(DataLabDetails, context, pos),),
                ),

                Container(
                  child: lastDescriptionMethod(sizeAry!.toInt() - 1, pos),
                ),
              ],
            ),


          ),),
      );
  }
}

int setExpentableSize(DoctorLabDetails data)
{
  if((data.fieldType.toString().toLowerCase() == "w")||(data.fieldType.toString().toLowerCase() == "h"))
    {
      return 0;
    }else {
       return 55;
  }
}

Widget lastDescriptionMethod(int size, int pos) {
  String sourceString = "<b>" +
      "Disclaimer" +
      "<//b> " +
      ("*For all clinical/legal purposes, please refer to the hard copy of " +
          "   the report issued by " +
          "Hospital" +
          "* The App is intended to provide a quick view of the values of the " +
          "   test report and should only be used for the purpose of reference.");
  if (pos == size) {
    return new Visibility(
        visible: true,
        child: Html(
          data: lastDescription + "<br>" + sourceString,
          //defaultTextStyle: TextStyle(color: Colors.black, fontSize: 10),
        ));
  } else {
    return new Visibility(
        visible: false,
        child: Html(
          data: lastDescription + "<br>" + sourceString,
         // defaultTextStyle: TextStyle(color: Colors.black, fontSize: 10),
        ));
  }
}

void validDataDisplayLogic(DoctorLabDetails objDetails, BuildContext context) {
  String str = "";

  if (objDetails.result.toString().trim() != "") {
    if (objDetails.unitName.toString().trim() == "") {
      String tempResult = objDetails.result.toString().replaceAll("u000a", "");
      String item = objDetails.result.toString().replaceAll("(0.00 0.00)", "");
      result = item.toString();
      if (tempResult.toString().trim() == "download") {
        // set blue of download
        // open pdf/ goto brower
        if (objDetails.pDFURL!.isNotEmpty) {
          _launchURL("" + objDetails.pDFURL!.toString().trim());
        } else {
          //link are not available // DOWNLOAD BUTTON NOT RETURN

        }
      }
      String titleFieldName = "" + objDetails.fieldName!.toString().trim();
      if (titleFieldName.toString().toLowerCase().trim() == "sensitivity") {

      }
    } else {
      String item = objDetails.result!.toString().replaceAll("(0.00 0.00)", "");
      // item set txtResult text (convert item text inton html text)
      String tempUnit = objDetails.unitName!.toString().replaceAll("\\\\", "");
      result = tempUnit;
      // holder.txtResult.setText(Html.fromHtml(tempUnit));
      // this concept do not used
      //  String tempStr = "" + holder.txtResult.getText();
      /* String tempSparate[] = tempStr.split(" ");
    if (tempSparate.length >= 4) {
      holder.txtRange.setText("Range:-" + tempSparate[1] + tempSparate[2] + tempSparate[3]);
    }
    holder.txtUnit.setText("Unit:-" + Html.fromHtml(Unit));*/
      // // this concept do not used

    }
  }
  if (objDetails.fieldType!.toString().trim().isNotEmpty) {
    if (objDetails.fieldType!.toString().trim().toLowerCase() == "w") {
      if (objDetails.valueWordProcessor!.toString().trim().isNotEmpty) {
        result = "" + objDetails.valueWordProcessor.toString();

        /// return Text(""+objDetails.valueWordProcessor.toString());
      }
    }
  }
  if (objDetails.abnormalValue!.toString().trim().isNotEmpty) {
    if (objDetails.abnormalValue!.toString().trim() == "1") {
      if (objDetails.result!.toString().trim().isNotEmpty) {
        result = "" + objDetails.valueWordProcessor.toString();
        //return Text(""+objDetails.valueWordProcessor.toString(),style: TextStyle(color: Colors.red),);
      }
    }
  }
  if (objDetails.fieldType!.toString().trim().isNotEmpty) {
    if (objDetails.fieldType!.toString().trim().toLowerCase() == "h") {
      result = "";
      // return Text("");

    }
  }
  String tempServiceRemarks = objDetails.serviceRemarks.toString();
  if (tempServiceRemarks.isNotEmpty) {
    lastDescription = objDetails.serviceRemarks.toString();
  }
  //return Text("");
}

Widget? resultTypeAndSetColor(
    DoctorLabDetails objDetails, BuildContext context, int position) {
  if (objDetails.result.toString().isNotEmpty) {
    if (objDetails.result.toString().toLowerCase() == "result"||objDetails.result.toString().toLowerCase() == "result (provisional)") {
      if (objDetails.fieldType.toString().toLowerCase() == "w") {
        result = objDetails.valueWordProcessor.toString();
        return Html(
          data: result,
         // defaultTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
        );
      } else if (objDetails.fieldType.toString().toLowerCase() == "sn") {
        result = "Result   ";
        return GestureDetector(
          child: Html(
            data: """<div><p>""" + result +"&#x2192"+ """<//p><//div>""",
           // defaultTextStyle: TextStyle(color: Colors.blue, fontSize: 17),
           // backgroundColor:Colors.white ,

          ),
          onTap: () {
            String titleFieldName = "" + objDetails.fieldName!.toString().trim();
            if (titleFieldName.toString().toLowerCase().trim() == "sensitivity") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Sensitivity_List(
                        labData: objDetails,
                        pos: position,
                      )));
            }

          },
        );
      } else if (objDetails.fieldType.toString().toLowerCase() == "h") {
        result = "";
        return Visibility(
          visible: false,
         child:  Html(
          data: """<div><p>""" + result + """<//p><//div>""",
         // defaultTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
        ),);
      } else {
        result = "";
        return Html(
          data: """<div><p>""" + result + """<//p><//div>""",
        //  defaultTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
        );
      }
    }
    else if (objDetails.result.toString().toLowerCase() == "download") {
      result = "Download";
      return GestureDetector(

      child:  Html(
        data: """<div><p>""" + result + """<//p><//div>""",
        //defaultTextStyle: TextStyle(color: Colors.blue, fontSize: 22),
       /* onLinkTap: (url) {

        },*/
      ),
      onTap: () {
        _launchURL(objDetails.pDFURL.toString().trim());
      },
      );

      ///
    } else {
      if (objDetails.abnormalValue.toString().isNotEmpty) {
        if (objDetails.abnormalValue.toString() == "1") {
          result = objDetails.result.toString();
          return Html(
            data: """<div><p>""" + result + """<//p><//div>""",
            //defaultTextStyle: TextStyle(color: Colors.red, fontSize: 15),
          );
        } else {
          // gray result
          result = objDetails.result.toString();
          return Html(
            data: """<div><p>""" + result + """<//p><//div>""",
           // defaultTextStyle: TextStyle(color: Colors.blue, fontSize: 15),
          );
        }
      }
    }
  } else {
    result = "";
    return Html(
      data: """<div><p>""" + result + """<//p><//div>""",
      //defaultTextStyle: TextStyle(color: Colors.grey, fontSize: 15),
    );
  }
}



_launchURL(String url) async {
  //const url = 'https://flutter.io';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
