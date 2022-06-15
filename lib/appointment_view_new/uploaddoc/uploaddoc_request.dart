class UploadedDocRequest {
  String?  appointmentId;
  String?  doctorId;
  String?  encounterId;
  String?  facilityId;
  String?  hospitalLocationId;
  String?  registrationId;

  UploadedDocRequest(
      {this.appointmentId,
        this.doctorId,
        this.encounterId,
        this.facilityId,
        this.hospitalLocationId,
        this.registrationId});

  UploadedDocRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    doctorId = json['DoctorId'];
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    hospitalLocationId = json['HospitalLocationId'];
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['DoctorId'] = this.doctorId;
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}