class UpdateRequest {
  String?  hospitalId;
  String?  packageName;
  String?  versionName;
  int? versionCode;

  UpdateRequest(
      {this.hospitalId, this.packageName, this.versionName, this.versionCode});

  UpdateRequest.fromJson(Map<String, dynamic> json) {
    hospitalId = json['HospitalId'];
    packageName = json['PackageName'];
    versionName = json['VersionName'];
    versionCode = json['versionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HospitalId'] = this.hospitalId;
    data['PackageName'] = this.packageName;
    data['VersionName'] = this.versionName;
    data['versionCode'] = this.versionCode;
    return data;
  }
}