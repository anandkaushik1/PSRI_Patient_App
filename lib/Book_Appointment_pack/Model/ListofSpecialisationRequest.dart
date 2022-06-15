class ListofSpecialisationRequest {
  String? str;

  ListofSpecialisationRequest({this.str});

  ListofSpecialisationRequest.fromJson(Map<String, dynamic> json) {
    str = json['str'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['str'] = this.str;
    return data;
  }
}