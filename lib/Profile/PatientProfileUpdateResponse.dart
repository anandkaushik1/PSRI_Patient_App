class PatientProfileUpdateResponse {
  PatientProfile? patientProfile;
  String?  status;
  String?  msg;

  PatientProfileUpdateResponse({this.patientProfile, this.status, this.msg});

  PatientProfileUpdateResponse.fromJson(Map<String, dynamic> json) {
    patientProfile = json['PatientProfile'] != null
        ? new PatientProfile.fromJson(json['PatientProfile'])
        : null;
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientProfile != null) {
      data['PatientProfile'] = this.patientProfile!.toJson();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class PatientProfile {
  String?  registrationNo;
  String?  patientName;
  String?  mobileNo;
  String?  email;
  String?  errorMessage;

  PatientProfile(
      {this.registrationNo,
        this.patientName,
        this.mobileNo,
        this.email,
        this.errorMessage});

  PatientProfile.fromJson(Map<String, dynamic> json) {
    registrationNo = json['RegistrationNo'];
    patientName = json['PatientName'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationNo'] = this.registrationNo;
    data['PatientName'] = this.patientName;
    data['MobileNo'] = this.mobileNo;
    data['Email'] = this.email;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}