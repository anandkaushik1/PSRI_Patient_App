class SavePatientFeedbackModel {
  String?  departmentId;
  String?  subDepartmentId;
  String?  subDepartment;
  String?  rating;
  String?  feedBackStatusId;
  String?  registrationId;
  String?  encounterId;
  String?  flag;
  String?  feedback;

  SavePatientFeedbackModel(
      {this.departmentId,
        this.subDepartmentId,
        this.subDepartment,
        this.rating,
        this.feedBackStatusId,
        this.registrationId,
        this.encounterId,
        this.flag,
        this.feedback});

  SavePatientFeedbackModel.fromJson(Map<String, dynamic> json) {
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