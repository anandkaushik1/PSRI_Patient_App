class Diagnosis_Request {
  String? encounterId;
  String? facilityId;
  String? registrationId;

  Diagnosis_Request({this.encounterId, this.facilityId, this.registrationId});

  Diagnosis_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}