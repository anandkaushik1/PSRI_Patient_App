import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/FullCaseReport.dart';
import 'package:html/parser.dart';


class CaseSheet_List extends StatelessWidget {
  final double? width;
  final double? height;
  final FullCaseReport? PreResult;
  final int? pos;
  const CaseSheet_List({
    Key? key,
    this.width,
    this.height,
    this.PreResult,
    this.pos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new /*GestureDetector(
      onTap: (){
        print("Container clicked");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Categroies()),
        );
      },
      child:*/ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width!.toDouble(),
          minHeight: height!.toDouble(),
          maxWidth: width!.toDouble(),

        ),
      child:
      Container(
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
          child: Wrap(
            children: [
              new Column(

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
                   titleVIew(PreResult!.titleName.toString()),

                 // new Text(PreResult.subTitleName),
                  //convertStringIntoHtml(PreResult.subTitleName),
                  new Html(
                    data: PreResult!.subTitleName.toString().replaceAll("null", ""),
                  ),
                  //new Text(PreResult.firstLinedetails),
                //  convertStringIntoHtml(PreResult.firstLinedetails),
                  new Html(
                    data: PreResult!.firstLinedetails.toString().replaceAll("null", ""),
                  ),
                 // new Text(PreResult.secLinedetails),
                  //convertStringIntoHtml(PreResult.secLinedetails),
                  new Html(
                    data: PreResult!.secLinedetails.toString(),
                  ),
                 // new Text(PreResult.thirdLinedetails),
              //    convertStringIntoHtml(PreResult.thirdLinedetails),
                  new Html(
                    data: PreResult!.thirdLinedetails.toString(),
                  ),
                  new Text(PreResult!.date.toString()),
                  new Text(PreResult!.enterBy.toString()),
                ],
              )
            ],
          )


      ),);
   // );
  }

  Widget titleVIew(String titleName)
  {

    if(titleName.isNotEmpty) {
      return new Visibility(
        visible: true,
        child: new Container(
            child: new Text(
              titleName,
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(6.0),
              color: Color(CompanyColors.appbar_color),
            ),

            height: 30,
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 10),
            alignment: Alignment.center),
      );
    }else
      {
        return new Visibility(
            visible: false,
            child: new Text("")
        );
      }

  }
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
        r"<[^>]*>",
        multiLine: true,
        caseSensitive: true
    );

    return htmlText.replaceAll(exp, '');
  }
  Widget convertStringIntoHtml(String StrData)
  {
    String withOutTag=_parseHtmlString(StrData);
    String dataStr="<p>"+withOutTag+"</p>";

    return Html(data: dataStr ,);
  }
  String _parseHtmlString(String htmlString) {

    var document = parse(htmlString);

    String parsedString = parse(document.body!.text.toString()).documentElement!.text.toString();

    return parsedString;
  }
}
