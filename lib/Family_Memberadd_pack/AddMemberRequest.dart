class AddMemberRequest {
  String? address;
  String? dOB;
  String? email;
  String? facilityID;
  String? firstName;
  String? gender;
  String? hospitalLocationId;
  String? lastName;
  String? middleName;
  String? mobile;
  String? oTP;
  String? paymentFlag;
  String? titleId;
  String? IsUnRegPat;
  bool? isFamilyMember;

  AddMemberRequest(
      {this.address,
        this.dOB,
        this.email,
        this.facilityID,
        this.firstName,
        this.gender,
        this.hospitalLocationId,
        this.lastName,
        this.middleName,
        this.mobile,
        this.oTP,
        this.paymentFlag,
        this.titleId,
        this.IsUnRegPat,
        this.isFamilyMember


      });

  AddMemberRequest.fromJson(Map<String, dynamic> json) {
    address = json['Address'];
    dOB = json['DOB'];
    email = json['Email'];
    facilityID = json['FacilityID'];
    firstName = json['FirstName'];
    gender = json['Gender'];
    hospitalLocationId = json['HospitalLocationId'];
    lastName = json['LastName'];
    middleName = json['MiddleName'];
    mobile = json['Mobile'];
    oTP = json['OTP'];
    paymentFlag = json['PaymentFlag'];
    titleId = json['TitleId'];
    IsUnRegPat = json['IsUnRegPat'];
    isFamilyMember = json['IsFamilyMember'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Address'] = this.address;
    data['DOB'] = this.dOB;
    data['Email'] = this.email;
    data['FacilityID'] = this.facilityID;
    data['FirstName'] = this.firstName;
    data['Gender'] = this.gender;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['LastName'] = this.lastName;
    data['MiddleName'] = this.middleName;
    data['Mobile'] = this.mobile;
    data['OTP'] = this.oTP;
    data['PaymentFlag'] = this.paymentFlag;
    data['TitleId'] = this.titleId;
    data['IsUnRegPat'] = this.IsUnRegPat;
    data['IsFamilyMember'] = this.isFamilyMember;
    return data;
  }
}