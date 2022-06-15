class Appmt_Slot_Response {
  List<GetDoctorAppointmentSlotJsonListArray>?
  getDoctorAppointmentSlotJsonListArray;
  String? status;
  String? msg;

  Appmt_Slot_Response(
      {this.getDoctorAppointmentSlotJsonListArray, this.status, this.msg});

  Appmt_Slot_Response.fromJson(Map<String, dynamic> json) {
    if (json['GetDoctorAppointmentSlotJsonListArray'] != null) {
      getDoctorAppointmentSlotJsonListArray =
      <GetDoctorAppointmentSlotJsonListArray>[];
      json['GetDoctorAppointmentSlotJsonListArray'].forEach((v) {
        getDoctorAppointmentSlotJsonListArray
            !.add(new GetDoctorAppointmentSlotJsonListArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.getDoctorAppointmentSlotJsonListArray != null) {
      data['GetDoctorAppointmentSlotJsonListArray'] = this
          .getDoctorAppointmentSlotJsonListArray!
          .map((v) => v.toJson())
          .toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class GetDoctorAppointmentSlotJsonListArray {
  String? appointmentTime;
  String? appointmentTimeAmPm;
  String? appointmentSlot;
  int? statusBooked;
  String? errorMessage;
  String? next;

  GetDoctorAppointmentSlotJsonListArray(
      {this.appointmentTime,
        this.appointmentTimeAmPm,
        this.appointmentSlot,
        this.statusBooked,
        this.errorMessage,
        this.next});

  GetDoctorAppointmentSlotJsonListArray.fromJson(Map<String, dynamic> json) {
    appointmentTime = json['AppointmentTime'];
    appointmentTimeAmPm = json['AppointmentTimeAmPm'];
    appointmentSlot = json['AppointmentSlot'];
    statusBooked = json['StatusBooked'];
    errorMessage = json['ErrorMessage'];
    next = json['Next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentTime'] = this.appointmentTime;
    data['AppointmentTimeAmPm'] = this.appointmentTimeAmPm;
    data['AppointmentSlot'] = this.appointmentSlot;
    data['StatusBooked'] = this.statusBooked;
    data['ErrorMessage'] = this.errorMessage;
    data['Next'] = this.next;
    return data;
  }
}