class UnResigrationAppmtRequest {
  String? ageDay;
  String? ageMonth;
  String? ageYear;
  String? appFromTime;
  String? appToTime;
  String? appointmentDate;
  String? appointmentSource;
  String? dOB;
  String? doctorId;
  String? facilityID;
  String? fullName;
  String? gender;
  String? hospitalLocationId;
  String? mobile;
  String? visitTypeId;

  UnResigrationAppmtRequest(
      {this.ageDay,
        this.ageMonth,
        this.ageYear,
        this.appFromTime,
        this.appToTime,
        this.appointmentDate,
        this.appointmentSource,
        this.dOB,
        this.doctorId,
        this.facilityID,
        this.fullName,
        this.gender,
        this.hospitalLocationId,
        this.mobile,
        this.visitTypeId});

  UnResigrationAppmtRequest.fromJson(Map<String, dynamic> json) {
    ageDay = json['AgeDay'];
    ageMonth = json['AgeMonth'];
    ageYear = json['AgeYear'];
    appFromTime = json['AppFromTime'];
    appToTime = json['AppToTime'];
    appointmentDate = json['AppointmentDate'];
    appointmentSource = json['AppointmentSource'];
    dOB = json['DOB'];
    doctorId = json['DoctorId'];
    facilityID = json['FacilityID'];
    fullName = json['FullName'];
    gender = json['Gender'];
    hospitalLocationId = json['HospitalLocationId'];
    mobile = json['Mobile'];
    visitTypeId = json['VisitTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AgeDay'] = this.ageDay;
    data['AgeMonth'] = this.ageMonth;
    data['AgeYear'] = this.ageYear;
    data['AppFromTime'] = this.appFromTime;
    data['AppToTime'] = this.appToTime;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointmentSource'] = this.appointmentSource;
    data['DOB'] = this.dOB;
    data['DoctorId'] = this.doctorId;
    data['FacilityID'] = this.facilityID;
    data['FullName'] = this.fullName;
    data['Gender'] = this.gender;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['Mobile'] = this.mobile;
    data['VisitTypeId'] = this.visitTypeId;
    return data;
  }
}