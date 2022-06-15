
class ViewAppointmentResponse {
  List<AppointmentListJSon>? appointmentListJSon;
  String? status;
  String? msg;

  ViewAppointmentResponse(
      {this.appointmentListJSon, this.status, this.msg});

  ViewAppointmentResponse.fromJson(Map<String, dynamic> json) {
    if (json['AppointmentListJSon'] != null) {
      appointmentListJSon= <AppointmentListJSon>[];
      json['AppointmentListJSon'].forEach((v) {
        appointmentListJSon!.add(new AppointmentListJSon.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointmentListJSon != null) {
      data['AppointmentListJSon'] =
          this.appointmentListJSon!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;

    return data;
  }
}

class AppointmentListJSon {
  int? appointmentId;
  String? registrationNo;
  String? appointmentDate;
  String? fromTime;
  int? facilityID;
  int? hospitalLocationId;
  int? doctorId;
  String? doctorName;
  String? errorMessage;
  String? specialisationName;
  String? doctorImagePath;
  String? education;
  String? designation;
  String? patientName;
  String? paymentStatus;
  String? doctorCharge;
  String? amount;
  String? transactionNo;
  String? appointmentType;
  String? vCStart;
  String? vCClose;
  String? vCMessage;
  bool? isTeleConsultation;
  String? Remarks;
  int? RegistrationId;
  AppointmentListJSon(
      {this.appointmentId,
        this.registrationNo,
        this.appointmentDate,
        this.fromTime,
        this.facilityID,
        this.hospitalLocationId,
        this.doctorId,
        this.doctorName,
        this.errorMessage,
        this.specialisationName,
        this.doctorImagePath,
        this.education,
        this.designation,
        this.patientName,
        this.paymentStatus,
        this.doctorCharge,
        this.amount,
        this.transactionNo,
        this.appointmentType,
        this.vCStart,
        this.vCClose,
        this.vCMessage,
        this.Remarks,
        this.isTeleConsultation,
        this.RegistrationId
      });

  AppointmentListJSon.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    registrationNo = json['RegistrationNo'];
    appointmentDate = json['AppointmentDate'];
    fromTime = json['FromTime'];
    facilityID = json['FacilityID'];
    hospitalLocationId = json['HospitalLocationId'];
    doctorId = json['DoctorId'];
    doctorName = json['DoctorName'];
    errorMessage = json['ErrorMessage'];
    specialisationName = json['SpecialisationName'];
    doctorImagePath = json['DoctorImagePath'];
    education = json['Education'];
    designation = json['Designation'];
    patientName = json['patientName'];
    paymentStatus = json['PaymentStatus'];
    doctorCharge = json['DoctorCharge'];
    amount = json['Amount'];
    transactionNo = json['TransactionNo'];
    appointmentType = json['AppointmentType'];
    vCStart = json['VCStart'];
    vCClose = json['VCClose'];
    vCMessage = json['VCMessage'];
    isTeleConsultation = json['IsTeleConsultation'];
    Remarks = json['Remarks'];
    RegistrationId = json['RegistrationId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['RegistrationNo'] = this.registrationNo;
    data['AppointmentDate'] = this.appointmentDate;
    data['FromTime'] = this.fromTime;
    data['FacilityID'] = this.facilityID;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['DoctorId'] = this.doctorId;
    data['DoctorName'] = this.doctorName;
    data['ErrorMessage'] = this.errorMessage;
    data['SpecialisationName'] = this.specialisationName;
    data['DoctorImagePath'] = this.doctorImagePath;
    data['Education'] = this.education;
    data['Designation'] = this.designation;
    data['patientName'] = this.patientName;
    data['PaymentStatus'] = this.paymentStatus;
    data['DoctorCharge'] = this.doctorCharge;
    data['Amount'] = this.amount;
    data['TransactionNo'] = this.transactionNo;
    data['AppointmentType'] = this.appointmentType;
    data['VCStart'] = this.vCStart;
    data['VCClose'] = this.vCClose;
    data['VCMessage'] = this.vCMessage;
    data['IsTeleConsultation'] = this.isTeleConsultation;
    data['Remarks'] = this.Remarks;
    data['RegistrationId'] = this.RegistrationId;
    return data;
  }
}
