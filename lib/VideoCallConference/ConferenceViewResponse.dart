class ConferenceViewResponse {
  List<VCStatusList>? vCStatusList;
  String? status;
  String? msg;

  ConferenceViewResponse({this.vCStatusList, this.status, this.msg});

  ConferenceViewResponse.fromJson(Map<String, dynamic> json) {
    if (json['VCStatusList'] != null) {
      vCStatusList= <VCStatusList>[];
      json['VCStatusList'].forEach((v) {
        vCStatusList!.add(new VCStatusList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vCStatusList != null) {
      data['VCStatusList'] = this.vCStatusList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class VCStatusList {
  int? senderRegId;
  String? senderName;
  int? doctorId;
  String? doctorName;
  String? uniqueValue;
  String? status;
  String? message;
  bool? isOpen;
  String? appointmentDate;
  int? recieverRegId;

  VCStatusList(
      {this.senderRegId,
        this.senderName,
        this.doctorId,
        this.doctorName,
        this.uniqueValue,
        this.status,
        this.message,
        this.isOpen,
        this.appointmentDate,
        this.recieverRegId});

  VCStatusList.fromJson(Map<String, dynamic> json) {
    senderRegId = json['SenderRegId'];
    senderName = json['SenderName'];
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    uniqueValue = json['UniqueValue'];
    status = json['Status'];
    message = json['Message'];
    isOpen = json['IsOpen'];
    appointmentDate = json['AppointmentDate'];
    recieverRegId = json['RecieverRegId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SenderRegId'] = this.senderRegId;
    data['SenderName'] = this.senderName;
    data['DoctorId'] = this.doctorId;
    data['DoctorName'] = this.doctorName;
    data['UniqueValue'] = this.uniqueValue;
    data['Status'] = this.status;
    data['Message'] = this.message;
    data['IsOpen'] = this.isOpen;
    data['AppointmentDate'] = this.appointmentDate;
    data['RecieverRegId'] = this.recieverRegId;
    return data;
  }
}