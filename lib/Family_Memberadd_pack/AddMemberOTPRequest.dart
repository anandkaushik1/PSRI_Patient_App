class AddMemberOTPRequest {
  String? mobileNo;
  bool? isFamilyMember;

  AddMemberOTPRequest({this.mobileNo,this.isFamilyMember});

  AddMemberOTPRequest.fromJson(Map<String, dynamic> json) {
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