import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';


class DemoScreen extends StatefulWidget {
  String? tittle;
  DemoScreen({
    this.tittle,
    Key? key}) : super(key: key);

  @override
  _CardGridScreenState createState() => _CardGridScreenState(tittle: tittle);
}

class _CardGridScreenState extends State<DemoScreen> {
   String? tittle;

  _CardGridScreenState({
    this.tittle,
    Key? key});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
      }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(''+tittle!.toString(),style: TextStyle(fontSize: 20.0,color: Colors.white70),),

      ),

      body: Stack(
        children: [

          Align(

            alignment: Alignment.center,
            child: new Container(
              alignment: Alignment.center,
              color: Color(0xffffcfcfc),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,

              margin: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text("Coming Soon",style: TextStyle(fontSize: 20,color: Color(CompanyColors.appbar_color)),),
            ),



          ),
        ],

      ),
    );
  }



}


