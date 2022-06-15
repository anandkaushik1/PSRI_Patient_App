class Medication_Resquest {
  String? encounterId;
  String? facilityId;
  String? fromDate;
  String? hospitalLocationId;
  String? registrationId;
  String? toDate;

  Medication_Resquest(
      {this.encounterId,
        this.facilityId,
        this.fromDate,
        this.hospitalLocationId,
        this.registrationId,
        this.toDate});

  Medication_Resquest.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    fromDate = json['FromDate'];
    hospitalLocationId = json['HospitalLocationId'];
    registrationId = json['RegistrationId'];
    toDate = json['ToDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['FromDate'] = this.fromDate;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['RegistrationId'] = this.registrationId;
    data['ToDate'] = this.toDate;
    return data;
  }
}