class Favourite_Doctor_Response {
  List<GetDoctorListArrayy>? getDoctorListArrayy;
  String? status;
  String? msg;

  Favourite_Doctor_Response({this.getDoctorListArrayy, this.status, this.msg});

  Favourite_Doctor_Response.fromJson(Map<String, dynamic> json) {
    if (json['GetDoctorListArrayy'] != null) {
      getDoctorListArrayy= <GetDoctorListArrayy>[];
      json['GetDoctorListArrayy'].forEach((v) {
        getDoctorListArrayy!.add(new GetDoctorListArrayy.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDoctorListArrayy != null || this.getDoctorListArrayy != "") {
      data['GetDoctorListArrayy'] =
          this.getDoctorListArrayy!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class GetDoctorListArrayy {
  int? doctorId;
  String? doctorName;
  int? departmentId;
  String? errorMessage;
  String? designation;
  String? education;
  String? parameterType;
  String? facilityId;
  int? hospitalLocationId;
  String? doctorImg;
  String? specialisationName;
  String? doctorCharge;
  String? mobileno;
  String? webProfileId;

  GetDoctorListArrayy(
      {this.doctorId,
        this.doctorName,
        this.departmentId,
        this.errorMessage,
        this.designation,
        this.education,
        this.parameterType,
        this.facilityId,
        this.hospitalLocationId,
        this.doctorImg,
        this.specialisationName,
        this.doctorCharge,
        this.mobileno,
        this.webProfileId});

  GetDoctorListArrayy.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    departmentId = json['DepartmentId'];
    errorMessage = json['ErrorMessage'];
    designation = json['Designation'];
    education = json['Education'];
    parameterType = json['ParameterType'];
    facilityId = json['FacilityId'];
    hospitalLocationId = json['HospitalLocationId'];
    doctorImg = json['DoctorImg'];
    specialisationName = json['SpecialisationName'];
    doctorCharge = json['DoctorCharge'];
    mobileno = json['Mobileno'];
    webProfileId = json['WebProfileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['DoctorName'] = this.doctorName;
    data['DepartmentId'] = this.departmentId;
    data['ErrorMessage'] = this.errorMessage;
    data['Designation'] = this.designation;
    data['Education'] = this.education;
    data['ParameterType'] = this.parameterType;
    data['FacilityId'] = this.facilityId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['DoctorImg'] = this.doctorImg;
    data['SpecialisationName'] = this.specialisationName;
    data['DoctorCharge'] = this.doctorCharge;
    data['Mobileno'] = this.mobileno;
    data['WebProfileId'] = this.webProfileId;
    return data;
  }
}

