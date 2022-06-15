import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Response.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Response.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientSearchWithFiltterResponse.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'UnResigrationAppmtRequest.dart';

class PatientLstCard extends StatelessWidget {
  final double? width;
  final double? height;
  final PatientDetailsArray? IpPatient;
  final int? pos;
  final String? selectedTime;
  final String? selectedDate;

  const PatientLstCard({
    Key? key,
    this.width,
    this.height,
    this.IpPatient,
    this.pos,
    this.selectedTime,
    this.selectedDate,
  }) : super(key: key);




  @override
  Widget build(BuildContext context) {




    return new GestureDetector(
      onTap: () {
        print("Container clicked");
  /*      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Categroies()),
        );*/
        _ConformationOfAppointment(selectedDate!,selectedTime!,context);
      },
      child: Container(
          width: width,
          height: height,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            /*  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,*/
            children: <Widget>[

              new Row(
                children: <Widget>[
                  Expanded(
                    flex: 15, // color: Colors.green,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      child:new Container(
                          alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 2),
                      child :  new SvgPicture.asset(
                          'assets/icons/male_icon.svg',
                          height: 40,
                          width: 20,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Expanded(

                      flex: 70,

                      child: GestureDetector(

                        onTap: ()
                          {
                            /*print("Container clicked");
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Categroies(
                                  IpPatient: IpPatient,
                                  pos: pos,
                                )));*/
                          },
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            IpPatient!.patientName.toString(),
                            style: TextStyle(
                                color:  Color(0xff5056ca),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          new Text(
                            IpPatient!.gender.toString() ,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                            maxLines: 1,
                          ),
                          new Text(
                            "UHID :" +
                                IpPatient!.registrationNo.toString() +
                                " | " +
                                IpPatient!.mobileNo.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                          ),

                        ],
                      )),),
                  /*Expanded(
                      flex: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[

                             new Container(
                              child: new Image.asset(
                                'assets/icons/ipd-patient.svg',
                                height: 17,
                                width: 17,
                                fit: BoxFit.fill,
                              ),
                              margin: const EdgeInsets.only(bottom: 20.0),
                            ),
                          new GestureDetector(
                         child : new Container(
                            child: new SvgPicture.asset(
                              'assets/images/call_icon.svg',
                              height: 25,
                              width: 25,
                              fit: BoxFit.fill,
                            ),
                          ),
                            onTap: ()
                            {
                              _launchCaller(IpPatient.mobileNo.trim());
                            },
                          ),
                        ],
                      )),*/
                ],
              ),
            ],
          )),

    );


  }


  Future<void> getPatientDetails(String registrationNo,BuildContext context) async {
   /// _onLoading(context);
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Get_Patient_Details_Request setObj=new Get_Patient_Details_Request();
    setObj.registrationNo=""+registrationNo;
    // setObj.facilityID=""+CommonStrAndKey.galobsharedPrefs .getString(CommonStrAndKey.facility_id_first) ?? '';
    Get_Patient_Details_Request obj=new Get_Patient_Details_Request.fromJson(setObj.toJson());
    Response<Get_Patient_Details_Response> response = (await myService.MobGetPatientDetailsByRegistrationNo(obj));
    print(response.body);
    var post = response.body;
    if(response!=null)
    {
      if(response.body!.status.toString().toLowerCase()=="success")
      {

        if(response.body!.patientDetailsArray!=null&&response.body!.patientDetailsArray!.length!=0) {
          bookAppointment(response.body!.patientDetailsArray!.elementAt(0), context);

        }else {
           Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("" + post!.msg.toString()),
          ));
        }
      }
    }

  }

  Future bookAppointment(PatientDetailsArrayApmt selectedData,BuildContext context) async {


    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    New_Book_Appointment_Request setObj=new New_Book_Appointment_Request();
    setObj.hospitalLocationId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
    setObj.facilityID=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id_first) ?? '';
    setObj.doctorId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_id) ?? '';
    setObj.registrationNo=""+selectedData!.registrationNo.toString();
    setObj.appointmentDate=""+selectedDate!;
    setObj.appFromTime=""+selectedTime!;
    setObj.appToTime=""+selectedTime!;
    setObj.fullName=""+IpPatient!.patientName.toString().trim();
    setObj.titleId=""+selectedData!.titleId.toString();
    setObj.dOB=""+selectedData!.dOB.toString();
    String gander=selectedData.patientAgeGender.toString();
    String valueOfGander="1";
    if(gander.toLowerCase().contains("female"))
      {
        valueOfGander="2";
      }else
        {
          valueOfGander="1";
        }
    setObj.gender=valueOfGander;
    setObj.email=""+selectedData.email.toString();
    setObj.ageYear="0";
    setObj.ageMonth="0";
    setObj.ageDay="0";
    setObj.remarks="Remarks";
    setObj.mobile=""+selectedData.mobile.toString();
    setObj.authorizationNo="0";
    setObj.paymentModeId="0";
    setObj.visitTypeId="1";
    setObj.packageId="0";
    //setObj.appointmentSource=""+CommonStrAndKey.AppointmentBookingthroughMobile;


    New_Book_Appointment_Request obj=new New_Book_Appointment_Request.fromJson(setObj.toJson());
    Response<New_Book_Appointment_Response> response = (await myService.MobSaveAppointment(obj));
    print(response.body);
    var post = response.body;
    if(response!=null)
    {
      if(response.body!.status.toString().toLowerCase()=="success"||response.body!.status.toString().toLowerCase()=="true")
      {
        Navigator.pop(context);
        if(response.body!=null) {
          _ConformationMsg(response.body!.errorMessage.toString(),context);
        }else {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("" + post!.errorMessage.toString()),
          ));
        }
      }
    }

  }



  void _ConformationOfAppointment(String date ,String time,BuildContext context)  {
     showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Date "+date+" "+time),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            FlatButton(
              child: Text('Book Now'),
              onPressed: () async{
               // Navigator.of(context).pop();
               // getPatientDetails(IpPatient.registrationNo, context);

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });
                  await getPatientDetails(IpPatient!.registrationNo.toString(), context);
                  Navigator.pop(context);

              },
            ),
          ],
        );
      },
    );
  }

 void _ConformationMsg(String regId,BuildContext context)  {
     showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(""+regId),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

               /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (mContext) => Dashbroad()),
                );*/
                ///Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  _launchCaller(String mobileNo) async {
    var mob = "tel:" + mobileNo;
    //url = mob;
    if (await canLaunch(mob)) {
      await launch(mob);
    } else {
      throw 'Could not launch $mob';
    }
  }

  Future<void> _onLoading(BuildContext context) async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
  }
}
