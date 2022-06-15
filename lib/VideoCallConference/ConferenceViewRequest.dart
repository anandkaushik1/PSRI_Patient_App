class ConferenceViewRequest {
  int? hospitalLocationId;
  int? facilityId;
  int? registrationId;

  ConferenceViewRequest(
      {this.hospitalLocationId, this.facilityId, this.registrationId});

  ConferenceViewRequest.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}