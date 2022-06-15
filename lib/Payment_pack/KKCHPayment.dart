import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/PatientLogin_pack/Multi_Patient_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'package:flutter_svg/flutter_svg.dart';
var uuid = Uuid();
String orderIDStr="";
late   Uri myurl;
//live payment url
//http://182.74.143.146:211
//uat payment url
//"http://182.74.143.146:219
class KKCHPayment extends StatefulWidget {
  String? myOrderId;
  String? myUserId;
  KKCHPayment({
    Key? key,
    this.myOrderId,
    this.myUserId,
  }) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState(myOrderId: myOrderId,myUserId: myUserId);
}

class _MyAppState extends State<KKCHPayment> {
  String? myOrderId;
  String? myUserId;
  InAppWebViewController? webView;
  String url = "";
  double progress = 0;
  _MyAppState({
    this.myOrderId,
    this.myUserId,

  });
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  final urlController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // orderIDStr = uuid.v1();
    orderIDStr=myOrderId!.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: Text('Payment',style:TextStyle(fontSize: 16.0),),
         backgroundColor: Color(CompanyColors.appbar_color),
         leading: new IconButton( icon: new Icon(Icons.arrow_back),
         color: Colors.white,
           onPressed: () => Navigator.of(context).pop()),


       ),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: InAppWebView(
                    key: webViewKey,

                initialUrlRequest: URLRequest(url:Uri.parse("http://182.74.143.146:219/Default/?Map=1&var="+orderIDStr.toString())),

                //initialUrlRequest: URLRequest(url:Uri.parse("http://182.74.143.146:211/Default/?Map=1&var="+orderIDStr.toString())),
                    initialOptions: options,
                   onWebViewCreated: (controller) {
                      webView = controller;
                    },
                    onLoadStart: ( controller,url) {
                      setState(() {
                        this.url = url!.scheme;
                        print("====="+url.toString());
                        if(url.scheme.toString().trim()=="http://182.74.143.146:219/surl") {
                       //   if(url.scheme.toString().trim()=="http://182.74.143.146:211/surl") {

                        }else if(url.scheme.toString().trim()=="http://182.74.143.146:219/surl")
                        //else if(url.scheme.toString().trim()=="http://182.74.143.146:211/furl")
                        {
                          //_viewFailPage(context);
                        }


                      });
                    },


                    onLoadStop:
                        ( controller,   url) async {
                      setState(() {
                        this.url = url!.scheme.toString();
                        print("====="+url.toString());

                        if((url.toString().trim()=="http://182.74.143.146:219/surl")||(url.toString().trim()=="http://182.74.143.146:219/surl"))

                       //   if((url.toString().trim()=="http://182.74.143.146:211/surl")||(url.toString().trim()=="http://182.74.143.146:211/furl"))
                        {
                          new Future.delayed(new Duration(seconds: 1), () {
                            //pop dialog
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName("/CategoriesPatient"));
                          });

                        }

                      });
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ),

            ])),
      ),
    );
  }
}


Future<bool> _viewSuccessPage(BuildContext context,String strOrderId,strUserId) async {

  return (await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => new AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: new Text('Payment Status',
          style: TextStyle(height: 1.0, fontSize: 14), ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        color: Colors.white,
        child: Column(
          children: [
            new Container(
              alignment: Alignment.center,
              ///payment_fail
              child: new SvgPicture.asset('assets/New_Icons/payment_suceess.svg',
                height: 120,
                width: 120,
                fit:BoxFit.fill,
              ),
            ),
            new Container(
              height: 100,
              width: 250,
              margin: EdgeInsets.fromLTRB(5,15,5,5),
              alignment: Alignment.center,
              child:Column(
                  children: [
                    new Text(
                      "Payment Success!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey,fontSize: 20,),
                    ),
                    new Text(
                      "\n it our pleasure to offer you\n our products",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey,fontSize: 10,),
                    ),
                  ]
              ),

            ),
            new Container(
              width: 200,
              height: 40,
              margin: EdgeInsets.fromLTRB(0,40,0,5),
              alignment: Alignment.center,

              child: ButtonTheme(
                minWidth: 200.0,
                height: 40.0,
                child:new RaisedButton(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Color(0xff90EE90)

                    ),

                  ),
                  color: Colors.white,
                  child: Text("View Order Details",style: TextStyle(color: Color(0xff90EE90),fontSize: 15),),
                  onPressed: () {
                    /*  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);*/
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("/CategoriesPatient"));

                  },

                ),),
            )

          ],
        ),
      ),
      /* actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text("Cancel"),
        ),


      ],*/
    ),
  )) ??
      false;
}

Future<bool> _viewFailPage(BuildContext context) async {

  return (await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => new AlertDialog(
      title: Container(
        alignment: Alignment.center,
        child: new Text('Payment Status',
          style: TextStyle(height: 1.0, fontSize: 14), ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: 350,
        color: Colors.white,
        child: Column(
          children: [
            new Container(
              alignment: Alignment.center,
              ///payment_fail
              child: new SvgPicture.asset('assets/New_Icons/payment_fail.svg',
                height: 120,
                width: 120,
                fit:BoxFit.fill,
              ),
            ),
            new Container(
              height: 100,
              width: 250,
              margin: EdgeInsets.fromLTRB(5,15,5,5),
              alignment: Alignment.center,
              child:Column(
                  children: [
                    new Text(

                      "Payment Failed!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey,fontSize: 20,),
                    ),
                    new Text(

                      "\n it seems we have not\n received money",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blueGrey,fontSize: 10,),
                    ),
                  ]
              ),

            ),
            new Container(
              width: 200,
              height: 40,
              margin: EdgeInsets.fromLTRB(0,40,0,5),
              alignment: Alignment.center,

              child: ButtonTheme(
                minWidth: 200.0,
                height: 40.0,
                child:new RaisedButton(

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    side: BorderSide(color: Color(0xff880000)

                    ),

                  ),
                  color: Colors.white,
                  child: Text("Try Again",style: TextStyle(color: Color(0xff880000),fontSize: 15),),
                  onPressed: () {
                    /*  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);*/
                    Navigator.of(context)
                        .popUntil(ModalRoute.withName("/CategoriesPatient"));
                  },

                ),),
            )

          ],
        ),
      ),
      /* actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text("Cancel"),
        ),


      ],*/
    ),
  )) ??
      false;
}