class viewDocumentRequest {
  String? registrationId;
  String? guestId;


  viewDocumentRequest({this.registrationId,this.guestId});

  viewDocumentRequest.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    guestId = json['GuestId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['GuestId'] = this.guestId;
    return data;
  }
}