class Feedback_Request {
  String?  encounterId;
  String?  registrationId;

  Feedback_Request({this.encounterId, this.registrationId});

  Feedback_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}