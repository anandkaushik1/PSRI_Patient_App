class RequestPrecription {
  String?  hospitalLocationId;

  RequestPrecription({this.hospitalLocationId});

  RequestPrecription.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    return data;
  }
}