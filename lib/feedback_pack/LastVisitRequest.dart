

class LastVisitRequest {
  String?  registrationId;

  LastVisitRequest({this.registrationId});

  LastVisitRequest.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    return data;
  }
}