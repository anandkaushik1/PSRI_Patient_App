class VIdeoCallResponse {
  int? registrationId;
  String? patientName;
  int? doctorId;
  String? doctorName;
  String? uniqueValue;
  String? status;
  String? message;
  bool? isOpen;

  VIdeoCallResponse(
      {this.registrationId,
        this.patientName,
        this.doctorId,
        this.doctorName,
        this.uniqueValue,
        this.status,
        this.message,
        this.isOpen});

  VIdeoCallResponse.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    patientName = json['PatientName'];
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    uniqueValue = json['UniqueValue'];
    status = json['Status'];
    message = json['Message'];
    isOpen = json['IsOpen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['PatientName'] = this.patientName;
    data['DoctorId'] = this.doctorId;
    data['DoctorName'] = this.doctorName;
    data['UniqueValue'] = this.uniqueValue;
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['IsOpen'] = this.isOpen;
    return data;
  }
}