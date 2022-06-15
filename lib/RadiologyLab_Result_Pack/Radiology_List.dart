import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitRequestRadio.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitResponseRadio.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/RadioLogyListCard.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';


LabVisitResponseRadio res = new LabVisitResponseRadio();

String tempTypeOfSearch="";
String doctorId="", facilityId="",hospitalId="";
class Radiology_List extends StatefulWidget {

  PatientDetailsArray? IpPatient;


  Radiology_List({
    Key? key,
    this.IpPatient,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(IpPatient: IpPatient);
}

class _CardListScreenState extends State<Radiology_List> {
  PatientDetailsArray? IpPatient;


   _CardListScreenState({
     this.IpPatient,
  });

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
    return FutureBuilder<LabVisitResponseRadio>(
      future: callApi(IpPatient!), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<LabVisitResponseRadio> data) {
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
            if (data.requireData.visitHistory != null) {
              if (data.requireData.visitHistory!.length > 0) {
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
            Navigator.of(context).pop();
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
          'Radiology Reports \n '+IpPatient!.patientName!.toString(),
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
            itemCount: res.visitHistory!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: RadioLogyListCard(
                      width: MediaQuery.of(context).size.width,
                      height: 80.0,
                      PatientDetails: res.visitHistory!.elementAt(index),
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

}

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(CompanyColors.appbar_color)
      ));
}

Future<LabVisitResponseRadio> callApi(PatientDetailsArray IpPatient) async {

  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  LabVisitRequestRadio objddd = new LabVisitRequestRadio();
  String mobile=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.mobileNo)??"";
  //objddd.registrationNo = "342904";
  objddd.registrationNo = ""+IpPatient.registrationNo.toString();

  LabVisitRequestRadio objj =
  new LabVisitRequestRadio.fromJson(objddd.toJson());
  Response<LabVisitResponseRadio> responserrr =
  (await myService.GetInvestigationVisitRadio(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new LabVisitResponseRadio.fromJson(postt!.toJson());
  return Future.value(res);
}




