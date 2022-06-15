

class Lab_Garph_View_Response {

  List<ResultGraphList>? resultGraphList;
  String? status;
  String? msg;

  Lab_Garph_View_Response({this.resultGraphList, this.status, this.msg});

  Lab_Garph_View_Response.fromJson(Map<String, dynamic> json) {
  if (json['ResultGraphList'] != null) {
  resultGraphList= <ResultGraphList>[];
  json['ResultGraphList'].forEach((v) {
  resultGraphList!.add(new ResultGraphList.fromJson(v));
  });
  }
  status = json['Status'];
  msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.resultGraphList != null) {
  data['ResultGraphList'] =
  this.resultGraphList!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  data['Msg'] = this.msg;
  return data;
  }
  }

  class ResultGraphList {
  int? diagSampleId;
  int? fieldId;
  String? fieldValue;
  String? entryDate;
  String? entryDate1;
  String? unitName;
  String? minValue;
  String? maxValue;
  String? symbol;

  ResultGraphList(
  {this.diagSampleId,
  this.fieldId,
  this.fieldValue,
  this.entryDate,
  this.entryDate1,
  this.unitName,
  this.minValue,
  this.maxValue,
  this.symbol});

  ResultGraphList.fromJson(Map<String, dynamic> json) {
  diagSampleId = json['DiagSampleId'];
  fieldId = json['FieldId'];
  fieldValue = json['FieldValue'];
  entryDate = json['EntryDate'];
  entryDate1 = json['EntryDate1'];
  unitName = json['UnitName'];
  minValue = json['MinValue'];
  maxValue = json['MaxValue'];
  symbol = json['Symbol'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['DiagSampleId'] = this.diagSampleId;
  data['FieldId'] = this.fieldId;
  data['FieldValue'] = this.fieldValue;
  data['EntryDate'] = this.entryDate;
  data['EntryDate1'] = this.entryDate1;
  data['UnitName'] = this.unitName;
  data['MinValue'] = this.minValue;
  data['MaxValue'] = this.maxValue;
  data['Symbol'] = this.symbol;
  return data;
  }
  }