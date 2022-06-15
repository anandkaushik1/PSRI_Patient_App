class NewRegistrationResponse {
  String?  status;
  String?  errorMessage;
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
  String?  uHIDMSG;
  String?  ageYear;
  String?  ageMonth;
  String?  ageDays;
  String?  regNo;
  String?  regId;
  bool? isUnRegPat;
  String?  videoConsultationCode;

  NewRegistrationResponse(
      {this.status,
        this.errorMessage,
        this.patientName,
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
        this.uHIDMSG,
        this.ageYear,
        this.ageMonth,
        this.ageDays,
        this.regNo,
        this.regId,
        this.isUnRegPat,
        this.videoConsultationCode});

  NewRegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
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
    uHIDMSG = json['UHID_MSG'];
    ageYear = json['AgeYear'];
    ageMonth = json['AgeMonth'];
    ageDays = json['AgeDays'];
    regNo = json['RegNo'];
    regId = json['RegId'];
    isUnRegPat = json['IsUnRegPat'];
    videoConsultationCode = json['VideoConsultationCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['ErrorMessage'] = this.errorMessage;
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
    data['UHID_MSG'] = this.uHIDMSG;
    data['AgeYear'] = this.ageYear;
    data['AgeMonth'] = this.ageMonth;
    data['AgeDays'] = this.ageDays;
    data['RegNo'] = this.regNo;
    data['RegId'] = this.regId;
    data['IsUnRegPat'] = this.isUnRegPat;
    data['VideoConsultationCode'] = this.videoConsultationCode;
    return data;
  }
}