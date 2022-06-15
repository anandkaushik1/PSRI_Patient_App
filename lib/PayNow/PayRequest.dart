class PayRequest {
  String?  appointmentId;

  PayRequest({this.appointmentId});

  PayRequest.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    return data;
  }
}