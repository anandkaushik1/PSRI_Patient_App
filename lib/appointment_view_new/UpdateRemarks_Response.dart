class Remarks_Response {
  String? status;
  String? msg;

  Remarks_Response({this.status, this.msg});

  Remarks_Response.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}