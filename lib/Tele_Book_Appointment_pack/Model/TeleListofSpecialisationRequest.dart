class TeleListofSpecialisationRequest {
  String? tCDoctor;

  TeleListofSpecialisationRequest({this.tCDoctor});

  TeleListofSpecialisationRequest.fromJson(Map<String, dynamic> json) {
    tCDoctor = json['TCDoctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TCDoctor'] = this.tCDoctor;
    return data;
  }
}