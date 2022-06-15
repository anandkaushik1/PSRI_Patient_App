class UploadDocumentRequest {
  String? appointmentId;
  String? doctorId;
  String? registrationId;
  String? encodedBy;
  String? hospitalLocationId;
  String? facilityId;
  String? fileType;
  String? document;
  int? documentTypeId;

  UploadDocumentRequest(
      {this.appointmentId,
        this.doctorId,
        this.document,
        this.registrationId,
        this.encodedBy,
        this.hospitalLocationId,
        this.facilityId,
        this.documentTypeId,
        this.fileType});

  UploadDocumentRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    doctorId = json['DoctorId'];
    document = json['Document'];
    registrationId = json['RegistrationId'];
    encodedBy = json['EncodedBy'];
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    documentTypeId = json['DocumentTypeId'];
    fileType = json['FileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['DoctorId'] = this.doctorId;
    data['Document'] = this.document;
    data['RegistrationId'] = this.registrationId;
    data['EncodedBy'] = this.encodedBy;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['DocumentTypeId'] = this.documentTypeId;
    data['FileType'] = this.fileType;
    return data;
  }
}