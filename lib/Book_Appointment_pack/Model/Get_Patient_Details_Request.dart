class Get_Patient_Details_Request {
  String? registrationNo;

  Get_Patient_Details_Request({this.registrationNo});

  Get_Patient_Details_Request.fromJson(Map<String, dynamic> json) {
    registrationNo = json['RegistrationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationNo'] = this.registrationNo;
    return data;
  }
}