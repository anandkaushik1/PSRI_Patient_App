import 'package:shared_preferences/shared_preferences.dart';

class CommonStrAndKey {

  static  SharedPreferences? galobsharedPrefs;
  // basic info
  static String myID="my_id";
  static String myName="my_name";
  static String myEmail="my_email";
  static String myGender="my_gender";
  static String myMobileNo="my_mobile";
  static String MyAddress="my_address";
  static String MyAge="my_age";
  static String myDOB="my_dob";
  static String myIdentity="my_identity";
  static String myRegistrationId="my_registration_id";
  static String myRegistrationNo="my_registration_no";
  // basic info


  // address info
  static String myAddress="my_address";
  static String myStateNCity="my_state_city";
  static String myPincode="my_pincode";
  static String myLandMark="my_landmark";
  static String myAddressAvailability="false";
  // address info

  static int cartCounter=0;
  static String mySearchValueNew="",mySearchValueNewForHome="";
  static String mySearchValueNewForOrder="";
  static String myCartCounter="1";

  static bool isOtc=true;

  static var selectedPatient;
}
