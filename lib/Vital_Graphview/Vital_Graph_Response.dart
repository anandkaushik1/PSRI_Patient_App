class Vital_Graph_Response {
  List<VitalGraphList>? vitalGraphList;
  String? status;
  String? msg;
  String? getId;

  Vital_Graph_Response(
      {this.vitalGraphList, this.status, this.msg, this.getId});

  Vital_Graph_Response.fromJson(Map<String, dynamic> json) {
    if (json['VitalGraphList'] != null) {
      vitalGraphList= <VitalGraphList>[];
      json['VitalGraphList'].forEach((v) {
        vitalGraphList!.add(new VitalGraphList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vitalGraphList != null) {
      data['VitalGraphList'] =
          this.vitalGraphList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class VitalGraphList {
  String? vitalSignName;
  String? unitName;
  String? unitSymbol;
  String? vitalValue;
  String? vitalEntryDate;
  String? vitalDate;

  VitalGraphList(
      {this.vitalSignName,
        this.unitName,
        this.unitSymbol,
        this.vitalValue,
        this.vitalEntryDate,
        this.vitalDate});

  VitalGraphList.fromJson(Map<String, dynamic> json) {
    vitalSignName = json['VitalSignName'];
    unitName = json['UnitName'];
    unitSymbol = json['UnitSymbol'];
    vitalValue = json['VitalValue'];
    vitalEntryDate = json['VitalEntryDate'];
    vitalDate = json['VitalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VitalSignName'] = this.vitalSignName;
    data['UnitName'] = this.unitName;
    data['UnitSymbol'] = this.unitSymbol;
    data['VitalValue'] = this.vitalValue;
    data['VitalEntryDate'] = this.vitalEntryDate;
    data['VitalDate'] = this.vitalDate;
    return data;
  }
}