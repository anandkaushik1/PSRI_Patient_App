import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Doctor_list_empty_card.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorRequest.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/doctorCard.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Specialisation_list_empty_card.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';

import 'package:intl/intl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatient.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Model/ListofSpecialisationRequest.dart';
import 'empty_card.dart';

ListofDoctorResponse res = new ListofDoctorResponse();

String tempTypeOfSearch="";
String doctorId="", facilityId="",hospitalId="";
class DoctorList_card_list_screen extends StatefulWidget {



  DoctorList_card_list_screen({

    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(

      );
}

class _CardListScreenState extends State<DoctorList_card_list_screen> {



 /* _CardListScreenState({

  });*/

  @override
  Widget build(BuildContext context) {


    return callBackApiResponse();
  }

  Widget callBackApiResponse()
  {
    return FutureBuilder<ListofDoctorResponse>(
      future: callApi(), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<ListofDoctorResponse> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                )
            );
          else if (data.requireData.status!.toString().toLowerCase() == "success") {
            if (data.requireData.doctorList != null) {
              if (data.requireData.doctorList!.length > 0) {
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
              itemCount: res.doctorList!.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: DoctorCard(
                         MediaQuery.of(context).size.width,
                          56.0,
                          res.doctorList!.elementAt(index),
                         index,
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


}

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
      ));
}

Future<ListofDoctorResponse> callApi() async {
  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  ListofDoctorRequest objddd = new ListofDoctorRequest();
  NameValuePairs subObj=new NameValuePairs();
  subObj.specializationId="0";
  objddd.nameValuePairs = subObj;
  ListofDoctorRequest objj =
      new ListofDoctorRequest.fromJson(objddd.toJson());
  Response<ListofDoctorResponse> responserrr =
      (await myService.MobDoctorList(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new ListofDoctorResponse.fromJson(postt!.toJson());
  return Future.value(res);
}

String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}




