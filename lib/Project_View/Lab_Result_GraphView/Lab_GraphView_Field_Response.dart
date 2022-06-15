class Lab_GraphView_Field_Response {
  List<ResultGraphFieldList>? resultGraphFieldList;
  String? status;
  String? msg;

  Lab_GraphView_Field_Response({this.resultGraphFieldList, this.status, this.msg});

  Lab_GraphView_Field_Response.fromJson(Map<String, dynamic> json) {
    if (json['ResultGraphFieldList'] != null) {
      resultGraphFieldList= <ResultGraphFieldList>[];
      json['ResultGraphFieldList'].forEach((v) {
        resultGraphFieldList!.add(new ResultGraphFieldList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resultGraphFieldList != null) {
      data['ResultGraphFieldList'] =
          this.resultGraphFieldList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class ResultGraphFieldList {
  int? fieldId;
  String? fieldName;
  String? fieldType;
  int? serviceId;
  int? sequenceNo;

  ResultGraphFieldList(
      {this.fieldId,
        this.fieldName,
        this.fieldType,
        this.serviceId,
        this.sequenceNo});

  ResultGraphFieldList.fromJson(Map<String, dynamic> json) {
    fieldId = json['FieldId'];
    fieldName = json['FieldName'];
    fieldType = json['FieldType'];
    serviceId = json['ServiceId'];
    sequenceNo = json['SequenceNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FieldId'] = this.fieldId;
    data['FieldName'] = this.fieldName;
    data['FieldType'] = this.fieldType;
    data['ServiceId'] = this.serviceId;
    data['SequenceNo'] = this.sequenceNo;
    return data;
  }
}