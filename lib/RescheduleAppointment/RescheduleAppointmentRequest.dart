class RescheduleAppointmentRequest {
  int? facilityId;
  int? appointmentId;
  String? doctorId;
  String? appointmentDate;
  String? registrationId;
  String? fromTime;
  String? appointmentSource;
  String? rescheduleReason;
  RescheduleAppointmentRequest(
      {
        this.facilityId,
        this.appointmentId,
        this.doctorId,
        this.appointmentDate,
        this.registrationId,
        this.fromTime,
        this.appointmentSource,
        this.rescheduleReason,

      });

  RescheduleAppointmentRequest.fromJson(Map<String, dynamic> json) {
    facilityId = json['FacilityId'];
    appointmentId = json['AppointmentId'];
    doctorId = json['DoctorId'];
    appointmentDate = json['AppointmentDate'];
    registrationId = json['RegistrationId'];
    fromTime = json['FromTime'];
    appointmentSource = json['AppointmentSource'];
    rescheduleReason = json['RescheduleReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FacilityId'] = this.facilityId;
    data['AppointmentId'] = this.appointmentId;
    data['DoctorId'] = this.doctorId;
    data['AppointmentDate'] = this.appointmentDate;
    data['RegistrationId'] = this.registrationId;
    data['FromTime'] = this.fromTime;
    data['AppointmentSource'] = this.appointmentSource;
    data['RescheduleReason'] = this.rescheduleReason;
    return data;
  }
}