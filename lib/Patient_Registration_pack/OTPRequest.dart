class OTPRequest {
  String?  mobileNo;
  bool? isFamilyMember;

  OTPRequest({this.mobileNo,this.isFamilyMember});

  OTPRequest.fromJson(Map<String, dynamic> json) {
    mobileNo = json['MobileNo'];
    isFamilyMember = json['IsFamilyMember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['MobileNo'] = this.mobileNo;
    data['IsFamilyMember'] = this.isFamilyMember;
    return data;
  }
}