class Discharge_Summary_Request {
  String?  encounterId;
  String?  registrationNo;

  Discharge_Summary_Request({this.encounterId, this.registrationNo});

  Discharge_Summary_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    registrationNo = json['RegistrationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['RegistrationNo'] = this.registrationNo;
    return data;
  }
}