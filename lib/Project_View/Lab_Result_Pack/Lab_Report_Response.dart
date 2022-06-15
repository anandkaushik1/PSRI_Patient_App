class Lab_Report_Response {
  List<MobLabInfoArray>? mobLabInfoArray;
  String? status;
  String? msg;

  Lab_Report_Response({this.mobLabInfoArray, this.status, this.msg});

  Lab_Report_Response.fromJson(Map<String, dynamic> json) {
    if (json['MobLabInfoArray'] != null) {
      mobLabInfoArray= <MobLabInfoArray>[];
      json['MobLabInfoArray'].forEach((v) {
        mobLabInfoArray!.add(new MobLabInfoArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mobLabInfoArray != null) {
      data['MobLabInfoArray'] =
          this.mobLabInfoArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class MobLabInfoArray {
  int? departmentId;
  int? serviceId;
  String? serviceName;
  String? status;
  String? encodedDate;
  int? labNo;
  int? diagSampleId;
  int? stationId;
  String? oPIP;

  MobLabInfoArray(
      {this.departmentId,
        this.serviceId,
        this.serviceName,
        this.status,
        this.encodedDate,
        this.labNo,
        this.diagSampleId,
        this.stationId,
        this.oPIP});

  MobLabInfoArray.fromJson(Map<String, dynamic> json) {
    departmentId = json['DepartmentId'];
    serviceId = json['ServiceId'];
    serviceName = json['ServiceName'];
    status = json['Status'];
    encodedDate = json['EncodedDate'];
    labNo = json['LabNo'];
    diagSampleId = json['DiagSampleId'];
    stationId = json['StationId'];
    oPIP = json['OPIP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentId'] = this.departmentId;
    data['ServiceId'] = this.serviceId;
    data['ServiceName'] = this.serviceName;
    data['Status'] = this.status;
    data['EncodedDate'] = this.encodedDate;
    data['LabNo'] = this.labNo;
    data['DiagSampleId'] = this.diagSampleId;
    data['StationId'] = this.stationId;
    data['OPIP'] = this.oPIP;
    return data;
  }
}