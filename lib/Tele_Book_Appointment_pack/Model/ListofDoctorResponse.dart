class ListofDoctorResponse {
  List<DoctorList>? doctorList;
  String? status;
  String? msg;

  ListofDoctorResponse({this.doctorList, this.status, this.msg});

  ListofDoctorResponse.fromJson(Map<String, dynamic> json) {
    if (json['DoctorList'] != null) {
      doctorList= <DoctorList>[];
      json['DoctorList'].forEach((v) {
        doctorList!.add(new DoctorList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorList != null) {
      data['DoctorList'] = this.doctorList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class DoctorList {
  int? iD;
  String? name;
  String? resultType;
  int? facilityId;
  String? specialisationName;
  String? doctorImagePath;
  String? education;
  String? designation;
  String? doctorCharge;
  String? webProfileId;
  String? shiftFirstFrom;
  String? shiftFirstTo;

  DoctorList(
      {this.iD,
        this.name,
        this.resultType,
        this.facilityId,
        this.specialisationName,
        this.doctorImagePath,
        this.education,
        this.designation,
        this.doctorCharge,
        this.webProfileId,
        this.shiftFirstFrom,
        this.shiftFirstTo});

  DoctorList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    resultType = json['ResultType'];
    facilityId = json['FacilityId'];
    specialisationName = json['SpecialisationName'];
    doctorImagePath = json['DoctorImagePath'];
    education = json['Education'];
    designation = json['Designation'];
    doctorCharge = json['DoctorCharge'];
    webProfileId = json['WebProfileId'];
    shiftFirstFrom = json['ShiftFirstFrom'];
    shiftFirstTo = json['ShiftFirstTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['ResultType'] = this.resultType;
    data['FacilityId'] = this.facilityId;
    data['SpecialisationName'] = this.specialisationName;
    data['DoctorImagePath'] = this.doctorImagePath;
    data['Education'] = this.education;
    data['Designation'] = this.designation;
    data['DoctorCharge'] = this.doctorCharge;
    data['WebProfileId'] = this.webProfileId;
    data['ShiftFirstFrom'] = this.shiftFirstFrom;
    data['ShiftFirstTo'] = this.shiftFirstTo;
    return data;
  }
}