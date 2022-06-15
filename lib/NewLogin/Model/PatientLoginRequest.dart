class PatientLoginRequest {
  String?  deviceTokenNo;
  String?  loginBy;
  String?  mobileNo;
  String?  userPassword;

  PatientLoginRequest(
      {this.deviceTokenNo, this.loginBy, this.mobileNo, this.userPassword});

  PatientLoginRequest.fromJson(Map<String, dynamic> json) {
    deviceTokenNo = json['DeviceTokenNo'];
    loginBy = json['LoginBy'];
    mobileNo = json['MobileNo'];
    userPassword = json['UserPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceTokenNo'] = this.deviceTokenNo;
    data['LoginBy'] = this.loginBy;
    data['MobileNo'] = this.mobileNo;
    data['UserPassword'] = this.userPassword;
    return data;
  }
}