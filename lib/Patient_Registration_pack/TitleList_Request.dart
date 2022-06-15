class titleIDList_Resquest {
  String?  hospitalLocationId;

  titleIDList_Resquest({this.hospitalLocationId});

  titleIDList_Resquest.fromJson(Map<String, dynamic> json) {
    hospitalLocationId = json['HospitalLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalLocationId'] = this.hospitalLocationId;
    return data;
  }
}