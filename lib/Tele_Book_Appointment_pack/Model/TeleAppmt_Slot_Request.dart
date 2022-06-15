class TeleAppmt_Slot_Request {
  String? appointmentDate;
  String? doctorId;
  int? facilityID;
  bool? isTeleConsultation;

  TeleAppmt_Slot_Request(
      {this.appointmentDate,
        this.doctorId,
        this.facilityID,
        this.isTeleConsultation});

  TeleAppmt_Slot_Request.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['AppointmentDate'];
    doctorId = json['DoctorId'];
    facilityID = json['FacilityID'];
    isTeleConsultation = json['IsTeleConsultation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentDate'] = this.appointmentDate;
    data['DoctorId'] = this.doctorId;
    data['FacilityID'] = this.facilityID;
    data['IsTeleConsultation'] = this.isTeleConsultation;
    return data;
  }
}