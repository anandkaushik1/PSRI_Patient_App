class Login_Response {
  String?  userId;
  String?  employeeId;
  String?  errorMessage;
  String?  hospitalLocationId;
  List<Facility>? facility;
  String?  doctorName;
  String?  specilaisation;
  String?  doctorEducation1;
  String?  doctorEducation2;
  String?  doctorEducation3;
  String?  departmentName;
  String?  firstConsultationCharge;
  String?  followupConsultationCharge;
  bool? isTeam;
  String?  employeeType;
  String?  status;
  String?  msg;

  Login_Response(
      {this.userId,
        this.employeeId,
        this.errorMessage,
        this.hospitalLocationId,
        this.facility,
        this.doctorName,
        this.specilaisation,
        this.doctorEducation1,
        this.doctorEducation2,
        this.doctorEducation3,
        this.departmentName,
        this.firstConsultationCharge,
        this.followupConsultationCharge,
        this.isTeam,
        this.employeeType,
        this.status,
        this.msg});

  Login_Response.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    employeeId = json['EmployeeId'];
    errorMessage = json['ErrorMessage'];
    hospitalLocationId = json['HospitalLocationId'];
    if (json['Facility'] != null) {
      facility= <Facility>[];
      json['Facility'].forEach((v) {
        facility!.add(new Facility.fromJson(v));
      });
    }
    doctorName = json['DoctorName'];
    specilaisation = json['Specilaisation'];
    doctorEducation1 = json['DoctorEducation1'];
    doctorEducation2 = json['DoctorEducation2'];
    doctorEducation3 = json['DoctorEducation3'];
    departmentName = json['DepartmentName'];
    firstConsultationCharge = json['FirstConsultationCharge'];
    followupConsultationCharge = json['FollowupConsultationCharge'];
    isTeam = json['IsTeam'];
    employeeType = json['EmployeeType'];
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['EmployeeId'] = this.employeeId;
    data['ErrorMessage'] = this.errorMessage;
    data['HospitalLocationId'] = this.hospitalLocationId;
    if (this.facility != null) {
      data['Facility'] = this.facility!.map((v) => v.toJson()).toList();
    }
    data['DoctorName'] = this.doctorName;
    data['Specilaisation'] = this.specilaisation;
    data['DoctorEducation1'] = this.doctorEducation1;
    data['DoctorEducation2'] = this.doctorEducation2;
    data['DoctorEducation3'] = this.doctorEducation3;
    data['DepartmentName'] = this.departmentName;
    data['FirstConsultationCharge'] = this.firstConsultationCharge;
    data['FollowupConsultationCharge'] = this.followupConsultationCharge;
    data['IsTeam'] = this.isTeam;
    data['EmployeeType'] = this.employeeType;
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class Facility {
  int? facilityid;
  String?  facilityName;

  Facility({this.facilityid, this.facilityName});

  Facility.fromJson(Map<String, dynamic> json) {
    facilityid = json['Facilityid'];
    facilityName = json['FacilityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Facilityid'] = this.facilityid;
    data['FacilityName'] = this.facilityName;
    return data;
  }
}