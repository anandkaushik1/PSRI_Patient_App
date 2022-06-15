class ViewAppointmentRequest {
  String? registrationId;
  String? MobileNo;

  ViewAppointmentRequest({this.registrationId});

  ViewAppointmentRequest.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    MobileNo = json['MobileNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['MobileNo'] = this.MobileNo;
    return data;
  }
}