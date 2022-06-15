class VerifyOtpResponse {
  String? mobileNo;
  String? oTP;
  bool? isUserExist;
  int? iD;
  String? name;
  String? gender;
  String? dOB;
  String? emailId;
  bool? isHisRegistered;
  String? verifyPatinetListCount;
  List<VerifyPatinetList>? verifyPatinetList;
  String? status;
  String? msg;

  VerifyOtpResponse(
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
  this.msg});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
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
  return data;
  }
  }

  class VerifyPatinetList {
  int? registrationId;
  String? registrationNo;
  String? patientName;
  String? gender;
  String? dOB;
  String? emailId;
  bool? isUserExist;
  bool? isHisRegistered;

  VerifyPatinetList(
  {this.registrationId,
  this.registrationNo,
  this.patientName,
  this.gender,
  this.dOB,
  this.emailId,
  this.isUserExist,
  this.isHisRegistered});

  VerifyPatinetList.fromJson(Map<String, dynamic> json) {
  registrationId = json['RegistrationId'];
  registrationNo = json['RegistrationNo'];
  patientName = json['PatientName'];
  gender = json['Gender'];
  dOB = json['DOB'];
  emailId = json['EmailId'];
  isUserExist = json['IsUserExist'];
  isHisRegistered = json['IsHisRegistered'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['RegistrationId'] = this.registrationId;
  data['RegistrationNo'] = this.registrationNo;
  data['PatientName'] = this.patientName;
  data['Gender'] = this.gender;
  data['DOB'] = this.dOB;
  data['EmailId'] = this.emailId;
  data['IsUserExist'] = this.isUserExist;
  data['IsHisRegistered'] = this.isHisRegistered;
  return data;
  }
  }