class AddMemberOTPResponse {
  String? errorMessage;
  String? status;
  String? oTPno;
  String? mobileNo;

  AddMemberOTPResponse({this.errorMessage, this.status, this.oTPno, this.mobileNo});

  AddMemberOTPResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    oTPno = json['OTPno'];
    mobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['OTPno'] = this.oTPno;
    data['MobileNo'] = this.mobileNo;
    return data;
  }
}