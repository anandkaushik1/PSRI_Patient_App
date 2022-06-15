class PatientProfileUpdate {
  String?  email;
  String?  firstName;
  String?  lastName;
  String?  middleName;
  String?  mobileNo;
  String?  oldPassword;
  String?  password;
  String?  regNo;

  PatientProfileUpdate(
      {this.email,
        this.firstName,
        this.lastName,
        this.middleName,
        this.mobileNo,
        this.oldPassword,
        this.password,
        this.regNo});

  PatientProfileUpdate.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    middleName = json['MiddleName'];
    mobileNo = json['MobileNo'];
    oldPassword = json['OldPassword'];
    password = json['Password'];
    regNo = json['RegNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['MiddleName'] = this.middleName;
    data['MobileNo'] = this.mobileNo;
    data['OldPassword'] = this.oldPassword;
    data['Password'] = this.password;
    data['RegNo'] = this.regNo;
    return data;
  }
}