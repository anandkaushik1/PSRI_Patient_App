class SensitivityResponse {
  List<SensitivityDetailsarray>? sensitivityDetailsarray;
  String? status;
  String? msg;

  SensitivityResponse({this.sensitivityDetailsarray, this.status, this.msg});

  SensitivityResponse.fromJson(Map<String, dynamic> json) {
  if (json['SensitivityDetailsarray'] != null) {
  sensitivityDetailsarray= <SensitivityDetailsarray>[];
  json['SensitivityDetailsarray'].forEach((v) {
  sensitivityDetailsarray!.add(new SensitivityDetailsarray.fromJson(v));
  });
  }
  status = json['Status'];
  msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.sensitivityDetailsarray != null) {
  data['SensitivityDetailsarray'] =
  this.sensitivityDetailsarray!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  data['Msg'] = this.msg;
  return data;
  }
  }

  class SensitivityDetailsarray {
  int? organismId;
  int? antibioticId;
  String? organismName;
  String? antibioticName;
  String? interpretation;
  String? mIC;
  String? errorMessage;
  String? stage;
  String? release;

  SensitivityDetailsarray(
  {this.organismId,
  this.antibioticId,
  this.organismName,
  this.antibioticName,
  this.interpretation,
  this.mIC,
  this.errorMessage,
  this.stage,
  this.release});

  SensitivityDetailsarray.fromJson(Map<String, dynamic> json) {
  organismId = json['OrganismId'];
  antibioticId = json['AntibioticId'];
  organismName = json['OrganismName'];
  antibioticName = json['AntibioticName'];
  interpretation = json['Interpretation'];
  mIC = json['MIC'];
  errorMessage = json['ErrorMessage'];
  stage = json['Stage'];
  release = json['Release'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['OrganismId'] = this.organismId;
  data['AntibioticId'] = this.antibioticId;
  data['OrganismName'] = this.organismName;
  data['AntibioticName'] = this.antibioticName;
  data['Interpretation'] = this.interpretation;
  data['MIC'] = this.mIC;
  data['ErrorMessage'] = this.errorMessage;
  data['Stage'] = this.stage;
  data['Release'] = this.release;
  return data;
  }
  }