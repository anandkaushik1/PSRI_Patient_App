class VerifyOtpResponseOTP {
  String?  mobileNo;
  String?  oTP;
  bool? isUserExist;
  int? iD;
  String?  name;
  String?  gender;
  String?  dOB;
  String?  emailId;
  bool? isHisRegistered;
  String?  verifyPatinetListCount;
  List<VerifyPatinetList>? verifyPatinetList;
  String?  status;
  String?  msg;
  String?  getId;

  VerifyOtpResponseOTP(
      {this.mobileNo,
        this.oTP,
        this.isUserExist,
        this.iD,
        this.name,
        this.gender,
        this.dOB,
        this.emailId,
        this.isHisRegistered,
        this.verifyPatinetListCount,
        this.verifyPatinetList,
        this.status,
        this.msg,
        this.getId});

  VerifyOtpResponseOTP.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    oTP = json['OTP'];
    isUserExist = json['IsUserExist'];
    iD = json['ID'];
    name = json['Name'];
    gender = json['Gender'];
    dOB = json['DOB'];
    emailId = json['EmailId'];
    isHisRegistered = json['IsHisRegistered'];
    verifyPatinetListCount = json['VerifyPatinetListCount'];
    if (json['VerifyPatinetList'] != null) {
      verifyPatinetList= <VerifyPatinetList>[];
      json['VerifyPatinetList'].forEach((v) {
        verifyPatinetList!.add(new VerifyPatinetList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['OTP'] = this.oTP;
    data['IsUserExist'] = this.isUserExist;
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['EmailId'] = this.emailId;
    data['IsHisRegistered'] = this.isHisRegistered;
    data['VerifyPatinetListCount'] = this.verifyPatinetListCount;
    if (this.verifyPatinetList != null) {
      data['VerifyPatinetList'] =
          this.verifyPatinetList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class VerifyPatinetList {
  int? registrationId;
  String?  registrationNo;
  String?  patientName;
  String?  gender;
  String?  dOB;
  String?  emailId;
  String?  hospitalLocationId;
  String?  facilityID;
  String?  age;
  String?  encounterId;
  String?  encounterNo;
  String?  patientType;
  String?  mobileNo;
  bool? isUnRegPat;

  VerifyPatinetList(
      {this.registrationId,
        this.registrationNo,
        this.patientName,
        this.gender,
        this.dOB,
        this.emailId,
        this.hospitalLocationId,
        this.facilityID,
        this.age,
        this.encounterId,
        this.encounterNo,
        this.patientType,
        this.mobileNo,
        this.isUnRegPat});

  VerifyPatinetList.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    registrationNo = json['RegistrationNo'];
    patientName = json['PatientName'];
    gender = json['Gender'];
    dOB = json['DOB'];
    emailId = json['EmailId'];
    hospitalLocationId = json['HospitalLocationId'];
    facilityID = json['FacilityID'];
    age = json['Age'];
    encounterId = json['EncounterId'];
    encounterNo = json['EncounterNo'];
    patientType = json['PatientType'];
    mobileNo = json['MobileNo'];
    isUnRegPat = json['IsUnRegPat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['RegistrationNo'] = this.registrationNo;
    data['PatientName'] = this.patientName;
    data['Gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['EmailId'] = this.emailId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityID'] = this.facilityID;
    data['Age'] = this.age;
    data['EncounterId'] = this.encounterId;
    data['EncounterNo'] = this.encounterNo;
    data['PatientType'] = this.patientType;
    data['MobileNo'] = this.mobileNo;
    data['IsUnRegPat'] = this.isUnRegPat;
    return data;
  }
}