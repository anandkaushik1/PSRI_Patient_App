class Diagnosis_Visit_Request {
  String? registrationId;

  Diagnosis_Visit_Request({this.registrationId});

  Diagnosis_Visit_Request.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}