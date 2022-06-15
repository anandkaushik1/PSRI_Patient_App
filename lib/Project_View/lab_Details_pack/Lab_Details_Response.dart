class Lab_Details_Response {

  List<DoctorLabDetails>? doctorLabDetails;
  String? status;
  String? msg;

  Lab_Details_Response({this.doctorLabDetails, this.status, this.msg});

  Lab_Details_Response.fromJson(Map<String, dynamic> json) {
  if (json['DoctorLabDetails'] != null) {
  doctorLabDetails= <DoctorLabDetails>[];
  json['DoctorLabDetails'].forEach((v) {
  doctorLabDetails!.add(new DoctorLabDetails.fromJson(v));
  });
  }
  status = json['Status'];
  msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.doctorLabDetails != null) {
  data['DoctorLabDetails'] =
  this.doctorLabDetails!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  data['Msg'] = this.msg;
  return data;
  }
  }

  class DoctorLabDetails {
    /*"Source": "IPD",
    "DiagSampleId": 665633,
    "ServiceId": 2315,
    "LabNo": 20783061,
    "ServiceName": "CBC",
    "StatusId": 51,
    "StatusColor": "#00FFFF",
    "Result": "Result",
    "OrderDate": "29/01/2020  6:20AM",
    "AbnormalValue": "0",
    "CriticalValue": "0",
    "StatusCode": "RF",
    "Provider": "",
    "UnitName": "",
    "EncodedDate": "1/28/2020 10:34:00 PM",
    "ResultId": 1,
    "FieldName": "Complete Blood Count (CBC)",
    "FieldId": 861,
    "ErrorMessage": "True",*/
  String? source;
  int? diagSampleId;
  int? serviceId;
  int? labNo;
  String? serviceName;
  int? statusId;
  String? statusColor;
  String? result;
  String? orderDate;
  String? abnormalValue;
  String? criticalValue;
  String? statusCode;
  String? provider;
  String? unitName;
  String? encodedDate;
  int? resultId;
  String? fieldName;
  int? fieldId;
  String? errorMessage;
  String? methodName;
  String? serviceRemarks;
  String? valueWordProcessor;
  String? fieldType;
  String? sequenceNo;
  String? pDFURL;
  int? isGraph;

  DoctorLabDetails(
  {this.source,
  this.diagSampleId,
  this.serviceId,
  this.labNo,
  this.serviceName,
  this.statusId,
  this.statusColor,
  this.result,
  this.orderDate,
  this.abnormalValue,
  this.criticalValue,
  this.statusCode,
  this.provider,
  this.unitName,
  this.encodedDate,
  this.resultId,
  this.fieldName,
  this.fieldId,
  this.errorMessage,
  this.methodName,
  this.serviceRemarks,
  this.valueWordProcessor,
  this.fieldType,
  this.sequenceNo,
  this.pDFURL,
  this.isGraph});

  DoctorLabDetails.fromJson(Map<String, dynamic> json) {
  source = json['Source'];
  diagSampleId = json['DiagSampleId'];
  serviceId = json['ServiceId'];
  labNo = json['LabNo'];
  serviceName = json['ServiceName'];
  statusId = json['StatusId'];
  statusColor = json['StatusColor'];
  result = json['Result'];
  orderDate = json['OrderDate'];
  abnormalValue = json['AbnormalValue'];
  criticalValue = json['CriticalValue'];
  statusCode = json['StatusCode'];
  provider = json['Provider'];
  unitName = json['UnitName'];
  encodedDate = json['EncodedDate'];
  resultId = json['ResultId'];
  fieldName = json['FieldName'];
  fieldId = json['FieldId'];
  errorMessage = json['ErrorMessage'];
  methodName = json['MethodName'];
  serviceRemarks = json['ServiceRemarks'];
  valueWordProcessor = json['ValueWordProcessor'];
  fieldType = json['FieldType'];
  sequenceNo = json['SequenceNo'];
  pDFURL = json['PDFURL'];
  isGraph = json['IsGraph'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['Source'] = this.source;
  data['DiagSampleId'] = this.diagSampleId;
  data['ServiceId'] = this.serviceId;
  data['LabNo'] = this.labNo;
  data['ServiceName'] = this.serviceName;
  data['StatusId'] = this.statusId;
  data['StatusColor'] = this.statusColor;
  data['Result'] = this.result;
  data['OrderDate'] = this.orderDate;
  data['AbnormalValue'] = this.abnormalValue;
  data['CriticalValue'] = this.criticalValue;
  data['StatusCode'] = this.statusCode;
  data['Provider'] = this.provider;
  data['UnitName'] = this.unitName;
  data['EncodedDate'] = this.encodedDate;
  data['ResultId'] = this.resultId;
  data['FieldName'] = this.fieldName;
  data['FieldId'] = this.fieldId;
  data['ErrorMessage'] = this.errorMessage;
  data['MethodName'] = this.methodName;
  data['ServiceRemarks'] = this.serviceRemarks;
  data['ValueWordProcessor'] = this.valueWordProcessor;
  data['FieldType'] = this.fieldType;
  data['SequenceNo'] = this.sequenceNo;
  data['PDFURL'] = this.pDFURL;
  data['IsGraph'] = this.isGraph;
  return data;
  }
  }