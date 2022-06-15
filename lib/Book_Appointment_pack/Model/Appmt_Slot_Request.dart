class Appmt_slot_Request {
  String? appointmentDate;
  String? doctorId;
  String? facilityID;

  Appmt_slot_Request({this.appointmentDate, this.doctorId, this.facilityID});

  Appmt_slot_Request.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['AppointmentDate'];
    doctorId = json['DoctorId'];
    facilityID = json['FacilityID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentDate'] = this.appointmentDate;
    data['DoctorId'] = this.doctorId;
    data['FacilityID'] = this.facilityID;
    return data;
  }
}