class PayRespose {
  String?  status;
  String?  msg;
  String?  getId;

  PayRespose({this.status, this.msg, this.getId});

  PayRespose.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}