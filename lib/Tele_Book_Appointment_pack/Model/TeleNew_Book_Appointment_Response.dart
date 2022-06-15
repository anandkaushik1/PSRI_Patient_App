class TeleNew_Book_Appointment_Response {
  String? appointmentId;
  String? errorMessage;
  bool? status;
  String? RegistrationId;
  String? RegistrationNo;


  TeleNew_Book_Appointment_Response(
      {this.appointmentId, this.errorMessage, this.status, this.RegistrationId, this.RegistrationNo});

  TeleNew_Book_Appointment_Response.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
    RegistrationId = json['RegistrationId'];
    RegistrationNo = json['RegistrationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    data['RegistrationId'] = this.RegistrationId;
    data['RegistrationNo'] = this.RegistrationNo;
    return data;
  }
}
