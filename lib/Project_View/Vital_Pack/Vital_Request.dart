class Vital_Request {
  String? intEncounterId;
  String? intFacilityId;
  String? intHospitalId;
  String? intRegId;

  Vital_Request(
      {this.intEncounterId,
        this.intFacilityId,
        this.intHospitalId,
        this.intRegId});

  Vital_Request.fromJson(Map<String, dynamic> json) {
    intEncounterId = json['intEncounterId'];
    intFacilityId = json['intFacilityId'];
    intHospitalId = json['intHospitalId'];
    intRegId = json['intRegId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intEncounterId'] = this.intEncounterId;
    data['intFacilityId'] = this.intFacilityId;
    data['intHospitalId'] = this.intHospitalId;
    data['intRegId'] = this.intRegId;
    return data;
  }
}