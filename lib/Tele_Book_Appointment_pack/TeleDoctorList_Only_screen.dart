import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/doctorCard_sepecial.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/PatientOther_Class/FavDoctorRequest.dart';
import 'package:flutter_patient_app/PatientOther_Class/FavDoctorResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeledoctorCard_sepecial.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

FavDoctorResponse res = new FavDoctorResponse();

String tempTypeOfSearch="";
String doctorId="", facilityId="",hospitalId="";
class TeleDoctorList_Only_screen extends StatefulWidget {

  final String? DeptId;

  TeleDoctorList_Only_screen({
    this.DeptId,


    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
      DeptId: DeptId,


      );
}

class _CardListScreenState extends State<TeleDoctorList_Only_screen> {

   String? DeptId;
  _CardListScreenState({
    this.DeptId,

  });

  @override
  Widget build(BuildContext context) {


    return callBackApiResponse();
  }

  Widget callBackApiResponse()
  {
    return FutureBuilder<FavDoctorResponse>(
      future: callApi(DeptId.toString()), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<FavDoctorResponse> data) {
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
            if (data.requireData.getDoctorListArrayy != null) {
              if (data.requireData.getDoctorListArrayy!.length > 0) {
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
        title: Text('Doctor List',style: TextStyle(fontSize: 16.0),),

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
              itemCount: res.getDoctorListArrayy!.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      child: TeledoctorCard_sepecial(
                        MediaQuery.of(context).size.width, 56.0,
                        res.getDoctorListArrayy!.elementAt(index),
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

Future<FavDoctorResponse> callApi(String  strDept) async {
  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  FavDoctorRequest objddd = new FavDoctorRequest();
  objddd.departmentId = strDept;
  objddd.hospitalLocationId="";
  objddd.mobileno="";
  objddd.parameterType="S";
  objddd.tCDoctor=CommonStrAndKey.isTeleConsultFlg.toString();
  FavDoctorRequest objj =
      new FavDoctorRequest.fromJson(objddd.toJson());
  Response<FavDoctorResponse> responserrr =
      (await myService.MobGetDoctorList(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new FavDoctorResponse.fromJson(postt!.toJson());
  return Future.value(res);
}

String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}




