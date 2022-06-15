import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeResponse.dart';
import 'package:flutter_patient_app/Product.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String portNamecallShop = "MyAppPortcallShop";
class CommonStrAndKey {
  static String AppointmentBookingthroughMobile="M";
  // key of Doctor Details in login time

  static  SharedPreferences? galobsharedPrefs;
  static  SharedPreferences? galobsharedPrefsInstaledApp;
  static  SharedPreferences? galobsharedPrefsVideoCallData;
  static Future<void> initializePreference() async{
    galobsharedPrefsVideoCallData = await SharedPreferences.getInstance();
  }
  static String hospital_id="hospital_id";
  static String facility_id_first="facility_id_first";
  static String facility_name_first="facility_name_first";
  static String facility_id_selected="facility_id_selected";
  static String facility_name_selected="facility_name_selected";
  static String doctor_id="doctor_id";
  static String doctor_name="doctor_name";
  static String employee_type="employee_type";
  static String employee_id="employee_id";
  static String specilaisation_of_doctor="specilaisation_of_doctor";
  static String doctor_education1="doctor_education1";
  static String doctor_education2="doctor_education2";
  static String doctor_education3="doctor_education3";
  static String consultation_charge="consultation_charge";
  static String is_superUser="is_superUser";
  static String is_team="is_team";
  static String is_admin="is_admin";
  static var selectedPatient="";
  static var selectedGraphDisplayTime="";
  static var selectedGraphDisplayFieldId="";
  static var selectedisBarLineChart="0";
  static String hospitalFlg="PSRI";
  static String  channelName1="",DoctorName1="",DoctorId1="",MyAppointmentId1="",RegistrationId1="",notificationType1=""
  ,PatientName1="",priority1="",notificationMessage1="",notificationTitle1="";

  static RemoteMessage videodata= new RemoteMessage();






  // Patient Details Key

  static String loginId="loginId";
  static String password="password";
  static String status="status";
  static String email="email";
  static String mobileNo="mobileNo";
  static String registration_no="registration_no";
  static String registration_id="registration_id";
  static String hospital_id_new="hospital_id";
  static String facility_id="facility_id";
  static String encounter_id="encounter_id";
  static String encounter_no="encounter_no";
  static String patient_name="patient_name";
  static String appointment_time="appointment_time";

  static String last_visit="last_visit";
  static String gender="gender";
  static String age="age";
  static String ward="ward";
  static String bed_id="bed_id";
  static String bed_no="bed_no";

  static String hospital_name="hospital_name";
  static String patient_image="patient_image";
  static String patient_type="patient_type";
  static String isUserExist="isUserExist";
  static String mobile_no="mobile_no";
  static String patient_status="patient_status";
  static String doctor_name_by_patient="doctor_name_by_patient";
  static String facility_id_by_patient="facility_id_by_patient";
  static String encounter_date="encounter_date";
  static String company_type="company_type";
  static String is_referred="is_referred";

  static String doctorForAppointment="";

  static bool isTeleConsultFlg=false;
  static DateTime globelDate = DateTime.now();
  static bool isConnecting=true;
  static bool isConferenceFlg=true;
  static  bool isLaunchMode=false;
  static bool videoReceivedMode=false;

  static bool enterRemark= false;

  static String IsUnRegPat="IsUnRegPat";

  //static DocumentTypeList typeOfDocDropDown;
  static var typeOfDocDropDown=null;

  static int videocallcounter=0;
  static bool mymutefalse= false;
  static bool mymutetrue= true;
  static String appstatus="first";
  static int Notificationcallcounter=0;
  static Product myCallProductdata =new Product(0,"","","","","",000,"");
  static int myCallProductdatacounter=0;

}
