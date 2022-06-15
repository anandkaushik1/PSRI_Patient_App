class DocumnetList_Request {
  String? doctorId;
  String? encounterId;
  String? facilityId;
  String? hospitalLocationId;
  String? registrationId;

  DocumnetList_Request(
      {this.doctorId,
        this.encounterId,
        this.facilityId,
        this.hospitalLocationId,
        this.registrationId});

  DocumnetList_Request.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    hospitalLocationId = json['HospitalLocationId'];
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}

