class WritesUsRequest {
  String? mobileNo;
  String? callBackDate;
  String? email;
  String? callBacktime;
  String? encounterNo;
  String? registrationNo;
  String? patientName;
  String? remark;

  WritesUsRequest(
      {this.mobileNo,
        this.callBackDate,
        this.email,
        this.callBacktime,
        this.encounterNo,
        this.registrationNo,
        this.patientName,
        this.remark});

  WritesUsRequest.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    callBackDate = json['callBackDate'];
    email = json['Email'];
    callBacktime = json['CallBacktime'];
    encounterNo = json['EncounterNo'];
    registrationNo = json['RegistrationNo'];
    patientName = json['PatientName'];
    remark = json['Remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['callBackDate'] = this.callBackDate;
    data['Email'] = this.email;
    data['CallBacktime'] = this.callBacktime;
    data['EncounterNo'] = this.encounterNo;
    data['RegistrationNo'] = this.registrationNo;
    data['PatientName'] = this.patientName;
    data['Remark'] = this.remark;
    return data;
  }
}