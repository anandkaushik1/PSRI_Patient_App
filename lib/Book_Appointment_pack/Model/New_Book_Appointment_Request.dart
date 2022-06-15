class New_Book_Appointment_Request
{
  String? ageDay;
  String? ageMonth;
  String? ageYear;
  String? appFromTime;
  String? appToTime;
  String? appointmentDate;
  String? appointmentSource;
  String? authorizationNo;
  String? dOB;
  String? doctorId;
  String? email;
  String? facilityID;
  String? fullName;
  String? gender;
  String? hospitalLocationId;
  String? mobile;
  String? packageId;
  String? paymentModeId;
  String? registrationNo;
  String? remarks;
  String? titleId;
  String? visitTypeId;

  New_Book_Appointment_Request(
      {this.ageDay,
        this.ageMonth,
        this.ageYear,
        this.appFromTime,
        this.appToTime,
        this.appointmentDate,
        this.appointmentSource,
        this.authorizationNo,
        this.dOB,
        this.doctorId,
        this.email,
        this.facilityID,
        this.fullName,
        this.gender,
        this.hospitalLocationId,
        this.mobile,
        this.packageId,
        this.paymentModeId,
        this.registrationNo,
        this.remarks,
        this.titleId,
        this.visitTypeId});

  New_Book_Appointment_Request.fromJson(Map<String, dynamic> json) {
    ageDay = json['AgeDay'];
    ageMonth = json['AgeMonth'];
    ageYear = json['AgeYear'];
    appFromTime = json['AppFromTime'];
    appToTime = json['AppToTime'];
    appointmentDate = json['AppointmentDate'];
    appointmentSource = json['AppointmentSource'];
    authorizationNo = json['AuthorizationNo'];
    dOB = json['DOB'];
    doctorId = json['DoctorId'];
    email = json['Email'];
    facilityID = json['FacilityID'];
    fullName = json['FullName'];
    gender = json['Gender'];
    hospitalLocationId = json['HospitalLocationId'];
    mobile = json['Mobile'];
    packageId = json['PackageId'];
    paymentModeId = json['PaymentModeId'];
    registrationNo = json['RegistrationNo'];
    remarks = json['Remarks'];
    titleId = json['TitleId'];
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
    data['AuthorizationNo'] = this.authorizationNo;
    data['DOB'] = this.dOB;
    data['DoctorId'] = this.doctorId;
    data['Email'] = this.email;
    data['FacilityID'] = this.facilityID;
    data['FullName'] = this.fullName;
    data['Gender'] = this.gender;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['Mobile'] = this.mobile;
    data['PackageId'] = this.packageId;
    data['PaymentModeId'] = this.paymentModeId;
    data['RegistrationNo'] = this.registrationNo;
    data['Remarks'] = this.remarks;
    data['TitleId'] = this.titleId;
    data['VisitTypeId'] = this.visitTypeId;
    return data;
  }
}