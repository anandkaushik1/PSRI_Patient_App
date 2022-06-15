import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/PatientAppointmentView/AppointmentViewRequest.dart';
import 'package:flutter_patient_app/PatientAppointmentView/AppointmentViewResponse.dart';
import 'package:flutter_patient_app/PatientAppointmentView/Appointment_view_empty_card.dart';
import 'package:flutter_patient_app/VideoCallConference/ConferenceViewRequest.dart';
import 'package:flutter_patient_app/VideoCallConference/ConferenceViewResponse.dart';
import 'package:flutter_patient_app/VideoCallConference/VideoCallConference_View_empty_card.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

ConferenceViewResponse res = new ConferenceViewResponse();

String tempTypeOfSearch="";
String doctorId="", facilityId="",hospitalId="";
class VideoCallConference_View_screen extends StatefulWidget {

  final String? mobileNo;

  VideoCallConference_View_screen({
    this.mobileNo,


    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
      mobileNo:  mobileNo,


      );
}

class _CardListScreenState extends State<VideoCallConference_View_screen> {

   String? mobileNo;
  _CardListScreenState({
    this.mobileNo,

  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    res=new ConferenceViewResponse();
  }
  @override
  Widget build(BuildContext context) {


    return callBackApiResponse();
  }

  Widget callBackApiResponse()
  {
    return FutureBuilder<ConferenceViewResponse>(
      future: callApi(mobileNo.toString()), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<ConferenceViewResponse> data) {
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
            if (data.requireData.vCStatusList != null) {
              if (data.requireData.vCStatusList!.length > 0) {
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
        title: Text('Video Call Invitation',style: TextStyle(fontSize: 16.0,color: Colors.white),),
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
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pop()),

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
              itemCount: res.vCStatusList!.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: VideoCallConference_View_empty_card(
                        width: MediaQuery.of(context).size.width,
                        height: 120.0,
                        patientDetails:  res.vCStatusList!.elementAt(index),
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


}

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
      ));
}

Future<ConferenceViewResponse> callApi(String  strMobile) async {
  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  ConferenceViewRequest objddd = new ConferenceViewRequest();
  objddd.registrationId =int.parse(strMobile) ;
  objddd.hospitalLocationId=1;
  objddd.facilityId=3;
  print("Request  \n" + objddd.toJson().toString());
  ConferenceViewRequest objj =
      new ConferenceViewRequest.fromJson(objddd.toJson());
  Response<ConferenceViewResponse> responserrr =
      (await myService.AcceptVCInvitation(objj));
  var postt = responserrr.body;
  print(responserrr.body);
   res = new ConferenceViewResponse.fromJson(postt!.toJson());
  return Future.value(res);
}

String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}




