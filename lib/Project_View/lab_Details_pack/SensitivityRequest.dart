class SensitivityRequest {
  String? source;
  String? diagSampleId;
  String? resultId;

  SensitivityRequest({this.source, this.diagSampleId, this.resultId});

  SensitivityRequest.fromJson(Map<String, dynamic> json) {
    source = json['Source'];
    diagSampleId = json['DiagSampleId'];
    resultId = json['ResultId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Source'] = this.source;
    data['DiagSampleId'] = this.diagSampleId;
    data['ResultId'] = this.resultId;
    return data;
  }
}