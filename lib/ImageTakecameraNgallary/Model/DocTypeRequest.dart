class DocTypeRequest {
  int? hospitalId;
  String? source;

  DocTypeRequest({this.hospitalId, this.source});

  DocTypeRequest.fromJson(Map<String, dynamic> json) {
    hospitalId = json['HospitalId'];
    source = json['Source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalId'] = this.hospitalId;
    data['Source'] = this.source;
    return data;
  }
}