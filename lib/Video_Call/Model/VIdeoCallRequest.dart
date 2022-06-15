class VIdeoCallRequest {
  int? hospitalLocationId;
  int? facilityId;
  int? registrationId;
  int? doctorId;
  String? source;
  bool? callStatus;
  int? appointmentId;
  int? encounterId;
  String? uniqueValue;

  VIdeoCallRequest(
      {this.hospitalLocationId,
        this.facilityId,
        this.registrationId,
        this.doctorId,
        this.source,
        this.callStatus,
        this.appointmentId,
        this.encounterId,
        this.uniqueValue});

  VIdeoCallRequest.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    registrationId = json['RegistrationId'];
    doctorId = json['DoctorId'];
    source = json['Source'];
    callStatus = json['CallStatus'];
    appointmentId = json['AppointmentId'];
    encounterId = json['EncounterId'];
    uniqueValue = json['UniqueValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['RegistrationId'] = this.registrationId;
    data['DoctorId'] = this.doctorId;
    data['Source'] = this.source;
    data['CallStatus'] = this.callStatus;
    data['AppointmentId'] = this.appointmentId;
    data['EncounterId'] = this.encounterId;
    data['UniqueValue'] = this.uniqueValue;
    return data;
  }
}