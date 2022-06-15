class Vital_Graph_Sign_Response {
  List<VitalSignNameList>? vitalSignNameList;
  String? status;
  String? msg;
  String? getId;

  Vital_Graph_Sign_Response(
      {this.vitalSignNameList, this.status, this.msg, this.getId});

  Vital_Graph_Sign_Response.fromJson(Map<String, dynamic> json) {
    if (json['VitalSignNameList'] != null) {
      vitalSignNameList= <VitalSignNameList>[];
      json['VitalSignNameList'].forEach((v) {
        vitalSignNameList!.add(new VitalSignNameList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vitalSignNameList != null) {
      data['VitalSignNameList'] =
          this.vitalSignNameList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class VitalSignNameList {
  int? vitalId;
  String? vitalSignName;
  String? displayName;

  VitalSignNameList({this.vitalId, this.vitalSignName, this.displayName});

  VitalSignNameList.fromJson(Map<String, dynamic> json) {
    vitalId = json['VitalId'];
    vitalSignName = json['VitalSignName'];
    displayName = json['DisplayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VitalId'] = this.vitalId;
    data['VitalSignName'] = this.vitalSignName;
    data['DisplayName'] = this.displayName;
    return data;
  }
}