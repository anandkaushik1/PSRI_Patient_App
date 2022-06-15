class SendInivitationVCRequest {
  int? hospitalLocationId;
  int? facilityId;
  int? senderRegId;
  int? doctorId;
  String? source;
  String? uniqueValue;
  int? recieverRegId;
  int? appointmentId;
  int? encounterId;

  SendInivitationVCRequest(
      {this.hospitalLocationId,
        this.facilityId,
        this.senderRegId,
        this.doctorId,
        this.source,
        this.uniqueValue,
        this.recieverRegId,
        this.appointmentId,
        this.encounterId});

  SendInivitationVCRequest.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    senderRegId = json['SenderRegId'];
    doctorId = json['DoctorId'];
    source = json['Source'];
    uniqueValue = json['UniqueValue'];
    recieverRegId = json['RecieverRegId'];
    appointmentId = json['AppointmentId'];
    encounterId = json['EncounterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['SenderRegId'] = this.senderRegId;
    data['DoctorId'] = this.doctorId;
    data['Source'] = this.source;
    data['UniqueValue'] = this.uniqueValue;
    data['RecieverRegId'] = this.recieverRegId;
    data['AppointmentId'] = this.appointmentId;
    data['EncounterId'] = this.encounterId;
    return data;
  }
}