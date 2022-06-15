import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Multi_Patient/MultiPatientCard.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpRequestOTP.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';

import 'package:intl/intl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


VerifyOtpResponseOTP res = new VerifyOtpResponseOTP();

String tempTypeOfSearch="";
String doctorId="", facilityId="",hospitalId="";
class Multi_patient_New extends StatefulWidget {



  Multi_patient_New({
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(

  );
}

class _CardListScreenState extends State<Multi_patient_New> {



  /* _CardListScreenState({

  });*/

  void initState() {
    // TODO: implement initState
    super.initState();
    CommonStrAndKey.globelDate= DateTime.now();
  }
  @override
  Widget build(BuildContext context) {


    return callBackApiResponse();
  }

  Widget callBackApiResponse()
  {
    return FutureBuilder<VerifyOtpResponseOTP>(
      future: callApi(), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<VerifyOtpResponseOTP> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('Rocord Not Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                )
            );
          else if (data.requireData.status!.toString().toLowerCase() == "success") {
            if (data.requireData.verifyPatinetList != null) {
              if (data.requireData.verifyPatinetList!.length > 0) {
                return layout(true);
              } else {
                return layout(false);
              }
            } else {
              return layout(false);
            }
          } else {
            return layout(false);
          }
        }
      },
    );
  }



  Widget layout(bool isVisible) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed:() {
            _onWillPop();
          },),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(CompanyColors.appbar_color),
                    Color(CompanyColors.appbar_color)
                  ]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(CompanyColors.appbar_color).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
        title: Text(
          'Patient List',
          style: TextStyle(fontSize: 16.0,color: Colors.white),
        ),

      ),
      body: ListLayout(isVisible),
    );
  }

  Widget ListLayout(bool isVisiable)


  {
    if(isVisiable)
    {
      return SafeArea(


        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: res.verifyPatinetList!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: MultiPatientCard(
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      PatientDetails: res.verifyPatinetList!.elementAt(index),
                      pos: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }else
    {
      return Center(child: Text('No Record Found'));
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => exit(0),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }
}

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(CompanyColors.appbar_color)
      ));
}

Future<VerifyOtpResponseOTP> callApi() async {
  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  VerifyOtpRequestOTP objddd = new VerifyOtpRequestOTP();
  String mobile=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobileNo)??"";
  objddd.mobileNo = mobile.toString();

  VerifyOtpRequestOTP objj =
  new VerifyOtpRequestOTP.fromJson(objddd.toJson());
  Response<VerifyOtpResponseOTP> responserrr =
  (await myService.GetPatientList(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new VerifyOtpResponseOTP.fromJson(postt!.toJson());
  return Future.value(res);
}




