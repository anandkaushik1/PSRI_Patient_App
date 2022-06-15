class Referral_Details_Request {
  String? encounterId;
  String? facilityId;

  Referral_Details_Request({this.encounterId, this.facilityId});

  Referral_Details_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    return data;
  }
}