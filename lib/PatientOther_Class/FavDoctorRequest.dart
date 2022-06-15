class FavDoctorRequest {
  String?  departmentId;
  String?  hospitalLocationId;
  String?  mobileno;
  String?  parameterType;
  String?  tCDoctor;

  FavDoctorRequest(
      {this.departmentId,
        this.hospitalLocationId,
        this.mobileno,
        this.parameterType,
        this.tCDoctor});

  FavDoctorRequest.fromJson(Map<String, dynamic> json) {
    departmentId = json['DepartmentId'];
    hospitalLocationId = json['HospitalLocationId'];
    mobileno = json['Mobileno'];
    parameterType = json['ParameterType'];
    tCDoctor = json['TCDoctor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentId'] = this.departmentId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['Mobileno'] = this.mobileno;
    data['ParameterType'] = this.parameterType;
    data['TCDoctor'] = this.tCDoctor;
    return data;
  }
}