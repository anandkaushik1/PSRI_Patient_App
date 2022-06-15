class LoginRequestOTP {
  String?  mobileNo;

  LoginRequestOTP({this.mobileNo});

  LoginRequestOTP.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}