class ListofDoctorRequest {
  NameValuePairs? nameValuePairs;

  ListofDoctorRequest({this.nameValuePairs});

  ListofDoctorRequest.fromJson(Map<String, dynamic> json) {
    nameValuePairs = json['nameValuePairs'] != null
        ? new NameValuePairs.fromJson(json['nameValuePairs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nameValuePairs != null) {
      data['nameValuePairs'] = this.nameValuePairs!.toJson();
    }
    return data;
  }
}

class NameValuePairs {
  String? specializationId;

  NameValuePairs({this.specializationId});

  NameValuePairs.fromJson(Map<String, dynamic> json) {
    specializationId = json['SpecializationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SpecializationId'] = this.specializationId;
    return data;
  }
}