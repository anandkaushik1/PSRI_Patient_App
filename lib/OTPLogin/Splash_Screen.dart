import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/TokenModel.dart';
import 'package:flutter_patient_app/OTPLogin/Login_Screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
late BuildContext loaderContext;

class Splash_Screen extends StatefulWidget {

  static  String dynamicToken="";
  Splash_Screen({ Key? key}) : super(key: key);

  @override
  _CardGridScreenState createState() => _CardGridScreenState(

  );
}

class _CardGridScreenState extends State<Splash_Screen> {


  _CardGridScreenState({ Key? key});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    //forGetAuthToken(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return callBackApiResponse(context);
  }

  Widget callBackApiResponse(BuildContext myContext) {
    return FutureBuilder<TokenModel>(
      future: forGetAuthToken(myContext), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<TokenModel> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return layout(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Network Issue',
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ));
          else
          if (data.requireData != null) {
            if (data.requireData.accessToken !=null) {
              String strToken=data.requireData.tokenType.toString()+" "+data.requireData.accessToken.toString();
              saveData(strToken,context);
              return layout(context);
            } else {
              return layout(context);
            }
          } else {
            return layout(context);
          }

        }
      },
    );
  }

  Widget layout(BuildContext myContext)
  {
    return  Scaffold(
      backgroundColor: Colors.blue,

      body:

          new Container(
            child:  new Stack(

              children: <Widget>[
                Image.asset('assets/screenshot/background.png',

                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.center,
                ),

                new Container(
                  width: MediaQuery.of(context).size.width ,
                  height: MediaQuery.of(context).size.height ,
                  alignment: Alignment.center,
                  child : Align(

                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/screenshot/child_logo.png',
                        height: 150,
                          width: 150,
                        ),

                        SpinKitFadingCircle(size: 71.0, color: Color(0xffffffff)),
                      ],


                    ),
                  ),
                ),


              ],
            ),

          ),




    );
  }
  Widget Loading(BuildContext forThis) {
    return new ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          minHeight: 400,
          maxWidth: MediaQuery.of(context).size.width,
        ),

        child: new Stack(

          children: <Widget>[
            Image.asset('assets/screenshot/bg.jpg',

            ),

            new  ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                minHeight: 100,
                maxWidth: MediaQuery.of(context).size.width,
              ),

              child : Align(

                alignment: Alignment.center,
                child: Image.asset('assets/screenshot/logo.png',
                ),
              ),
            ),
            SpinKitFadingCircle(size: 71.0, color: Color(0xffffffff)),
          ],
        ));


  }
  void _onLoading(BuildContext pcontext) {
    showDialog(
      context: pcontext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loaderContext=context;
        return   Theme(
          data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),

          child: Dialog(
              child: new Container(
                height: 100,
                width: 100,
                color:Colors.transparent,

                child: new Center(

                  child:  new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                          color: Colors.transparent,
                          child: SpinKitFadingCircle(size: 51.0, color: Color(0xffffffff))),
                      new Text("Please wait...",style: TextStyle(fontSize: 25 ,color: Colors.white),),
                    ],
                  ),
                ),
              )


          ),);
      },
    );
    /* new Future.delayed(new Duration(seconds: 3), () {
      //pop dialog
      Navigator.pop(loaderContext);
      Navigator.push(
        pcontext,
        MaterialPageRoute(builder: (context) => Login_Screen()),
      );
    });*/
  }
  void saveData(String accessToken,BuildContext mycontext) async
  {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString("accessToken", accessToken);
    Splash_Screen.dynamicToken=accessToken;
    // Navigator.pop(loaderContext);
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login_Screen()),
    );*/
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        settings: RouteSettings(name: "/Login_Screen"),
        builder: (context) =>
            Login_Screen()), (Route<dynamic> route) => false);

  }


}

Future<TokenModel> forGetAuthToken(BuildContext context) async {

  // _onLoading(context);
  var url = BasicUrl.sendUrlToken();

  Map<String, dynamic> body = {
    'UserName': 'user',
    'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q=',
    'grant_type': 'password'
  };
  Uri myurl =Uri.parse(url);
  final response = await http.post(myurl,
      //body: body,
      body: body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      encoding: Encoding.getByName("utf-8")
  );

  /* if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);*/
  var tokenModel= TokenModel.fromJson(json.decode(response.body));
  return Future.value(tokenModel);
  /*   if(tokenModel!=null)
    {
      if(tokenModel.accessToken!=null)
      {
        String strToken=tokenModel.tokenType+" "+tokenModel.accessToken;
       // saveData(strToken,context);
      }
    }
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }*/

}


void getData() async
{
  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String myAccessToken=sharedPrefs.getString("accessToken") ?? 'not find';
  String test=myAccessToken;
}
