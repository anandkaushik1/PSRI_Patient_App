import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';

import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientLogin_pack/PatientList_Request.dart';
import 'package:flutter_patient_app/PatientLogin_pack/PatientList_Response.dart';

import 'package:flutter_patient_app/PatientLogin_pack/Patient_empty_card.dart';

import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';

import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';



import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



ListOfIpPatientResponse res = new ListOfIpPatientResponse();
VerifyOtpResponseOTP resData = new VerifyOtpResponseOTP();

class Multi_Patient_list_screen extends StatefulWidget {

  List<VerifyPatinetList>? patientList;
  String? mobilNo;

  Multi_Patient_list_screen({
    this.patientList,
    this.mobilNo,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        patientList:  this.patientList,
        mobilNo: mobilNo

      );
}

class _CardListScreenState extends State<Multi_Patient_list_screen> {
  List<VerifyPatinetList>? patientList ;
  String? mobilNo;
  _CardListScreenState({
    this.patientList,
    this.mobilNo
  });

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: _onWillPop,
    //   child:   callBackApiResponse(patientList),
    // );


    return FutureBuilder<VerifyOtpResponseOTP>(
      future: callApiData(), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<VerifyOtpResponseOTP> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return noDataFound(context);
          else if (data.requireData == null) {
            return noDataFound(context);
          } else {
            if (data.requireData.verifyPatinetList!.length > 0) {
              return callBackApiResponse(data.requireData.verifyPatinetList!);
            }else{
              return noDataFound(context);

            }
          }
        }
      },
    );

     callApiData();
  }



  Widget noDataFound(BuildContext context) {
    return new Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'No Record Found',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ));
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
  }




  Future<VerifyOtpResponseOTP> callApiData() async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    PatientList_Request req = new PatientList_Request();

    print('getMobileNO saravpreet ${mobilNo}');

    req.mobileNo = mobilNo;
   //req.mobileNo = patientList[0].mobileNo;
    print('Sarav  respond ${req.toJson().toString()}');
    PatientList_Request objj = new PatientList_Request.fromJson(req.toJson());
    //Response<VerifyOtpResponseOTP> responserrr =
   // (await myService.GetPatientList(objj));
   // var postt = responserrr.body;
   // resData = new VerifyOtpResponseOTP.fromJson(postt!.toJson());
    print("Response visit   \n" + resData.toJson().toString());

    return Future.value(resData);


  }



  Widget callBackApiResponse(List<VerifyPatinetList> patientList)
  {
    return layout(patientList, true);
  }

  Widget layout(List<VerifyPatinetList> patientList, bool isVisible) {

    return Scaffold(
      backgroundColor: Color(CompanyColors.grey),
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
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [
              //       Color(0xFF17ead9),
              //       Color(0xFF6078ea)
              //     ]),
            color: Color(CompanyColors.appbar_color),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF6078ea).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
        title: Text(
          'Patient List',
          style: TextStyle(fontSize: 16.0,color: Colors.white),
        ),
      ),
      body: ListLayout(patientList,isVisible),
    );
  }

  Widget ListLayout(List<VerifyPatinetList> patientList,bool isVisiable)
  {
    if(isVisiable)
      {
        return SafeArea(

          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: patientList.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: Patient_empty_card(
                        width: MediaQuery.of(context).size.width,
                        height: 80.0,
                        //PatientDetails: patientList.elementAt(index),
                        PatientDetails: patientList.elementAt(index),
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
          return  Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),);
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





