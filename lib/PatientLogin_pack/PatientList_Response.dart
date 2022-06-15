class PatientList_Response {
  bool? multiPatient;
  bool? isUserExist;
  int? oTP;
  List<PatientList>? patientList;
  String?  status;
  String?  msg;

  PatientList_Response(
      {this.multiPatient,
        this.isUserExist,
        this.oTP,
        this.patientList,
        this.status,
        this.msg,
        });

  PatientList_Response.fromJson(Map<String, dynamic> json) {
    multiPatient = json['MultiPatient'];
    isUserExist = json['IsUserExist'];
    oTP = json['OTP'];
    if (json['PatientList'] != null) {
      patientList= <PatientList>[];
      json['PatientList'].forEach((v) {
        patientList!.add(new PatientList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MultiPatient'] = this.multiPatient;
    data['IsUserExist'] = this.isUserExist;
    data['OTP'] = this.oTP;
    if (this.patientList != null) {
      data['PatientList'] = this.patientList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class PatientList {
  String?  patientName;
  String?  mobileNo;
  String?  email;
  String?  role;
  String?  imagePath;
  String?  hISRegistrationId;
  String?  hospitalID;
  String?  facilityId;
  String?  encounterId;
  String?  age;
  String?  userType;
  String?  gender;
  String?  firstName;
  String?  middleName;
  String?  lasttName;
  String?  errorMessage;
  String?  uHIDMSG;
  String?  ageYear;
  String?  ageMonth;
  String?  ageDays;
  String?  regNo;
  String?  regId;
  int? titleId;
  bool? isUnRegPat;
  String?  videoConsultationCode;
  bool? externalPatient;

  PatientList(
      {this.patientName,
        this.mobileNo,
        this.email,
        this.role,
        this.imagePath,
        this.hISRegistrationId,
        this.hospitalID,
        this.facilityId,
        this.encounterId,
        this.age,
        this.userType,
        this.gender,
        this.firstName,
        this.middleName,
        this.lasttName,
        this.errorMessage,
        this.uHIDMSG,
        this.ageYear,
        this.ageMonth,
        this.ageDays,
        this.regNo,
        this.regId,
        this.titleId,
        this.isUnRegPat,
        this.videoConsultationCode,
        this.externalPatient});

  PatientList.fromJson(Map<String, dynamic> json) {
    patientName = json['PatientName'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    role = json['Role'];
    imagePath = json['ImagePath'];
    hISRegistrationId = json['HISRegistrationId'];
    hospitalID = json['HospitalID'];
    facilityId = json['FacilityId'];
    encounterId = json['EncounterId'];
    age = json['Age'];
    userType = json['UserType'];
    gender = json['Gender'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lasttName = json['LasttName'];
    errorMessage = json['ErrorMessage'];
    uHIDMSG = json['UHID_MSG'];
    ageYear = json['AgeYear'];
    ageMonth = json['AgeMonth'];
    ageDays = json['AgeDays'];
    regNo = json['RegNo'];
    regId = json['RegId'];
    titleId = json['TitleId'];
    isUnRegPat = json['IsUnRegPat'];
    videoConsultationCode = json['VideoConsultationCode'];
    externalPatient = json['ExternalPatient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientName'] = this.patientName;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    data['Role'] = this.role;
    data['ImagePath'] = this.imagePath;
    data['HISRegistrationId'] = this.hISRegistrationId;
    data['HospitalID'] = this.hospitalID;
    data['FacilityId'] = this.facilityId;
    data['EncounterId'] = this.encounterId;
    data['Age'] = this.age;
    data['UserType'] = this.userType;
    data['Gender'] = this.gender;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LasttName'] = this.lasttName;
    data['ErrorMessage'] = this.errorMessage;
    data['UHID_MSG'] = this.uHIDMSG;
    data['AgeYear'] = this.ageYear;
    data['AgeMonth'] = this.ageMonth;
    data['AgeDays'] = this.ageDays;
    data['RegNo'] = this.regNo;
    data['RegId'] = this.regId;
    data['TitleId'] = this.titleId;
    data['IsUnRegPat'] = this.isUnRegPat;
    data['VideoConsultationCode'] = this.videoConsultationCode;
    data['ExternalPatient'] = this.externalPatient;
    return data;
  }
}

