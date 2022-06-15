import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:intl/intl.dart';
String? MyFromDate, MyTodate= "";
class RadilogyReports extends StatefulWidget {
  final String? IPOPno;
  final String? Fromdate;
  final String? Todate;

  RadilogyReports({
    Key? key,
    this.IPOPno,
    this.Fromdate,
    this.Todate,

  }): super(key: key);

  @override
  _WebViewState createState() => _WebViewState(
    IPOPno:IPOPno,
    Fromdate:Fromdate,
    Todate:Todate,

  );
}

class _WebViewState extends State {
  String? IPOPno;
  String? Fromdate;
  String? Todate;
  _WebViewState({
    this.IPOPno,
    this.Fromdate,
    this.Todate,

  });

  @override
  void initState() {
    MyFromDate=Fromdate;
    MyTodate= Todate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

String? registationno= CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.registration_no) ?? '';
    print("http://182.74.143.146:8081//Default.aspx?IPno=IPD-"+registationno+"&Fromdate="+changeDateFromat(Fromdate!)+"&ToDate="+changeToFromat(Todate));

    //return WebviewScaffold(url: "http://182.74.143.146:8081//Default.aspx?IPno=IPD-262620&Fromdate=7-Sep-2021&ToDate=7-Sep-2021",
    //return WebviewScaffold(url: "http://182.74.143.146:8081//Default.aspx?IPno=IPD-"+IPOPno+"&Fromdate="+Fromdate+"&ToDate="+Todate,

 return WebviewScaffold(url: "http://182.74.143.146:8081//Default.aspx?IPno=IPD-"+registationno+"&Fromdate="+changeDateFromat(Fromdate!)+"&ToDate="+changeToFromat(Todate),
      appBar: AppBar(title: Text("Radiology Reports"),),
      withZoom: true,);

  }

String changeDateFromat(var date)
{
  var now = new DateTime.now();
  var formatter1 = new DateFormat('dd/MM/yyyy');
  var mydate= formatter1.parse(MyFromDate!.toString());
  var formatter = new DateFormat('dd-MMM-yyyy');
  String? formatted = formatter.format(mydate);
  print(formatted); // something like 2013-04-20
  return formatted;

}
  String changeToFromat(var date)
  {
    var now = new DateTime.now();
    var formatter1 = new DateFormat('MM/dd/yyyy');
    var mydate= formatter1.parse(MyTodate!.toString());
    var formatter = new DateFormat('dd-MMM-yyyy');
    String? formatted = formatter.format(mydate);
    print(formatted); // something like 2013-04-20
    return formatted;

  }
}