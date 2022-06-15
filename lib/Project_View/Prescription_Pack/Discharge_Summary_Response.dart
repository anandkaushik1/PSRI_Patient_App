class Discharge_Summary_Response {

  String?  patientSummary;
  String?  isFinalize;
  String?  finalizeBy;
  String?  finalizeDateTime;
  String?  status;
  String?  msg;

  Discharge_Summary_Response(
  {this.patientSummary,
  this.isFinalize,
  this.finalizeBy,
  this.finalizeDateTime,
  this.status,
  this.msg});

  Discharge_Summary_Response.fromJson(Map<String, dynamic> json) {
  patientSummary = json['PatientSummary'];
  isFinalize = json['IsFinalize'];
  finalizeBy = json['FinalizeBy'];
  finalizeDateTime = json['FinalizeDateTime'];
  status = json['Status'];
  msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['PatientSummary'] = this.patientSummary;
  data['IsFinalize'] = this.isFinalize;
  data['FinalizeBy'] = this.finalizeBy;
  data['FinalizeDateTime'] = this.finalizeDateTime;
  data['Status'] = this.status;
  data['Msg'] = this.msg;
  return data;
  }
  }