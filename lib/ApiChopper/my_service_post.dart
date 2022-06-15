import "dart:async";
import 'dart:convert';
import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:flutter_patient_app/ApiChopper/TokenModel.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Appmt_Slot_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Appmt_Slot_Response.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/Get_Patient_Details_Response.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorRequest.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationRequest.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/New_Book_Appointment_Response.dart';
import 'package:flutter_patient_app/Family_Memberadd_pack/AddMemberOTPRequest.dart';
import 'package:flutter_patient_app/Family_Memberadd_pack/AddMemberOTPResponse.dart';
import 'package:flutter_patient_app/Family_Memberadd_pack/AddMemberRequest.dart';
import 'package:flutter_patient_app/Family_Memberadd_pack/AddMemberResponse.dart';
import 'package:flutter_patient_app/Favourite_Doctor/Favourite_Doctor_Request.dart';
import 'package:flutter_patient_app/Favourite_Doctor/Favourite_Doctor_Response.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/UploadDocumentRequest.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/UploadDocumentResponse.dart';

import 'package:flutter_patient_app/Models/ListOfAppointmentRequest.dart';
import 'package:flutter_patient_app/Models/ListOfAppointmentResponse.dart';
import 'package:flutter_patient_app/Models/jsonforprecriptinres.dart';
import 'package:flutter_patient_app/Models/jsonforprecription.dart';

import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/Models/login_modal.dart';
import 'package:flutter_patient_app/Models/login_responce.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatient.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginRequest.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/UpdateRequest.dart';
import 'package:flutter_patient_app/NewLogin/Model/UpdateResponse.dart';
import 'package:flutter_patient_app/NewLogin/Splash.dart';
import 'package:flutter_patient_app/OTPLogin/LoginRequestOTP.dart';
import 'package:flutter_patient_app/OTPLogin/LoginResponseOTP.dart';
import 'package:flutter_patient_app/OTPLogin/UpdateTokenRequest.dart';
import 'package:flutter_patient_app/OTPLogin/UpdateTokenResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpRequestOTP.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientAppointmentView/AppointmentViewRequest.dart';
import 'package:flutter_patient_app/PatientAppointmentView/AppointmentViewResponse.dart';
import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentRequest.dart';
import 'package:flutter_patient_app/PatientAppointmentView/DeleteAppointmentResponse.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordRequest.dart';
import 'package:flutter_patient_app/PatientLogin_pack/ForgetPasswordResponse.dart';
import 'package:flutter_patient_app/PatientLogin_pack/PatientList_Request.dart';
import 'package:flutter_patient_app/PatientLogin_pack/PatientList_Response.dart';
import 'package:flutter_patient_app/PatientOther_Class/FavDoctorRequest.dart';
import 'package:flutter_patient_app/PatientOther_Class/FavDoctorResponse.dart';

import 'package:flutter_patient_app/Patient_Registration_pack/NewRegistrationRequest.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/NewRegistrationResponse.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/OTPRequest.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/OTPResponse.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/TitleLIst_Response.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/TitleList_Request.dart';
import 'package:flutter_patient_app/PayNow/PayRequest.dart';
import 'package:flutter_patient_app/PayNow/PayResponse.dart';
import 'package:flutter_patient_app/Profile/PatientProfileUpdate.dart';
import 'package:flutter_patient_app/Profile/PatientProfileUpdateResponse.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Request.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Response.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Visit_Request.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Visit_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_Garph_View.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_Garph_View_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_GraphView/Lab_GraphView_Field_Response.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabVisitRequest.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabVisitResponse.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Request.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Report_Response.dart';
import 'package:flutter_patient_app/Project_View/Patient_Medication/Medication_Response.dart';
import 'package:flutter_patient_app/Project_View/Patient_Medication/Medication_Resquest.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Discharge_Summary_Request.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Discharge_Summary_Response.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Full_Data_Request.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Full_Data_Response.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Response.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/VisitHistoryResponse.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/VisitHistory_Request.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Cross_Referral_Visit_Request.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Cross_Referral_Visit_Response.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Referral_Details_Request.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Referral_Details_Response.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Request.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Response.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Visit_Request.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Visit_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Request.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/Lab_Details_Response.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/SensitivityRequest.dart';
import 'package:flutter_patient_app/Project_View/lab_Details_pack/SensitivityResponse.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitRequestRadio.dart';
import 'package:flutter_patient_app/RadiologyLab_Result_Pack/LabVisitResponseRadio.dart';
import 'package:flutter_patient_app/RescheduleAppointment/RescheduleAppointmentRequest.dart';
import 'package:flutter_patient_app/RescheduleAppointment/RescheduleAppointmentResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleAppmt_Slot_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleFavDoctorRequest.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleFavDoctorResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleListofSpecialisationRequest.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleListofSpecialisationResponse.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Request.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/Model/TeleNew_Book_Appointment_Response.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientSearchWithFiltterRequest.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientSearchWithFiltterResponse.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtRequest.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtResponse.dart';
import 'package:flutter_patient_app/VideoCallConference/ConferenceViewRequest.dart';
import 'package:flutter_patient_app/VideoCallConference/ConferenceViewResponse.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/SendInivitationVCResponse.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallRequest.dart';
import 'package:flutter_patient_app/Video_Call/Model/VIdeoCallResponse.dart';
import 'package:flutter_patient_app/ViewDocument/DocumnetList_Request.dart';
import 'package:flutter_patient_app/ViewDocument/DocumnetList_Response.dart';
import 'package:flutter_patient_app/ViewDocument/viewDocument_Request.dart';
import 'package:flutter_patient_app/ViewDocument/viewDocument_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Request.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Response.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Request.dart';
import 'package:flutter_patient_app/Vital_Graphview/Vital_Graph_Sign_Response.dart';
import 'package:flutter_patient_app/Writes/WriteUsResponse.dart';
import 'package:flutter_patient_app/Writes/WritesUsRequest.dart';
import 'package:flutter_patient_app/appointment_view_new/UpdateRemarks_Request.dart';
import 'package:flutter_patient_app/appointment_view_new/UpdateRemarks_Response.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploaddoc_request.dart';
import 'package:flutter_patient_app/appointment_view_new/uploaddoc/uploadeddoc_response.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_request.dart';
import 'package:flutter_patient_app/appointment_view_new/view_appointment_response.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Request.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Response.dart';
import 'package:flutter_patient_app/feedback_pack/LastVisitRequest.dart';
import 'package:flutter_patient_app/feedback_pack/LastVisitResponse.dart';
import 'package:flutter_patient_app/feedback_pack/SaveFeedbackResponseModel.dart';

import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeRequest.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeResponse.dart';

import 'package:flutter_patient_app/feedback_pack/LastVisitRequest.dart';

import 'package:flutter_patient_app/feedback_pack/SavePatientFeedbackModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
part "chopper_post.dart";

@ChopperApi(baseUrl: "/Doctor")
abstract class MyServicePost extends ChopperService {
  static MyServicePost create(String baseUrl) {
    final client = ChopperClient(

        //  baseUrl="http://124.124.193.75:8098/api/Doctor"

        baseUrl:baseUrl,
        services: [
          _$MyServicePost()
        ],
        converter: JsonToTypeConverter({

          TokenModel: (jsonData) => TokenModel.fromJson(jsonData),
          Login_response: (jsonData) => Login_response.fromJson(jsonData),
          ListOfIpPatientResponse: (jsonData) => ListOfIpPatientResponse.fromJson(jsonData),
          ListOfAppointmentResponse: (jsonData) => ListOfAppointmentResponse.fromJson(jsonData),

          LabVisitResponse: (jsonData) => LabVisitResponse.fromJson(jsonData),
          Lab_Report_Response: (jsonData) => Lab_Report_Response.fromJson(jsonData),
          Lab_Details_Response: (jsonData) => Lab_Details_Response.fromJson(jsonData),
          Lab_Garph_View_Response: (jsonData) => Lab_Garph_View_Response.fromJson(jsonData),
          Lab_GraphView_Field_Response: (jsonData) => Lab_GraphView_Field_Response.fromJson(jsonData),
          Vital_Response: (jsonData) => Vital_Response.fromJson(jsonData),
          Vital_Visit_Response: (jsonData) => Vital_Visit_Response.fromJson(jsonData),
          Vital_Graph_Response: (jsonData) => Vital_Graph_Response.fromJson(jsonData),
          Vital_Graph_Sign_Response: (jsonData) => Vital_Graph_Sign_Response.fromJson(jsonData),

          UpdateTokenResponse: (jsonData) => UpdateTokenResponse.fromJson(jsonData),

          Prescription_Full_Data_Response: (jsonData) => Prescription_Full_Data_Response.fromJson(jsonData),
          Prescription_Response: (jsonData) => Prescription_Response.fromJson(jsonData),
          Discharge_Summary_Response: (jsonData) => Discharge_Summary_Response.fromJson(jsonData),
          Medication_Response: (jsonData) => Medication_Response.fromJson(jsonData),
          Diagnosis_Response: (jsonData) => Diagnosis_Response.fromJson(jsonData),
          Diagnosis_Visit_Response: (jsonData) => Diagnosis_Visit_Response.fromJson(jsonData),
          Cross_Referral_Visit_Response: (jsonData) => Cross_Referral_Visit_Response.fromJson(jsonData),
          Referral_Details_Response: (jsonData) => Referral_Details_Response.fromJson(jsonData),
          VisitHistoryResponse: (jsonData) => VisitHistoryResponse.fromJson(jsonData),
          Diagnosis_Visit_Response: (jsonData) => Diagnosis_Visit_Response.fromJson(jsonData),
          PatientSearchWithFiltterResponse: (jsonData) => PatientSearchWithFiltterResponse.fromJson(jsonData),
          UnResigrationAppmtResponse: (jsonData) => UnResigrationAppmtResponse.fromJson(jsonData),



          Appmt_Slot_Response: (jsonData) => Appmt_Slot_Response.fromJson(jsonData),
          Get_Patient_Details_Response: (jsonData) => Get_Patient_Details_Response.fromJson(jsonData),
          New_Book_Appointment_Response: (jsonData) => New_Book_Appointment_Response.fromJson(jsonData),
          SensitivityResponse: (jsonData) => SensitivityResponse.fromJson(jsonData),

          // patient App Api
          PatientLoginResponse: (jsonData) => PatientLoginResponse.fromJson(jsonData),
          UpdateResponse: (jsonData) => UpdateResponse.fromJson(jsonData),
          ListofDoctorResponse: (jsonData) => ListofDoctorResponse.fromJson(jsonData),
          ListofSpecialisationResponse: (jsonData) => ListofSpecialisationResponse.fromJson(jsonData),
          AppointmentViewResponse: (jsonData) => AppointmentViewResponse.fromJson(jsonData),
          DeleteAppointmentResponse: (jsonData) => DeleteAppointmentResponse.fromJson(jsonData),
          FavDoctorResponse: (jsonData) => FavDoctorResponse.fromJson(jsonData),

          NewRegistrationResponse: (jsonData) => NewRegistrationResponse.fromJson(jsonData),
          OTPResponse: (jsonData) => OTPResponse.fromJson(jsonData),
          ForgetPasswordResponse: (jsonData) => ForgetPasswordResponse.fromJson(jsonData),
          PatientProfileUpdateResponse: (jsonData) => PatientProfileUpdateResponse.fromJson(jsonData),


          LastVisitResponse: (jsonData) => LastVisitResponse.fromJson(jsonData),
          Feedback_Response: (jsonData) => Feedback_Response.fromJson(jsonData),
          WriteUsResponse: (jsonData) => WriteUsResponse.fromJson(jsonData),
          TeleFavDoctorResponse: (jsonData) => TeleFavDoctorResponse.fromJson(jsonData),
          SaveFeedbackResponseModel: (jsonData) => SaveFeedbackResponseModel.fromJson(jsonData),
          TeleNew_Book_Appointment_Response: (jsonData) => TeleNew_Book_Appointment_Response.fromJson(jsonData),
          TeleListofSpecialisationResponse: (jsonData) => TeleListofSpecialisationResponse.fromJson(jsonData),
          VerifyOtpResponseOTP: (jsonData) => VerifyOtpResponseOTP.fromJson(jsonData),
          LoginResponseOTP: (jsonData) => LoginResponseOTP.fromJson(jsonData),
          UpdateResponse: (jsonData) => UpdateResponse.fromJson(jsonData),

          UpdateResponse: (jsonData) => UpdateResponse.fromJson(jsonData),

          LabVisitResponseRadio: (jsonData) => LabVisitResponseRadio.fromJson(jsonData),

          RescheduleAppointmentResponse: (jsonData)=>RescheduleAppointmentResponse.fromJson(jsonData),

          TeleAppmt_Slot_Response: (jsonData) => TeleAppmt_Slot_Response.fromJson(jsonData),
          Favourite_Doctor_Response: (jsonData) => Favourite_Doctor_Response.fromJson(jsonData),
          viewDocumentResponse: (jsonData) => viewDocumentResponse.fromJson(jsonData),
          DocumnetList_Response: (jsonData) => DocumnetList_Response.fromJson(jsonData),
          ViewAppointmentResponse: (jsonData) => ViewAppointmentResponse.fromJson(jsonData),
          UploadedDocResponse: (jsonData) => UploadedDocResponse.fromJson(jsonData),
          UploadDocumentResponse: (jsonData) => UploadDocumentResponse.fromJson(jsonData),
          VIdeoCallResponse: (jsonData) => VIdeoCallResponse.fromJson(jsonData),
          SendInivitationVCResponse: (jsonData) => SendInivitationVCResponse.fromJson(jsonData),
          ConferenceViewResponse: (jsonData) => ConferenceViewResponse.fromJson(jsonData),
          AddMemberOTPResponse: (jsonData) => AddMemberOTPResponse.fromJson(jsonData),
          AddMemberResponse: (jsonData) => AddMemberResponse.fromJson(jsonData),
          Remarks_Response: (jsonData) => Remarks_Response.fromJson(jsonData),
          PayRespose: (jsonData) => PayRespose.fromJson(jsonData),
          DocTypeResponse: (jsonData) => DocTypeResponse.fromJson(jsonData),
          titleIDList_Response: (jsonData) => titleIDList_Response.fromJson(jsonData),
          VerifyOtpResponseOTP: (jsonData) => VerifyOtpResponseOTP.fromJson(jsonData),
        }
        )
    );

    return _$MyServicePost(client);
  }



 /* @Post()
  Future<Response<responsemoster>> newResource(@Body() RequestPrecription resource,{@Header() String name});
*/
  @Post(headers: const{ "Content-Type": "application/x-www-form-urlencoded"})
  Future<Response<TokenModel>> tokenForS(@Body() String resource);

  @Post()
  Future<Response<Login_response>> LoginApi(@Body() login_model resource);
  @Post()
  Future<Response<ListOfIpPatientResponse>> PatirentBydoctorApi(@Body() ListOfIpPatientResquest resource);
  @Post()
  Future<Response<ListOfAppointmentResponse>> AppointmentSchedule(@Body() ListOfAppointmentRequest resource);

  @Post()
  Future<Response<LabVisitResponse>> GetInvestigationVisit(@Body() LabVisitRequest resource);

  @Post()
  Future<Response<LabVisitResponseRadio>> GetInvestigationVisitRadio(@Body() LabVisitRequestRadio resourse);

  @Post()
  Future<Response<PayRespose>> SaveRegistrationForUnRegPat(@Body() PayRequest resource);

  @Post()
  Future<Response<Lab_Report_Response>> PatientLabInfo(@Body() Lab_Report_Request resource);

  @Post()
  Future<Response<Lab_Details_Response>> PatientLabInfoDetails(@Body() Lab_Details_Request resource);

  @Post()
  Future<Response<UpdateTokenResponse>> UpdateNotificationToken(@Body() UpdateTokenRequest resource);



  @Post()
  Future<Response<Lab_Garph_View_Response>> LabResultGraph(@Body() Lab_Garph_View resource);

  @Post()
  Future<Response<Lab_GraphView_Field_Response>> LabResultGraphField(@Body() Lab_GraphView_Field resource);

  @Post()
  Future<Response<Vital_Visit_Response>> GetVitalVisit(@Body() Vital_Visit_Request resource);

  @Post()
  Future<Response<Vital_Response>> PatientvitalDetail(@Body() Vital_Request resource);

  @Post()
  Future<Response<Vital_Graph_Response>> VitalGraph(@Body() Vital_Graph_Request resource);


  @Post()
  Future<Response<RescheduleAppointmentResponse>> ReschedulePatientAppointment(@Body() RescheduleAppointmentRequest resource);

  @Post()
  Future<Response<Vital_Graph_Sign_Response>> GetVitalSignName(@Body() Vital_Graph_Sign_Request resource);

  @Post()
  Future<Response<Prescription_Full_Data_Response>> GetPatientCashsheet(@Body() Prescription_Full_Data_Request resource);

  @Post()
  Future<Response<Medication_Response>> PatientMedication(@Body() Medication_Resquest resource);


  @Post()
  Future<Response<Diagnosis_Visit_Response>> DiagnosisVisit(@Body() Diagnosis_Visit_Request resource);

  @Post()
  Future<Response<Diagnosis_Response>> PatientDiagnosis(@Body() Diagnosis_Request resource);

  @Post()
  Future<Response<Cross_Referral_Visit_Response>> GetReferralVisit(@Body() Cross_Referral_Visit_Request resource);

  @Post()
  Future<Response<Referral_Details_Response>> GetReferralDetails(@Body() Referral_Details_Request resource);

  @Post()
  Future<Response<Discharge_Summary_Response>> GetPatientDischargeSummary(@Body() Discharge_Summary_Request resource);

  @Post()
  Future<Response<VisitHistoryResponse>> MobGetVisitHistory(@Body() VisitHistoryRequest resource);

  @Post()
  Future<Response<Diagnosis_Visit_Response>> GetDiagnosisVisit(@Body() Diagnosis_Visit_Request resource);

  @Post()
  Future<Response<UnResigrationAppmtResponse>> SaveAppointmentUnRegisteredPatient(@Body() UnResigrationAppmtRequest resource);

  @Post()
  Future<Response<PatientSearchWithFiltterResponse>> GetRegisteredPatientList(@Body() PatientSearchWithFiltterRequest resource);

//////////
  @Post()
  Future<Response<Appmt_Slot_Response>> MobGetDoctorWiseSlot(@Body() Appmt_slot_Request resource);

  @Post()
  Future<Response<Get_Patient_Details_Response>> MobGetPatientDetailsByRegistrationNo(@Body() Get_Patient_Details_Request resource);

  @Post()
  Future<Response<New_Book_Appointment_Response>> MobSaveAppointment(@Body() New_Book_Appointment_Request resource);


  @Post()
  Future<Response<TeleNew_Book_Appointment_Response>> TeleMobSaveAppointment(@Body() TeleNew_Book_Appointment_Request resource);

  @Post()
  Future<Response<SensitivityResponse>> SensitivityDetails(@Body() SensitivityRequest resource);






  /// patient App login

  @Post()
  Future<Response<PatientLoginResponse>> MobPatientLogin(@Body() PatientLoginRequest resource);

  @Post()
  Future<Response<UpdateResponse>> GetversionStatus(@Body() UpdateRequest resource);


  @Post()
  Future<Response<ListofDoctorResponse>> MobDoctorList(@Body() ListofDoctorRequest resource);

  @Post()
  Future<Response<ListofSpecialisationResponse>> MobSpecialisationList(@Body() ListofSpecialisationRequest resource);

  @Post()
  Future<Response<TeleListofSpecialisationResponse>> TeleMobSpecialisationList(@Body() TeleListofSpecialisationRequest resource);

  @Post()
  Future<Response<UploadDocumentResponse>> SavePatientDocumentNew(@Body() UploadDocumentRequest resource);

  @Post()
  Future<Response<ConferenceViewResponse>> AcceptVCInvitation(@Body() ConferenceViewRequest resource);

  ////////////////
  @Post()
  Future<Response<ForgetPasswordResponse>> MobForgatePassword(@Body() ForgetPasswordRequest resource);



  @Post()
  Future<Response<NewRegistrationResponse>> MobSaveRegistrationForPatient(@Body() NewRegistrationRequest resource);

  @Post()
  Future<Response<AddMemberResponse>> MobSaveRegistrationForFamily(@Body() AddMemberRequest resource);



  @Post()
  Future<Response<FavDoctorResponse>> MobGetDoctorList(@Body() FavDoctorRequest resource);

  @Post()
  Future<Response<TeleFavDoctorResponse>> TeleMobDoctorList(@Body() TeleFavDoctorRequest resource);

  @Post()
  Future<Response<AppointmentViewResponse>> MobGetAppointmentList(@Body() AppointmentViewRequest resource);

  @Post()
  Future<Response<DeleteAppointmentResponse>> MobCancelAppointment(@Body() DeleteAppointmentRequest resource);

  @Post()
  Future<Response<PatientProfileUpdateResponse>> MobPatientProfile(@Body() PatientProfileUpdate resource);

  @Post()
  Future<Response<Feedback_Response>> GetPatientFeedback(@Body() Feedback_Request resource);

  @Post()
  Future<Response<LastVisitResponse>> LastVisit(@Body() LastVisitRequest resource);

  @Post()
  Future<Response<WriteUsResponse>> SaveWriteUs(@Body() WritesUsRequest resource);

  @Post()
  Future<Response<SaveFeedbackResponseModel>> SavePatientFeedback(@Body() String resource);

  @Post()
  Future<Response<VerifyOtpResponseOTP>> VerifyPatientOTP(@Body() VerifyOtpRequestOTP resource);
  @Post()
  Future<Response<LoginResponseOTP>> GenerateOTPForPatientOTP(@Body() LoginRequestOTP resource);
  @Post()
  Future<Response<OTPResponse>> GenerateOTPForSignup(@Body() OTPRequest resource);


  @Post()
  Future<Response<AddMemberOTPResponse>> GenerateOTPForFamily(@Body() AddMemberOTPRequest resource);


  @Post()
  Future<Response<TeleAppmt_Slot_Response>> TeleMobGetDoctorWiseSlot(@Body() TeleAppmt_Slot_Request resource);

  @Post()
  Future<Response<viewDocumentResponse>> viewDocumentVisits(@Body() viewDocumentRequest resource);


  @Post()
  Future<Response<DocumnetList_Response>> DcoumentListData(@Body() DocumnetList_Request resource);

  @Post()
  Future<Response<Favourite_Doctor_Response>> FavouriteDOctor(@Body() Favourite_Doctor_Request resource);

  @Post()
  Future<Response<ViewAppointmentResponse>> AppointmentList(@Body() ViewAppointmentRequest resource);

  @Post()
  Future<Response<UploadedDocResponse>> appointmentViewDoc(@Body() UploadedDocRequest resource);



  @Post()
  Future<Response<VerifyOtpResponseOTP>> GetPatientList(@Body() VerifyOtpRequestOTP resource);
  @Post()
  Future<Response<titleIDList_Response>> getTitleList(@Body() titleIDList_Resquest resource);


  @Post()
  Future<Response<VIdeoCallResponse>> VCStatus(@Body() VIdeoCallRequest resource);

  @Post()
  Future<Response<SendInivitationVCResponse>> SendVCInvitation(@Body() SendInivitationVCRequest resource);

  @Post()
  Future<Response<DocTypeResponse>> GetDocumentType(@Body() DocTypeRequest resource);

  @Post()
  Future<Response<Remarks_Response>> UpdateRemakrsData(@Body() Remarks_Request resource);



}

class JsonToTypeConverter extends JsonConverter {

  final Map<Type, Function> typeToJsonFactoryMap;

  JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    String temp=response.body.toString();
    String tempRemoveNull=temp.replaceAll("null", "\"\"");
    String myBoday=tempRemoveNull;
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(myBoday, typeToJsonFactoryMap[InnerType]),
    );
  }

  T fromJsonData<T, InnerType>(String jsonData, Function? jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser!(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser!(jsonMap);
  }
}

