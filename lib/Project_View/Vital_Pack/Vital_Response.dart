class Vital_Response {
  List<PatietnListArray>? patietnListArray;
  String? status;
  String? msg;
  String? getId;

  Vital_Response({this.patietnListArray, this.status, this.msg, this.getId});

  Vital_Response.fromJson(Map<String, dynamic> json) {
    if (json['PatietnListArray'] != null) {
      patietnListArray= <PatietnListArray>[];
      json['PatietnListArray'].forEach((v) {
        patietnListArray!.add(new PatietnListArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patietnListArray != null) {
      data['PatietnListArray'] =
          this.patietnListArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class PatietnListArray {
  int? id;
  String? vitalDate;
  String? height;
  String? weight;
  String? respiration;
  String? pulse;
  String? temperature;
  String? bMI;
  String? bSA;
  String? bPSystolic;
  String? bPDiastolic;
  String? painScore;
  String? status;
  String? headCircumference;
  String? sPO2;
  String? mAC;
  String? enteredby;
  String? enteredIssue;
  String? gRBS;
  String? unstandable;
  String? critical;

  PatietnListArray(
      {this.id,
        this.vitalDate,
        this.height,
        this.weight,
        this.respiration,
        this.pulse,
        this.temperature,
        this.bMI,
        this.bSA,
        this.bPSystolic,
        this.bPDiastolic,
        this.painScore,
        this.status,
        this.headCircumference,
        this.sPO2,
        this.mAC,
        this.enteredby,
        this.enteredIssue,
        this.gRBS,
        this.unstandable,
        this.critical});

  PatietnListArray.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    vitalDate = json['VitalDate'];
    height = json['Height'];
    weight = json['Weight'];
    respiration = json['Respiration'];
    pulse = json['Pulse'];
    temperature = json['Temperature'];
    bMI = json['BMI'];
    bSA = json['BSA'];
    bPSystolic = json['BPSystolic'];
    bPDiastolic = json['BPDiastolic'];
    painScore = json['PainScore'];
    status = json['Status'];
    headCircumference = json['HeadCircumference'];
    sPO2 = json['SPO2'];
    mAC = json['MAC'];
    enteredby = json['Enteredby'];
    enteredIssue = json['EnteredIssue'];
    gRBS = json['GRBS'];
    unstandable = json['Unstandable'];
    critical = json['Critical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['VitalDate'] = this.vitalDate;
    data['Height'] = this.height;
    data['Weight'] = this.weight;
    data['Respiration'] = this.respiration;
    data['Pulse'] = this.pulse;
    data['Temperature'] = this.temperature;
    data['BMI'] = this.bMI;
    data['BSA'] = this.bSA;
    data['BPSystolic'] = this.bPSystolic;
    data['BPDiastolic'] = this.bPDiastolic;
    data['PainScore'] = this.painScore;
    data['Status'] = this.status;
    data['HeadCircumference'] = this.headCircumference;
    data['SPO2'] = this.sPO2;
    data['MAC'] = this.mAC;
    data['Enteredby'] = this.enteredby;
    data['EnteredIssue'] = this.enteredIssue;
    data['GRBS'] = this.gRBS;
    data['Unstandable'] = this.unstandable;
    data['Critical'] = this.critical;
    return data;
  }
}