class Login_Request {
  String?  password;
  String?  userName;

  Login_Request({this.password, this.userName});

  Login_Request.fromJson(Map<String, dynamic> json) {
    password = json['Password'];
    userName = json['UserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Password'] = this.password;
    data['UserName'] = this.userName;
    return data;
  }
}