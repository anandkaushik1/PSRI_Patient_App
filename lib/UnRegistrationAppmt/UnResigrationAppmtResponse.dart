class UnResigrationAppmtResponse {
  String? appointmentId;
  String? errorMessage;
  String? status;

  UnResigrationAppmtResponse({this.appointmentId, this.errorMessage, this.status});

  UnResigrationAppmtResponse.fromJson(Map<String, dynamic> json) {
    appointmentId = json['AppointmentId'];
    errorMessage = json['ErrorMessage'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AppointmentId'] = this.appointmentId;
    data['ErrorMessage'] = this.errorMessage;
    data['Status'] = this.status;
    return data;
  }
}