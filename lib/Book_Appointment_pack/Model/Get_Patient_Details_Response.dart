class Get_Patient_Details_Response {
  List<PatientDetailsArrayApmt>? patientDetailsArray;
  String? status;
  String? msg;

  Get_Patient_Details_Response({this.patientDetailsArray, this.status, this.msg});

  Get_Patient_Details_Response.fromJson(Map<String, dynamic> json) {
    if (json['PatientDetailsArray'] != null) {
      patientDetailsArray= <PatientDetailsArrayApmt>[];
      json['PatientDetailsArray'].forEach((v) {
        patientDetailsArray!.add(new PatientDetailsArrayApmt.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientDetailsArray != null) {
      data['PatientDetailsArray'] =
          this.patientDetailsArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class PatientDetailsArrayApmt {
  String? registrationNo;
  String? titleId;
  String? firstName;
  String? lastName;
  String? patientName;
  String? dOB;
  String? patientAgeGender;
  String? mobile;
  String? email;
  String? errorMessage;
  String? oPIP;
  String? bEDNo;
  String? doctorId;
  String? hospitalLocationId;
  String? facilityId;
  String? filter;
  int? encounterId;

  PatientDetailsArrayApmt(
      {this.registrationNo,
        this.titleId,
        this.firstName,
        this.lastName,
        this.patientName,
        this.dOB,
        this.patientAgeGender,
        this.mobile,
        this.email,
        this.errorMessage,
        this.oPIP,
        this.bEDNo,
        this.doctorId,
        this.hospitalLocationId,
        this.facilityId,
        this.filter,
        this.encounterId});

  PatientDetailsArrayApmt.fromJson(Map<String, dynamic> json) {
    registrationNo = json['RegistrationNo'];
    titleId = json['TitleId'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    patientName = json['PatientName'];
    dOB = json['DOB'];
    patientAgeGender = json['PatientAgeGender'];
    mobile = json['Mobile'];
    email = json['Email'];
    errorMessage = json['ErrorMessage'];
    oPIP = json['OPIP'];
    bEDNo = json['BEDNo'];
    doctorId = json['DoctorId'];
    hospitalLocationId = json['HospitalLocationId'];
    facilityId = json['FacilityId'];
    filter = json['Filter'];
    encounterId = json['EncounterId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationNo'] = this.registrationNo;
    data['TitleId'] = this.titleId;
    data['FirstName'] = this.firstName;
    data['LastName'] = this.lastName;
    data['PatientName'] = this.patientName;
    data['DOB'] = this.dOB;
    data['PatientAgeGender'] = this.patientAgeGender;
    data['Mobile'] = this.mobile;
    data['Email'] = this.email;
    data['ErrorMessage'] = this.errorMessage;
    data['OPIP'] = this.oPIP;
    data['BEDNo'] = this.bEDNo;
    data['DoctorId'] = this.doctorId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['FacilityId'] = this.facilityId;
    data['Filter'] = this.filter;
    data['EncounterId'] = this.encounterId;
    return data;
  }
}