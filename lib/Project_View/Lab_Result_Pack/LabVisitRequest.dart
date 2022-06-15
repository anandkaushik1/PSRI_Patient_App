class LabVisitRequest {

  String? registrationNo;

  LabVisitRequest({this.registrationNo});

  LabVisitRequest.fromJson(Map<String, dynamic> json) {
  registrationNo = json['RegistrationNo'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['RegistrationNo'] = this.registrationNo;
  return data;
  }
  }