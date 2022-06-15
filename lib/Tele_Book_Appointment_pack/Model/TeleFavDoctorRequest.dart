class TeleFavDoctorRequest {
  String? specialisationId;
  String? tCDoctor;

  TeleFavDoctorRequest({this.specialisationId, this.tCDoctor});

  TeleFavDoctorRequest.fromJson(Map<String, dynamic> json) {
    specialisationId = json['SpecialisationId'];
    tCDoctor = json['TCDoctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SpecialisationId'] = this.specialisationId;
    data['TCDoctor'] = this.tCDoctor;
    return data;
  }
}