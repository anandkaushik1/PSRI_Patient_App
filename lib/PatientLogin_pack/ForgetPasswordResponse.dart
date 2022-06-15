class ForgetPasswordResponse {
  String?  email;
  String?  patientName;
  String?  password;
  String?  errorMessage;

  ForgetPasswordResponse(
      {this.email, this.patientName, this.password, this.errorMessage});

  ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    patientName = json['PatientName'];
    password = json['Password'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['PatientName'] = this.patientName;
    data['Password'] = this.password;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}