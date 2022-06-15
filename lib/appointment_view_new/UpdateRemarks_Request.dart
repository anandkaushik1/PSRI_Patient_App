class Remarks_Request {
  String? registrationId;
  String? appointmentId;
  String? remarks;

  Remarks_Request({this.registrationId, this.appointmentId, this.remarks});

  Remarks_Request.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    appointmentId = json['AppointmentId'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['AppointmentId'] = this.appointmentId;
    data['Remarks'] = this.remarks;
    return data;
  }
}

