class Book_Appointment_Response {
  List<DoctorAppAppointmentSchedule>? doctorAppAppointmentSchedule;
  String? status;
  String? msg;

  Book_Appointment_Response({this.doctorAppAppointmentSchedule, this.status, this.msg});

  Book_Appointment_Response.fromJson(Map<String, dynamic> json) {
    if (json['DoctorAppAppointmentSchedule'] != null) {
      doctorAppAppointmentSchedule= <DoctorAppAppointmentSchedule>[];
      json['DoctorAppAppointmentSchedule'].forEach((v) {
        doctorAppAppointmentSchedule
            !.add(new DoctorAppAppointmentSchedule.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctorAppAppointmentSchedule != null) {
      data['DoctorAppAppointmentSchedule'] =
          this.doctorAppAppointmentSchedule!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class DoctorAppAppointmentSchedule {
  String? doctorId;
  String? doctorName;
  String? fromDate;
  String? toDate;
  String? patientName;
  String? bookingStatus;
  String? appointmentTime;
  String? referBy;
  String? appointmentDate;
  String? appointMentId;
  String? hospitalLocationId;
  String? facilityId;
  String? slotStatus;
  String? ageYear;
  String? gender;
  String? ageMonths;
  String? ageDays;
  String? mobile;
  String? companyType;
  String? registrationno;
  String? uHID;
  String? filter;
  String? registrationId;
  String? patientAgeGender;
  String? breakName;
  String? isAvailable;

  DoctorAppAppointmentSchedule(
      {this.doctorId,
        this.doctorName,
        this.fromDate,
        this.toDate,
        this.patientName,
        this.bookingStatus,
        this.appointmentTime,
        this.referBy,
        this.appointmentDate,
        this.appointMentId,
        this.hospitalLocationId,
        this.facilityId,
        this.slotStatus,
        this.ageYear,
        this.gender,
        this.ageMonths,
        this.ageDays,
        this.mobile,
        this.companyType,
        this.registrationno,
        this.uHID,
        this.filter,
        this.registrationId,
        this.patientAgeGender,
        this.breakName,
        this.isAvailable});

  DoctorAppAppointmentSchedule.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    patientName = json['PatientName'];
    bookingStatus = json['BookingStatus'];
    appointmentTime = json['AppointmentTime'];
    referBy = json['ReferBy'];
    appointmentDate = json['AppointmentDate'];
    appointMentId = json['AppointMentId'];
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    slotStatus = json['SlotStatus'];
    ageYear = json['AgeYear'];
    gender = json['Gender'];
    ageMonths = json['AgeMonths'];
    ageDays = json['AgeDays'];
    mobile = json['Mobile'];
    companyType = json['CompanyType'];
    registrationno = json['Registrationno'];
    uHID = json['UHID'];
    filter = json['Filter'];
    registrationId = json['RegistrationId'];
    patientAgeGender = json['PatientAgeGender'];
    breakName = json['BreakName'];
    isAvailable = json['IsAvailable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['DoctorName'] = this.doctorName;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['PatientName'] = this.patientName;
    data['BookingStatus'] = this.bookingStatus;
    data['AppointmentTime'] = this.appointmentTime;
    data['ReferBy'] = this.referBy;
    data['AppointmentDate'] = this.appointmentDate;
    data['AppointMentId'] = this.appointMentId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['SlotStatus'] = this.slotStatus;
    data['AgeYear'] = this.ageYear;
    data['Gender'] = this.gender;
    data['AgeMonths'] = this.ageMonths;
    data['AgeDays'] = this.ageDays;
    data['Mobile'] = this.mobile;
    data['CompanyType'] = this.companyType;
    data['Registrationno'] = this.registrationno;
    data['UHID'] = this.uHID;
    data['Filter'] = this.filter;
    data['RegistrationId'] = this.registrationId;
    data['PatientAgeGender'] = this.patientAgeGender;
    data['BreakName'] = this.breakName;
    data['IsAvailable'] = this.isAvailable;
    return data;
  }
}