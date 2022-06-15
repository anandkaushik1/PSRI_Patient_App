class Favourite_Doctor_Request {
  String? departmentId;
  String? hospitalLocationId;
  String? mobileno;
  String? parameterType;

  Favourite_Doctor_Request(
      {this.departmentId,
        this.hospitalLocationId,
        this.mobileno,
        this.parameterType});

  Favourite_Doctor_Request.fromJson(Map<String, dynamic> json) {
    departmentId = json['DepartmentId'];
    hospitalLocationId = json['HospitalLocationId'];
    mobileno = json['Mobileno'];
    parameterType = json['ParameterType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentId'] = this.departmentId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['Mobileno'] = this.mobileno;
    data['ParameterType'] = this.parameterType;
    return data;
  }
}

