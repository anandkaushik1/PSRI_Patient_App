import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/Project_View/Patient_Medication/Medication_List.dart';
import 'package:flutter_patient_app/Project_View/Patient_Medication/Medication_Response.dart';
import 'package:flutter_patient_app/Project_View/Patient_Medication/Medication_Resquest.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


Medication_Response res=new Medication_Response();
 /*String encounterNo="";
 VisitHistory visit;*/
class Medication_Card_List extends StatefulWidget {

  PatientDetailsArray? IpPatient;
  Medication_Card_List({
  Key? key,
  this.IpPatient,

  }) : super(key: key);


  @override
  _CardListScreenState createState() => _CardListScreenState(IpPatient: IpPatient);
}

class _CardListScreenState extends State<Medication_Card_List> {
  PatientDetailsArray? IpPatient;
  _CardListScreenState({

    this.IpPatient,

  });
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Medication_Response>(
      future: callApiMedication( ""), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Medication_Response> data) {  // AsyncSnapshot<Your object type>
        if( data.connectionState == ConnectionState.waiting){
          return Loading(context);
        }else{
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                )
            );
          else {
            bool validData = false;
            if (data.requireData != null) {
              if (data.requireData.currentPatientMedicationArray != null) {
                if (data.requireData.currentPatientMedicationArray!.length > 0) {
                  validData = true;
                }
              }
            }
            if (validData) {
              return layout(context);
            }else
              {
                return new Visibility(
                  visible: false,
                  child: new Text(""),
                );
              }
          }
        }
      },
    );

  }
  Future<Medication_Response>  callApiMedication(String data)
  async {
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Medication_Resquest objddd=new Medication_Resquest();
    /*{"EncounterId":"1478996","FacilityId":"2","FromDate":"1900-01-01 00:00","HospitalId":"1",
  "LabType":"LIS","OPIP":"O","RegistrationId":"675347","Todate":"2079-01-01 23:59"}*/
    /* objddd.encounterId=data.encounterId;
  objddd.hospitalId=data.hospitalId;
  objddd.facilityId="2";
  objddd.registrationId=data.registrationId;
  objddd.fromDate="1900-01-01 00:00";
  objddd.todate="2079-01-01 23:59";
  objddd.oPIP=""+data.oPIP;
  objddd.labType="LIS";*/

    // {"EncounterId":"1480974","FacilityId":"2","FromDate":"","HospitalLocationId":"1","RegistrationId":"675347","ToDate":""}

    objddd.encounterId=""+IpPatient!.encounterId.toString();
    objddd.hospitalLocationId="1";
    objddd.facilityId="2";
    objddd.registrationId=""+IpPatient!.registrationId.toString();
    objddd.fromDate="";
    objddd.toDate="";
    print("Request  \n" + objddd.toJson().toString());
    Medication_Resquest objj=new Medication_Resquest.fromJson(objddd.toJson());
    Response<Medication_Response> responserrr = (await myService.PatientMedication(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res=new Medication_Response.fromJson(postt!.toJson());
    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
      ));;
}

Widget layout(BuildContext context)
{
  return Scaffold(
    appBar: AppBar(
      title: Text('Current Medication',style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,),
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop()),
    ),
    backgroundColor: Colors.white,
    body: SafeArea(
      child: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: res.currentPatientMedicationArray!.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 44.0,
                child: FadeInAnimation(
                  child: Medication_List(
                      width: MediaQuery.of(context).size.width,
                      height: 88.0,
                    MedicationResult:res.currentPatientMedicationArray!.elementAt(index),
                      pos: index,

                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}


/*
Medication_Response
Medication_Resquest*/
