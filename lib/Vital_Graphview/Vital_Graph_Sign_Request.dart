class Vital_Graph_Sign_Request {
  String? hospitalLocationId;

  Vital_Graph_Sign_Request({this.hospitalLocationId});

  Vital_Graph_Sign_Request.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    return data;
  }
}