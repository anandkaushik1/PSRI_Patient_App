class Diagnosis_Response {
  List<PatientDiagnosisArray>? patientDiagnosisArray;
  String? status;
  String? msg;

  Diagnosis_Response({this.patientDiagnosisArray, this.status, this.msg});

  Diagnosis_Response.fromJson(Map<String, dynamic> json) {
    if (json['PatientDiagnosisArray'] != null) {
      patientDiagnosisArray= <PatientDiagnosisArray>[];
      json['PatientDiagnosisArray'].forEach((v) {
        patientDiagnosisArray!.add(new PatientDiagnosisArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientDiagnosisArray != null) {
      data['PatientDiagnosisArray'] =
          this.patientDiagnosisArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class PatientDiagnosisArray {
  String? id;
  String? iCDCode;
  String? iCDDescription;
  String? primaryDiagnosis;

  PatientDiagnosisArray(
      {this.id, this.iCDCode, this.iCDDescription, this.primaryDiagnosis});

  PatientDiagnosisArray.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    iCDCode = json['ICDCode'];
    iCDDescription = json['ICDDescription'];
    primaryDiagnosis = json['PrimaryDiagnosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ICDCode'] = this.iCDCode;
    data['ICDDescription'] = this.iCDDescription;
    data['PrimaryDiagnosis'] = this.primaryDiagnosis;
    return data;
  }
}