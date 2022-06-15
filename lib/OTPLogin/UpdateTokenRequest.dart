class UpdateTokenRequest {
  int? registrationId;

  UpdateTokenRequest({this.registrationId});

  UpdateTokenRequest.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}