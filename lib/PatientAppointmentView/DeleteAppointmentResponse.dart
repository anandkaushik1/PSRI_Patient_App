class DeleteAppointmentResponse {
  String?  cancelMessage;

  DeleteAppointmentResponse({this.cancelMessage});

  DeleteAppointmentResponse.fromJson(Map<String, dynamic> json) {
    cancelMessage = json['CancelMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CancelMessage'] = this.cancelMessage;
    return data;
  }
}