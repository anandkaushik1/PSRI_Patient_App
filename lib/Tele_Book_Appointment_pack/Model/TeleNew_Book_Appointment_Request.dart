class TeleNew_Book_Appointment_Request {
  String? ageday;
  String? agemonth;
  String? ageyear;
  String? appfromtime;
  String? apptotime;
  String? appointmentdate;
  String? appointmentsource;
  String? authorizationno;
  String? dob;
  String? doctorid;
  String? email;
  String? facilityID;
  String? fullName;
  String? gender;
  String? hospitalLocationId;
  String? isTeleConsultation;
  String? mobile;
  String? packageId;
  String? paymentModeId;
  String? registrationNo;
  String? remarks;
  String? titleId;
  String? visitTypeId;
  bool? IsUnRegPat;
  bool? IsPayNow;
  TeleNew_Book_Appointment_Request(
      {this.ageday,
        this.agemonth,
        this.ageyear,
        this.appfromtime,
        this.apptotime,
        this.appointmentdate,
        this.appointmentsource,
        this.authorizationno,
        this.dob,
        this.doctorid,
        this.email,
        this.facilityID,
        this.fullName,
        this.gender,
        this.hospitalLocationId,
        this.isTeleConsultation,
        this.mobile,
        this.packageId,
        this.paymentModeId,
        this.registrationNo,
        this.titleId,
        this.IsUnRegPat,
        this.remarks,
        this.IsPayNow,
        this.visitTypeId});

  TeleNew_Book_Appointment_Request.fromJson(Map<String, dynamic> json) {
    ageday = json['ageday'];
    agemonth = json['agemonth'];
    ageyear = json['ageyear'];
    appfromtime = json['appfromtime'];
    apptotime = json['apptotime'];
    appointmentdate = json['appointmentdate'];
    appointmentsource = json['appointmentsource'];
    authorizationno = json['authorizationno'];
    dob = json['dob'];
    doctorid = json['doctorid'];
    email = json['email'];
    facilityID = json['FacilityID'];
    fullName = json['FullName'];
    gender = json['Gender'];
    hospitalLocationId = json['HospitalLocationId'];
    isTeleConsultation = json['IsTeleConsultation'];
    mobile = json['Mobile'];
    packageId = json['PackageId'];
    paymentModeId = json['PaymentModeId'];
    registrationNo = json['RegistrationNo'];
    titleId = json['TitleId'];
    visitTypeId = json['VisitTypeId'];
    IsUnRegPat = json['IsUnRegPat'];
    IsPayNow = json['IsPayNow'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ageday'] = this.ageday;
    data['agemonth'] = this.agemonth;
    data['ageyear'] = this.ageyear;
    data['appfromtime'] = this.appfromtime;
    data['apptotime'] = this.apptotime;
    data['appointmentdate'] = this.appointmentdate;
    data['appointmentsource'] = this.appointmentsource;
    data['authorizationno'] = this.authorizationno;
    data['dob'] = this.dob;
    data['doctorid'] = this.doctorid;
    data['email'] = this.email;
    data['FacilityID'] = this.facilityID;
    data['FullName'] = this.fullName;
    data['Gender'] = this.gender;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['IsTeleConsultation'] = this.isTeleConsultation;
    data['Mobile'] = this.mobile;
    data['PackageId'] = this.packageId;
    data['PaymentModeId'] = this.paymentModeId;
    data['RegistrationNo'] = this.registrationNo;
    data['TitleId'] = this.titleId;
    data['VisitTypeId'] = this.visitTypeId;
    data['IsUnRegPat'] = this.IsUnRegPat;
    data['IsPayNow'] = this.IsPayNow;
    data['Remarks'] = this.remarks;
    return data;
  }
}