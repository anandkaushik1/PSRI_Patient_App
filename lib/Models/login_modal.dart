import 'package:json_annotation/json_annotation.dart';
class login_model {
  String?  password;
  String?  userName;
  String?  userType;

  login_model({this.password, this.userName, this.userType});

  login_model.fromJson(Map<String, dynamic> json) {
    password = json['Password'];
    userName = json['UserName'];
    userType = json['UserType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Password'] = this.password;
    data['UserName'] = this.userName;
    data['UserType'] = this.userType;
    return data;
  }
}



