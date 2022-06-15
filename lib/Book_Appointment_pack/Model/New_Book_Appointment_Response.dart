class New_Book_Appointment_Response {
  String? appointmentId;
  String? errorMessage;
  bool? status;

  New_Book_Appointment_Response({this.appointmentId, this.errorMessage, this.status});

  New_Book_Appointment_Response.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    return data;
  }
}