import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/anim/animation_limiter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class AboutUs extends StatefulWidget {
  String? encounterNo = "";


  AboutUs({
    Key? key,
    this.encounterNo,

  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        encounterNo: this.encounterNo,

      );
}

class _CardListScreenState extends State<AboutUs> {
  String? encounterNo = "";


  _CardListScreenState({
    Key? key,
    this.encounterNo,

  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(CompanyColors.grey),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About Us',
          style: TextStyle(fontSize: 16.0,color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Color(CompanyColors.appbar_color),
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color(0xFF17ead9),
              //       Color(0xFF6078ea)
              //     ]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
      ),
      body: new Center(
        child:layout(),
      ),
    );



  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}

/*Widget webViewData() {
  return WebView(
      initialUrl:
          "https://doxper.com/doc/visit_patient_prescription/?patient_id=534489&visit_id=1423036&organisation=BLK&token=c6bf1fc14da7a418b1da84d0f3a19a2f35e3f17d");
}*/

Widget WebViewLibPlagin() {
  return new Container(
    child: new WebviewScaffold(
     /* url:
          "https://akhilsystems.com/about-us/",*/
      url:
      "https://www.psrihospital.com/about",



      withZoom: true,
      withLocalStorage: true,
      hidden: false,
      initialChild: Container(
        color: Colors.white,
        child: const Center(
          child: Text('Waiting.....'),
        ),
      ),
    ),
    margin: EdgeInsets.only(top: 0),
  );
}

Widget layout() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: AnimationLimiter(
        child: WebViewLibPlagin(),

      ),
    ),
  );
}




