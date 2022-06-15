class VerifyOtpRequestOTP {
  String?  mobileNo;
  String?  oTP;
  String?  deviceTokenNo;

  VerifyOtpRequestOTP({this.mobileNo, this.oTP,this.deviceTokenNo});

  VerifyOtpRequestOTP.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    oTP = json['OTP'];
    deviceTokenNo = json['DeviceTokenNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['OTP'] = this.oTP;
    data['DeviceTokenNo'] = this.deviceTokenNo;
    return data;
  }
}