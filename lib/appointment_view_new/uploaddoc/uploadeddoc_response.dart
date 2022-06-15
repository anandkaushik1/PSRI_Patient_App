class UploadedDocResponse {
  List<PatientDocList>? patientDocList;
  String?  status;
  String?  msg;
  String?  getId;

  UploadedDocResponse({this.patientDocList, this.status, this.msg, this.getId});

  UploadedDocResponse.fromJson(Map<String, dynamic> json) {
    if (json['PatientDocList'] != null) {
      patientDocList= <PatientDocList>[];
      json['PatientDocList'].forEach((v) {
        patientDocList!.add(new PatientDocList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientDocList != null) {
      data['PatientDocList'] =
          this.patientDocList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class PatientDocList {
  int? registrationId;
  String?  patientName;
  int? doctorId;
  int? status;
  String?  document;
  String?  encryptedDocument;
  String?  doctorName;
  int? encounterId;
  String?  encodedDate;
  String?  documentType;

  PatientDocList(
      {this.registrationId,
        this.patientName,
        this.doctorId,
        this.status,
        this.document,
        this.encryptedDocument,
        this.doctorName,
        this.encounterId,
        this.encodedDate,
        this.documentType});

  PatientDocList.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    patientName = json['PatientName'];
    doctorId = json['DoctorId'];
    status = json['Status'];
    document = json['Document'];
    encryptedDocument = json['EncryptedDocument'];
    doctorName = json['DoctorName'];
    encounterId = json['EncounterId'];
    encodedDate = json['EncodedDate'];
    documentType = json['DocumentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['PatientName'] = this.patientName;
    data['DoctorId'] = this.doctorId;
    data['Status'] = this.status;
    data['Document'] = this.document;
    data['EncryptedDocument'] = this.encryptedDocument;
    data['DoctorName'] = this.doctorName;
    data['EncounterId'] = this.encounterId;
    data['EncodedDate'] = this.encodedDate;
    data['DocumentType'] = this.documentType;
    return data;
  }
}