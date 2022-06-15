// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_service_post.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************
// venk live
//String token ='bearer 1t7MPzJwgHToaerRf6MRoQ5Iio6seeIqkxysir19LZuwkThZfN8jH6lAbJjaIWnGK86xrY9Fdv5QG3xpwk3lN2qjxZ3SRFTK4RxYpKygRZeKxVJE42D4Kr0jW1A4nqpBrS3kmaTulB64YhfcYVgkwbZCr0jNSDnn4dwGN1e9v1w0MxYCbQ3bJCZxNfmRLd2s-pB4qzI_GREUBbMo5KIz6GNG0ZC0HmNrKBlxf1HuhXWANtj0CAW6Xv2Pf3_8r8I0wDRLA8u-_uxAq-h2FcdfvcB-ulrIjhIZeeQtgZ7g01c';
// blk live
//String token ='bearer qcWymbKbSOqidqoqvlSxN1lbib2w0yiTUCcuRBhU92wXiAODd11YqD-C1qAaVq2SWAmHBCy24eVGSa5mQ4K4_04gYvc_jMOmRYpNDGQnvZ8iU1M9gAUtC1QpHkV31mFiOzV6d2MJm1U40YeWjJXOb32r1G6uPjsLmw-0WcCZBecZds2tklc8iTNr19qr1F_wCyf3ePwPo1CSsbgXoF12IQWF-rBx8MDY4U20NLb2C52DWAg4CC2zBCaKSaJtyBWfKwU9Ki8ehNISII_FisOG7UvONSGr1e3ZlhTkzJ971vM';
//blk uat
 String token ='bearer Jb62e70XdvEAv1m4Gcs36uI7fK7sXbP_dPKsvx4r8ahdfY6EWfSSGE-U66ljVhkwT46_Ih8QaxnW9BexhQCJ0Ow1vRyAaSr5QPkoXw5m65tKymyo0pNIXdsmWukdh3K3O-Vx5O0EUHf-0bfnoj6sbOzKa7Imv-Vfrd70bhaiI6sZSuT60-is-sm9N2Jes3fGh7cEwHz6kANIBhCVskYVGzwDzByc3bDaY5kr4xiDhA2cS6C5UM8S9jVgFJfKb7EVuDfhN8SruH6QZWqCVOV-ntHul4xRFflJCD4IQHT4znA';

 void getData() async
{
 /* final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  String myAccessToken=sharedPrefs.getString("accessToken") ?? 'not find';
   dynamicToken=myAccessToken;
  token=dynamicToken;*/
}
class _$MyServicePost extends MyServicePost {

  _$MyServicePost([ChopperClient? client]) {
    token=Splash.dynamicToken;
    if (client == null) return;
    this.client = client;

  }

  final definitionType = MyServicePost;


  @override
  Future<Response<Login_response>> LoginApi(login_model resource) {
    final $url = '/ValidateUserlogin';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Login_response, Login_response>($request);
  }


  @override
  Future<Response<ListOfIpPatientResponse>> PatirentBydoctorApi(
      ListOfIpPatientResquest resource) {
    // TODO: implement PatientListDoctorwise
    final $url = '/PatientListDoctorwise';
     final $headers = {
       'Authorization': token,

      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ListOfIpPatientResponse, ListOfIpPatientResponse>(
        $request);
  }

  Future<Response<TokenModel>> tokenForS(String str) {
    // TODO: implement token
    Map<String, dynamic> jsonMap = {
      'UserName': 'user',
      'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q=',
      'grant_type': 'password'
    };

    String jsonString = json.encode(jsonMap); // encode map to json
    String paramName = 'param'; // give the post param a name
    String formBody = paramName + '=' + Uri.encodeQueryComponent(jsonString);
    List<int> bodyBytes = utf8.encode(formBody);
    final $url = '/token';
    final $headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };
    final $body = Uri.encodeQueryComponent(jsonString);

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TokenModel, TokenModel>(
        $request);
  }


  @override
  Future<Response<ListOfAppointmentResponse>> AppointmentSchedule(
      ListOfAppointmentRequest resource) {
    // TODO: implement AppointmentSchedule
    final $url = '/AppointmentSchedule';
    // live
     final $headers = {
       'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ListOfAppointmentResponse, ListOfAppointmentResponse>(
        $request);
  }

  // labview
  @override
  Future<Response<LabVisitResponse>> GetInvestigationVisit(
      LabVisitRequest resource) {
    // TODO: implement GetInvestigationVisit
    final $url = '/GetInvestigationVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<LabVisitResponse, LabVisitResponse>($request);
  }

  @override
  Future<Response<LabVisitResponseRadio>> GetInvestigationVisitRadio(
      LabVisitRequestRadio resource) {
    // TODO: implement GetInvestigationVisit_Radiology
    final $url = '/GetInvestigationVisit_Radiology';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<LabVisitResponseRadio, LabVisitResponseRadio>($request);
  }


  @override
  Future<Response<Lab_Report_Response>> PatientLabInfo(
      Lab_Report_Request resource) {
    // TODO: implement PatientLabInfo
    final $url = '/PatientLabInfo';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Lab_Report_Response, Lab_Report_Response>($request);
  }


  @override
  Future<Response<Lab_Details_Response>> PatientLabInfoDetails(
      Lab_Details_Request resource) {
    // TODO: implement PatientLabInfoDetails
    final $url = '/PatientLabInfoDetails';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Lab_Details_Response, Lab_Details_Response>($request);
  }





  @override
  Future<Response<Lab_Garph_View_Response>> LabResultGraph(
      Lab_Garph_View resource) {
    // TODO: implement LabResultGraph
    final $url = '/LabResultGraph';

    final $headers = {
      'Authorization': token ,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Lab_Garph_View_Response, Lab_Garph_View_Response>(
        $request);
  }

  @override
  Future<Response<Lab_GraphView_Field_Response>> LabResultGraphField(
      Lab_GraphView_Field resource) {
    // TODO: implement LabResultGraphField
    final $url = '/LabResultGraphField';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Lab_GraphView_Field_Response, Lab_GraphView_Field_Response>(
        $request);
  }

  @override
  Future<Response<Vital_Visit_Response>> GetVitalVisit(Vital_Visit_Request resource) {
    // TODO: implement GetVitalVisit
    final $url = '/GetVitalVisit';

    final $headers = {
      'Authorization': token ,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Vital_Visit_Response, Vital_Visit_Response>($request);
  }
  /////
  @override
  Future<Response<Vital_Response>> PatientvitalDetail(Vital_Request resource) {
    // TODO: implement PatientvitalDetail
    final $url = '/PatientvitalDetail';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Vital_Response, Vital_Response>($request);
  }
  @override
  Future<Response<Vital_Graph_Response>> VitalGraph(Vital_Graph_Request resource) {
    // TODO: implement VitalGraph
    final $url = '/VitalGraph';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Vital_Graph_Response, Vital_Graph_Response>($request);
  }
  @override
  Future<Response<Vital_Graph_Sign_Response>> GetVitalSignName(Vital_Graph_Sign_Request resource) {
    // TODO: implement GetVitalSignName
    final $url = '/GetVitalSignName';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request = Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Vital_Graph_Sign_Response, Vital_Graph_Sign_Response>($request);
  }

  @override
  Future<Response<Medication_Response>> PatientMedication(Medication_Resquest resource) {
    // TODO: implement PatientMedication
    final $url = '/PatientMedication';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Medication_Response, Medication_Response>($request);
  }

  Future<Response<Diagnosis_Visit_Response>> DiagnosisVisit(Diagnosis_Visit_Request resource) {
    // TODO: implement DiagnosisVisit
    final $url = '/DiagnosisVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Diagnosis_Visit_Response, Diagnosis_Visit_Response>($request);
  }

  Future<Response<Diagnosis_Response>> PatientDiagnosis(Diagnosis_Request resource) {
    // TODO: implement PatientDiagnosis
    final $url = '/PatientDiagnosis';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Diagnosis_Response, Diagnosis_Response>($request);
  }


  Future<Response<Cross_Referral_Visit_Response>> GetReferralVisit(Cross_Referral_Visit_Request resource) {
    // TODO: implement GetReferralVisit
    final $url = '/GetReferralVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Cross_Referral_Visit_Response, Cross_Referral_Visit_Response>($request);
  }

  Future<Response<Referral_Details_Response>> GetReferralDetails(Referral_Details_Request resource) {
    // TODO: implement ReferralDetails
    final $url = '/ReferralDetails';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Referral_Details_Response, Referral_Details_Response>($request);
  }


  Future<Response<Discharge_Summary_Response>> GetPatientDischargeSummary(Discharge_Summary_Request resource) {
    // TODO: implement GetPatientDischargeSummary
    final $url = '/GetPatientDischargeSummary';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Discharge_Summary_Response, Discharge_Summary_Response>($request);
  }


  Future<Response<Prescription_Full_Data_Response>> GetPatientCashsheet(Prescription_Full_Data_Request resource) {
    // TODO: implement GetPatientCashsheet
    final $url = '/GetPatientCashsheet';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Prescription_Full_Data_Response, Prescription_Full_Data_Response>($request);
  }

  Future<Response<VisitHistoryResponse>> MobGetVisitHistory(VisitHistoryRequest resource) {
    // TODO: implement MobGetVisitHistory
    final $url = '/MobGetVisitHistory';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<VisitHistoryResponse, VisitHistoryResponse>($request);

//    Diagnosis_Visit_Request
//    Diagnosis_Visit_Response
  }
  Future<Response<Diagnosis_Visit_Response>> GetDiagnosisVisit(Diagnosis_Visit_Request resource) {
    // TODO: implement GetDiagnosisVisit
    final $url = '/GetDiagnosisVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Diagnosis_Visit_Response, Diagnosis_Visit_Response>($request);

  }



  Future<Response<Remarks_Response>> UpdateRemakrsData(Remarks_Request resource) {
    // TODO: implement GetDiagnosisVisit
    final $url = '/UpdateAppointmentRemarks';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Remarks_Response, Remarks_Response>($request);

  }



  Future<Response<PatientSearchWithFiltterResponse>> GetRegisteredPatientList(PatientSearchWithFiltterRequest resource) {
    // TODO: implement GetRegisteredPatientList
    final $url = '/GetRegisteredPatientList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<PatientSearchWithFiltterResponse, PatientSearchWithFiltterResponse>($request);

  }
  Future<Response<UnResigrationAppmtResponse>> SaveAppointmentUnRegisteredPatient(UnResigrationAppmtRequest resource) {
    // TODO: implement SaveAppointmentUnRegisteredPatient
    final $url = '/SaveAppointmentUnRegisteredPatient';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UnResigrationAppmtResponse, UnResigrationAppmtResponse>($request);

  }

  @override
  Future<Response<Appmt_Slot_Response>> MobGetDoctorWiseSlot(Appmt_slot_Request resource) {
    // TODO: implement MobGetDoctorWiseSlot
    final $url = '/MobGetDoctorWiseSlot';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Appmt_Slot_Response, Appmt_Slot_Response>($request);
  }

  @override
  Future<Response<SensitivityResponse>> SensitivityDetails(SensitivityRequest resource) {
    // TODO: implement SensitivityDetails
    final $url = '/SensitivityDetails';

    final $headers = {
      'Authorization':token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<SensitivityResponse, SensitivityResponse>($request);
  }
  @override
  Future<Response<Get_Patient_Details_Response>> MobGetPatientDetailsByRegistrationNo(Get_Patient_Details_Request resource) {
    // TODO: implement MobGetPatientDetailsByRegistrationNo
    final $url = '/MobGetPatientDetailsByRegistrationNo';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Get_Patient_Details_Response, Get_Patient_Details_Response>($request);
  }

  @override
  Future<Response<New_Book_Appointment_Response>> MobSaveAppointment(New_Book_Appointment_Request resource) {
    // TODO: implement MobSaveAppointment
    final $url = '/MobSaveAppointment';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<New_Book_Appointment_Response, New_Book_Appointment_Response>($request);
  }
  /// patient App Api

  @override
  Future<Response<PatientLoginResponse>> MobPatientLogin(PatientLoginRequest resource) {
    // TODO: implement MobPatientLogin
    final $url = '/MobPatientLogin';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<PatientLoginResponse, PatientLoginResponse>($request);
  }



  @override
  Future<Response<ForgetPasswordResponse>> MobForgatePassword(ForgetPasswordRequest resource) {
    // TODO: implement MobForgatePassword
    final $url = '/MobForgatePassword';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ForgetPasswordResponse, ForgetPasswordResponse>($request);
  }

  @override
  Future<Response<OTPResponse>> GenerateOTPForSignup(OTPRequest resource) {
    // TODO: implement GenerateOTPForPatient
    final $url = '/GenerateOTPForSignup';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<OTPResponse, OTPResponse>($request);
  }

  @override
  Future<Response<AddMemberOTPResponse>> GenerateOTPForFamily(AddMemberOTPRequest resource) {
    // TODO: implement GenerateOTPForPatient
    final $url = '/GenerateOTPForSignup';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AddMemberOTPResponse, AddMemberOTPResponse>($request);
  }


  @override
  Future<Response<NewRegistrationResponse>> MobSaveRegistrationForPatient(NewRegistrationRequest resource) {
    // TODO: implement MobSaveRegistrationForPatient
    final $url = '/MobSaveRegistrationForPatient';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<NewRegistrationResponse, NewRegistrationResponse>($request);
  }


  @override
  Future<Response<AddMemberResponse>> MobSaveRegistrationForFamily(AddMemberRequest resource) {
    // TODO: implement MobSaveRegistrationForPatient
    final $url = '/MobSaveRegistrationForPatient';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AddMemberResponse, AddMemberResponse>($request);
  }



  @override
  Future<Response<ListofSpecialisationResponse>> MobSpecialisationList(ListofSpecialisationRequest resource) {
    // TODO: implement MobSpecialisationList
    final $url = '/MobSpecialisationList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = "";
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ListofSpecialisationResponse, ListofSpecialisationResponse>($request);
  }
  @override
  Future<Response<TeleListofSpecialisationResponse>> TeleMobSpecialisationList(TeleListofSpecialisationRequest resource) {
    // TODO: implement MobSpecialisationList
    final $url = '/MobSpecialisationList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TeleListofSpecialisationResponse, TeleListofSpecialisationResponse>($request);
  }
  @override
  Future<Response<ListofDoctorResponse>> MobDoctorList(ListofDoctorRequest resource) {
    // TODO: implement MobDoctorList
    final $url = '/MobDoctorList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ListofDoctorResponse, ListofDoctorResponse>($request);
  }
  @override
  Future<Response<FavDoctorResponse>> MobGetDoctorList(FavDoctorRequest resource) {
    // TODO: implement MobGetDoctorList
    final $url = '/MobGetDoctorList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<FavDoctorResponse, FavDoctorResponse>($request);
  }

  @override
  Future<Response<DeleteAppointmentResponse>> MobCancelAppointment(DeleteAppointmentRequest resource) {
    // TODO: implement MobCancelAppointment
    final $url = '/MobCancelAppointment';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<DeleteAppointmentResponse, DeleteAppointmentResponse>($request);
  }

  @override
  Future<Response<AppointmentViewResponse>> MobGetAppointmentList(AppointmentViewRequest resource) {
    // TODO: implement MobGetAppointmentList
    final $url = '/MobGetAppointmentList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<AppointmentViewResponse, AppointmentViewResponse>($request);
  }
  @override
  Future<Response<PatientProfileUpdateResponse>> MobPatientProfile(PatientProfileUpdate resource) {
    // TODO: implement MobPatientProfile
    final $url = '/MobPatientProfile';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<PatientProfileUpdateResponse, PatientProfileUpdateResponse>($request);
  }

  @override
  Future<Response<LastVisitResponse>> LastVisit(LastVisitRequest resource) {
    // TODO: implement MobPatientProfile
    final $url = '/LastVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<LastVisitResponse, LastVisitResponse>($request);
  }
  @override
  Future<Response<Feedback_Response>> GetPatientFeedback(Feedback_Request resource) {
    // TODO: implement MobPatientProfile
    final $url = '/GetPatientFeedback';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<Feedback_Response, Feedback_Response>($request);
  }
  @override
  Future<Response<WriteUsResponse>> SaveWriteUs(WritesUsRequest resource) {
    // TODO: implement MobPatientProfile
    final $url = '/SaveWriteUs';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<WriteUsResponse, WriteUsResponse>($request);
  }

  @override
  Future<Response<TeleFavDoctorResponse>> TeleMobDoctorList(TeleFavDoctorRequest resource) {
    // TODO: implement MobDoctorList
    final $url = '/MobDoctorList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TeleFavDoctorResponse, TeleFavDoctorResponse>($request);
  }

  @override
  Future<Response<UploadDocumentResponse>> SavePatientDocumentNew(UploadDocumentRequest resource) {
    // TODO: implement SaveTeleConsultationDocument
    final $url = '/SaveTeleConsultationDocument';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UploadDocumentResponse, UploadDocumentResponse>($request);
  }
  @override
  Future<Response<TeleNew_Book_Appointment_Response>> TeleMobSaveAppointment(TeleNew_Book_Appointment_Request resource) {
    // TODO: implement TeleMobSaveAppointment
    final $url = '/MobSaveAppointment';

    final $headers = {
      'Authorization': token,
    'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<TeleNew_Book_Appointment_Response, TeleNew_Book_Appointment_Response>($request);
  }

  @override
  Future<Response<SaveFeedbackResponseModel>> SavePatientFeedback(String resource) {
    final $url = '/SavePatientFeedback';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final bodyfor = json.decode(resource);
    final $body = bodyfor;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<SaveFeedbackResponseModel, SaveFeedbackResponseModel>($request);
  }

  @override
  Future<Response<LoginResponseOTP>> GenerateOTPForPatientOTP(LoginRequestOTP resource) {

      final $url = '/GenerateOTPForPatient';
      final $headers = {
        'Authorization': token,
        'Content-Type': 'application/json'
      };
      final $body = resource;

      final $request =
      Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

      return client.send<LoginResponseOTP, LoginResponseOTP>($request);

  }

  @override
  Future<Response<VerifyOtpResponseOTP>> VerifyPatientOTP(VerifyOtpRequestOTP resource) {
    final $url = '/VerifyPatientOTP';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<VerifyOtpResponseOTP, VerifyOtpResponseOTP>($request);
  }

  @override
  Future<Response<TeleAppmt_Slot_Response>> TeleMobGetDoctorWiseSlot(TeleAppmt_Slot_Request resource) {
    final $url = '/MobGetDoctorWiseSlot';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<TeleAppmt_Slot_Response, TeleAppmt_Slot_Response>($request);
  }



  @override
  Future<Response<titleIDList_Response>> getTitleList(titleIDList_Resquest resource) {
    final $url = '/GetTitle';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<titleIDList_Response, titleIDList_Response>($request);
  }


 // PatientList_Request

  // PatientList_Response

 // http://182.75.170.98:210/api/PatientApp/


 /* @override
  Future<Response<VerifyOtpResponseOTP>> GetPatientList(PatientList_Request resource) {
    final $url = '/GetPatientList';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<VerifyOtpResponseOTP, VerifyOtpResponseOTP>($request);
  }*/
  @override
  Future<Response<VerifyOtpResponseOTP>> GetPatientList(VerifyOtpRequestOTP resource) {
    final $url = '/GetPatientList';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<VerifyOtpResponseOTP, VerifyOtpResponseOTP>($request);
  }

  @override
  Future<Response<Favourite_Doctor_Response>> FavouriteDOctor(Favourite_Doctor_Request resource) {
    final $url = '/MobGetDoctorList';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<Favourite_Doctor_Response, Favourite_Doctor_Response>($request);

  }

  @override
  Future<Response<ViewAppointmentResponse>> AppointmentList(
      ViewAppointmentRequest resource) {
    // TODO: implement MobGetAppointmentList
    final $url = '/MobGetAppointmentList';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client
        .send<ViewAppointmentResponse, ViewAppointmentResponse>($request);
  }


  @override
  Future<Response<RescheduleAppointmentResponse>> ReschedulePatientAppointment (
      RescheduleAppointmentRequest resource) {
    // TODO: implement PatientLabInfo
    final $url = '/ReschedulePatientAppointment';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<RescheduleAppointmentResponse, RescheduleAppointmentResponse>($request);
  }

  @override
  Future<Response<UploadedDocResponse>> appointmentViewDoc(
      UploadedDocRequest resource) {
    final $url = '/GetUploadedDocument';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);


    print('Url ========== ${$url}');

    return client.send<UploadedDocResponse, UploadedDocResponse>($request);
  }

  @override
  Future<Response<viewDocumentResponse>> viewDocumentVisits(
      viewDocumentRequest resource) {
    // TODO: implement PatientLabInfo
    final $url = '/GetUploadedDocVisit';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<viewDocumentResponse, viewDocumentResponse>($request);
  }


  @override
  Future<Response<DocumnetList_Response>> DcoumentListData (
      DocumnetList_Request resource) {
    // TODO: implement PatientLabInfo
    final $url = '/GetUploadedDocument';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<DocumnetList_Response, DocumnetList_Response>($request);
  }


  @override
  Future<Response<VIdeoCallResponse>> VCStatus(VIdeoCallRequest resource) {
    // TODO: implement VCStatus
    final $url = '/VCStatus';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<VIdeoCallResponse, VIdeoCallResponse>($request);
  }

  @override
  Future<Response<SendInivitationVCResponse>> SendVCInvitation(SendInivitationVCRequest resource) {
    // TODO: implement SendVCInvitation
    final $url = '/SendVCInvitation';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<SendInivitationVCResponse, SendInivitationVCResponse>($request);
  }

  @override
  Future<Response<ConferenceViewResponse>> AcceptVCInvitation(ConferenceViewRequest resource) {
    // TODO: implement AcceptVCInvitation
    final $url = '/AcceptVCInvitation';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<ConferenceViewResponse, ConferenceViewResponse>($request);
  }



  @override
  Future<Response<DocTypeResponse>> GetDocumentType(DocTypeRequest resource) {
    final $url = '/GetDocumentType';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<DocTypeResponse, DocTypeResponse>($request);
  }


  @override
  Future<Response<PayRespose>> SaveRegistrationForUnRegPat(
      PayRequest resource) {
    // TODO: implement GetInvestigationVisit
    final $url = '/SaveRegistrationForUnRegPat';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<PayRespose, PayRespose>($request);
  }



  @override
  Future<Response<UpdateResponse>> GetversionStatus(UpdateRequest resource) {
    // TODO: implement GetversionStatus
    final $url = '/GetversionStatus';

    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;
    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<UpdateResponse, UpdateResponse>($request);
  }

  @override
  Future<Response<UpdateTokenResponse>> UpdateNotificationToken(UpdateTokenRequest resource) {
    final $url = '/UpdateNotificationToken';
    final $headers = {
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    final $body = resource;

    final $request =
    Request('POST', $url, client.baseUrl, body: $body, headers: $headers);

    return client.send<UpdateTokenResponse, UpdateTokenResponse>($request);
  }




}

/*
this api call method used for Auth Token
Future forGetAuthToken() async {


  var url = BasicUrl.sendUrlToken();

  Map<String, dynamic> body = {
    'UserName': 'user',
    'Password': 'KLr2rZRTcGirE42Qav0/MkoP/Q=',
    'grant_type': 'password'
  };



  final response = await http.post(url,
      //body: body,
      body: body,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      encoding: Encoding.getByName("utf-8")
  );

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);
    var tokenModel= TokenModel.fromJson(json.decode(response.body));
    if(tokenModel!=null)
    {
      if(tokenModel.accessToken!=null)
      {
        String strToken=tokenModel.tokenType+" "+tokenModel.accessToken;
        saveData(strToken);
      }
    }
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}*/
