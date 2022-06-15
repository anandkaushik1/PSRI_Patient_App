class DeleteAppointmentRequest {
  String?  appointmentId;
  String?  reasons;
  String?  registrationNo;

  DeleteAppointmentRequest({this.appointmentId, this.reasons, this.registrationNo});

  DeleteAppointmentRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    reasons = json['Reasons'];
    registrationNo = json['RegistrationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['Reasons'] = this.reasons;
    data['RegistrationNo'] = this.registrationNo;
    return data;
  }
}
