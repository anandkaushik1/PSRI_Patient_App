class Feedback_Response {

  String?  status;
  String?  message;
  String?  feedback;
  List<PatientFeebackModelSuper>? patientFeebackModel;

  Feedback_Response(
  {this.status, this.message, this.feedback, this.patientFeebackModel});

  Feedback_Response.fromJson(Map<String, dynamic> json) {
  status = json['Status'];
  message = json['Message'];
  feedback = json['Feedback'];
  if (json['PatientFeebackModel'] != null) {
  patientFeebackModel= <PatientFeebackModelSuper>[];
  json['PatientFeebackModel'].forEach((v) {
  patientFeebackModel!.add(new PatientFeebackModelSuper.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Status'] = this.status;
  data['Message'] = this.message;
  data['Feedback'] = this.feedback;
  if (this.patientFeebackModel != null) {
  data['PatientFeebackModel'] =
  this.patientFeebackModel!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class PatientFeebackModelSuper {
  String?  departmentName;
  List<PatientFeeback>? patientFeebackModel;

  PatientFeebackModelSuper({this.departmentName, this.patientFeebackModel});

  PatientFeebackModelSuper.fromJson(Map<String, dynamic> json) {
  departmentName = json['DepartmentName'];
  if (json['PatientFeebackModel'] != null) {
  patientFeebackModel= <PatientFeeback>[];
  json['PatientFeebackModel'].forEach((v) {
  patientFeebackModel!.add(new PatientFeeback.fromJson(v));
  });
  }
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['DepartmentName'] = this.departmentName;
  if (this.patientFeebackModel != null) {
  data['PatientFeebackModel'] =
  this.patientFeebackModel!.map((v) => v.toJson()).toList();
  }
  return data;
  }
  }

  class PatientFeeback {
  String?  departmentId;
  String?  subDepartmentId;
  String?  subDepartment;
  String?  rating;
  String?  feedBackStatusId;
  String?  registrationId;
  String?  encounterId;
  String?  flag;
  String?  feedback;

  PatientFeeback(
  {this.departmentId,
  this.subDepartmentId,
  this.subDepartment,
  this.rating,
  this.feedBackStatusId,
  this.registrationId,
  this.encounterId,
  this.flag,
  this.feedback});

  PatientFeeback.fromJson(Map<String, dynamic> json) {
  departmentId = json['DepartmentId'];
  subDepartmentId = json['SubDepartmentId'];
  subDepartment = json['SubDepartment'];
  rating = json['Rating'];
  feedBackStatusId = json['FeedBackStatusId'];
  registrationId = json['RegistrationId'];
  encounterId = json['EncounterId'];
  flag = json['Flag'];
  feedback = json['Feedback'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['DepartmentId'] = this.departmentId;
  data['SubDepartmentId'] = this.subDepartmentId;
  data['SubDepartment'] = this.subDepartment;
  data['Rating'] = this.rating;
  data['FeedBackStatusId'] = this.feedBackStatusId;
  data['RegistrationId'] = this.registrationId;
  data['EncounterId'] = this.encounterId;
  data['Flag'] = this.flag;
  data['Feedback'] = this.feedback;
  return data;
  }
  }