import 'package:flutter/material.dart';
import 'package:flutter_patient_app/AboutUs/AboutUs.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/SpecialisationAndDoctorList.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Family_Memberadd_pack/AddMember_Registration_new.dart';
import 'package:flutter_patient_app/Favourite_Doctor/Favourite_Doctor.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/Payment_pack/KKCHPayment.dart';
import 'package:flutter_patient_app/Profile/Profile.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabReport.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabReportRadiology.dart';
import 'package:flutter_patient_app/VideoCallConference/VideoCallConference_View_screen.dart';
import 'package:flutter_patient_app/ViewDocument/NewViewDocument.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleSpecialisationAndDoctorList.dart';
import 'package:flutter_patient_app/Video_Call/pages/call.dart';
import 'package:flutter_patient_app/Writes/WritesUs.dart';
import 'package:flutter_patient_app/appointment_view_new/appointment.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Visit.dart';

import 'package:flutter_patient_app/feedback_pack/Feedback_list.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:share_plus/share_plus.dart';
var titleName,Icon;
class Categories_emptycard extends StatelessWidget {


  double? width;
  double? height;
  int? position;
  VerifyPatinetList? PatientDetails;

  Categories_emptycard({
    Key? key,
    this.width,
    this.height,
    this.position,
    this.PatientDetails,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {


    titleName =  List<String>.filled(15,"");
    titleName[0]="Tele Consultation Appointment";
    titleName[1]="My Appointment";
    titleName[2]="Book Appointment";
    titleName[3]="Lab Reports";
    titleName[4]="Radiology Reports";
    titleName[5]="OP Prescription Discharge Summary";
    titleName[6]="Vital";
    titleName[7]="Diagnosis";
    titleName[8]="Favourite Doctor";
    titleName[9]="Writes Us";
    titleName[10]="About Us";
    titleName[11]="Profile";
    // titleName[11]="Feedback";
    titleName[12]="View Document";
    titleName[13]="Video Call Invitation";
    titleName[14]="ADD Member";
   // titleName[15]="Share";
    Icon =  List<String>.filled(15,"");
    Icon[0]='assets/New_Icons/tele-consultation-appointment-icon.svg';
    Icon[1]='assets/New_Icons/appointment-veiw-icon.svg';
    Icon[2]='assets/New_Icons/book-appointment-icon.svg';
    Icon[3]='assets/New_Icons/lab-reports-iconnew.png';
    Icon[4]='assets/New_Icons/radiology-icon-p.png';
    Icon[5]='assets/New_Icons/op-prescription-icon.svg';
    Icon[6]='assets/New_Icons/vital-icon.svg';
    Icon[7]='assets/New_Icons/diagnosis-icon.svg';
    Icon[8]='assets/New_Icons/fav-doctor.svg';
    Icon[9]='assets/New_Icons/icon_writeus.svg';
    Icon[10]='assets/New_Icons/aboutus-icon.svg';
    Icon[11]="assets/New_Icons/profile-icon.svg";
    // Icon[11]='assets/New_Icons/feedback.svg';
    Icon[12]='assets/New_Icons/view-doc.svg';
    Icon[13]='assets/New_Icons/video-calling-app.svg';
    Icon[14]='assets/New_Icons/profile-icon.svg';
   // Icon[15]='assets/New_Icons/video-calling-app.svg';
    return new GestureDetector(
      onTap: (){
        print("Container clicked");

        switch(titleName[position]) {
          case "Lab Reports":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LabReport( IpPatient: PatientDetails,)),
            );
            break;


          case "Radiology Reports":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LabReportRadiology( IpPatient: PatientDetails,)),
            );
            break;
          case "OP Prescription Discharge Summary":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Prescription(IpPatient: PatientDetails,)),
              // MaterialPageRoute(builder: (context) => Book_Appointment(IpPatient: IpPatient,)),

            );
            break;
          case "Book Appointment":
          // Navigator.of(context).pushNamed('/SpecialisationAndDoctorList');
          /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SpecialisationAndDoctorList()),
           // MaterialPageRoute(builder: (context) => Cross_Referral(IpPatient: IpPatient,)),
          );*/
            CommonStrAndKey.isTeleConsultFlg=false;


            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),
              // MaterialPageRoute(builder: (context) => Cross_Referral(IpPatient: IpPatient,)),
            );
            break;
          case "My Appointment":

          /*  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Appointment_View_screen(
              mobileNo: PatientDetails.mobileNo.toString(),

            )),);*/

            Navigator.push(
              context,
              MaterialPageRoute(
                  settings:
                  RouteSettings(name: "/MyBook_Appointment"),
                  builder: (context) => AppointmentList( )),

            );
            break;
          case "Tele Consultation Appointment":
          // Navigator.of(context).pushNamed('/SpecialisationAndDoctorList');
            CommonStrAndKey.isTeleConsultFlg=true;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TeleSpecialisationAndDoctorList()),
              // MaterialPageRoute(builder: (context) => Cross_Referral(IpPatient: IpPatient,)),
            );
            break;
          case "Feedback":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Feedback_Visit()),
            );
            break;
          case "Writes Us":
          /*  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WritesUs()),
          );*/
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WritesUs()),
            );
            // Navigator.of(context).pushNamed('/WritesUs');
            break;
          case "About Us":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUs()),
            );
            break;
         /* case "Share":
           // Uri myurl =Uri.parse("https://play.google.com/store/apps/details?id=com.psri_patient_app");
               Share.share("https://play.google.com/store/apps/details?id=com.psri_patient_app");
            break;*/
          case "Favourite Doctor":
            CommonStrAndKey.isTeleConsultFlg=false;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Favourite_Doctor()),
            );
            break;

          case "Vital":
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => VerticalBarLabelChart()),
              MaterialPageRoute(builder: (context) => Vital(IpPatient: PatientDetails,)),
            );
            break;
          case "Diagnosis":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Diagnosis(IpPatient: PatientDetails,)),
            );
            break;
          case "View Document":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewViewDocument(
                IpPatient: PatientDetails,
              )),
            );
            break;
          case "Profile":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile()),
            );
            // Navigator.of(context).pushNamed('/Profile');
            break;
          case "Video Call Invitation":
          /*  CommonStrAndKey.isConnecting=true;
          AppointmentListJSon  obj=new AppointmentListJSon();
          obj.doctorId=123;
          obj.doctorName="Amit";
          obj.appointmentId=321;
           Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CallPage(
                    channelName:"123456789" ,
                    AppointmentDetails: obj,
                   // channelName: "ASPL"+patientDetails.doctorId.toString().trim()+""+patientDetails.registrationNo.toString().trim(),
                  ),),
                );*/
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VideoCallConference_View_screen(
                mobileNo: PatientDetails!.registrationId.toString(),

              )),);
            break;
          case "ADD Member":
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Patient_Registration_new()),
            );
            // Navigator.of(context).pushNamed('/Profile');
            break;
          default:
          // code block
         //getContainot(position);
        }

      },


      child: getContainot(position!.toInt()),
    );
  }
  getContainot(int position) {
    return Container(
      width: width,
      height: height,
      child: new Card(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              myIcon(position),
              SizedBox(
                height: 15,
              ),
              new Center(
                child: Text(
                  titleName[position],
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Color(CompanyColors.bluegray),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget myIcon(int indexV)
  {
    if(indexV==3||indexV==4)
    {
      return  new Container(
        height: 45,
        width: 45,
        padding: new EdgeInsets.all(0.0),
        //color: Colors.green,
        child:  Image.asset(Icon[indexV]),
        //onPressed: onDelete,
      );
    }else{
      return   new SvgPicture.asset(
          Icon[indexV],
          height: 45,
          width: 45,
          fit: BoxFit.fill,


        //onPressed: onDelete,
      );
    }

  }
}
