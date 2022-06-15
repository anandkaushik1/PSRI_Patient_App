class ListOfIpPatientResponse {
  List<PatientDetailsArray>? patientDetailsArray;
  String?  status;
  String?  msg;

  ListOfIpPatientResponse({this.patientDetailsArray, this.status, this.msg});

  ListOfIpPatientResponse.fromJson(Map<String, dynamic> json) {
    if (json['PatientDetailsArray'] != null) {
      patientDetailsArray= <PatientDetailsArray>[];
      json['PatientDetailsArray'].forEach((v) {
        patientDetailsArray!.add(new PatientDetailsArray.fromJson(v));
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

class PatientDetailsArray {
  String?  registrationId;
  String?  registrationNo;
  String?  encounterId;
  String?  encounterNo;
  String?  patientName;
  String?  appointmentTime;
  String?  lastVisit;
  String?  gender;
  String?  age;
  String?  ward;
  String?  bedId;
  String?  bedNo;
  String?  patientImage;
  String?  status;
  String?  vistStatus;
  String?  patientType;
  String?  mobileNo;
  String?  patientStatus;
  String?  accountcategory;
  String?  statusColor;
  String?  doctorName;
  String?  facilityId;
  String?  encounterDate;
  String?  companyType;
  bool? isReferred;

  PatientDetailsArray(
      {this.registrationId,
        this.registrationNo,
        this.encounterId,
        this.encounterNo,
        this.patientName,
        this.appointmentTime,
        this.lastVisit,
        this.gender,
        this.age,
        this.ward,
        this.bedId,
        this.bedNo,
        this.patientImage,
        this.status,
        this.vistStatus,
        this.patientType,
        this.mobileNo,
        this.patientStatus,
        this.accountcategory,
        this.statusColor,
        this.doctorName,
        this.facilityId,
        this.encounterDate,
        this.companyType,
        this.isReferred});

  PatientDetailsArray.fromJson(Map<String, dynamic> json) {
    registrationId = json['RegistrationId'];
    registrationNo = json['RegistrationNo'];
    encounterId = json['EncounterId'];
    encounterNo = json['EncounterNo'];
    patientName = json['PatientName'];
    appointmentTime = json['AppointmentTime'];
    lastVisit = json['LastVisit'];
    gender = json['Gender'];
    age = json['Age'];
    ward = json['Ward'];
    bedId = json['BedId'];
    bedNo = json['BedNo'];
    patientImage = json['PatientImage'];
    status = json['Status'];
    vistStatus = json['VistStatus'];
    patientType = json['PatientType'];
    mobileNo = json['MobileNo'];
    patientStatus = json['PatientStatus'];
    accountcategory = json['Accountcategory'];
    statusColor = json['StatusColor'];
    doctorName = json['DoctorName'];
    facilityId = json['FacilityId'];
    encounterDate = json['EncounterDate'];
    companyType = json['CompanyType'];
    isReferred = json['IsReferred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RegistrationId'] = this.registrationId;
    data['RegistrationNo'] = this.registrationNo;
    data['EncounterId'] = this.encounterId;
    data['EncounterNo'] = this.encounterNo;
    data['PatientName'] = this.patientName;
    data['AppointmentTime'] = this.appointmentTime;
    data['LastVisit'] = this.lastVisit;
    data['Gender'] = this.gender;
    data['Age'] = this.age;
    data['Ward'] = this.ward;
    data['BedId'] = this.bedId;
    data['BedNo'] = this.bedNo;
    data['PatientImage'] = this.patientImage;
    data['Status'] = this.status;
    data['VistStatus'] = this.vistStatus;
    data['PatientType'] = this.patientType;
    data['MobileNo'] = this.mobileNo;
    data['PatientStatus'] = this.patientStatus;
    data['Accountcategory'] = this.accountcategory;
    data['StatusColor'] = this.statusColor;
    data['DoctorName'] = this.doctorName;
    data['FacilityId'] = this.facilityId;
    data['EncounterDate'] = this.encounterDate;
    data['CompanyType'] = this.companyType;
    data['IsReferred'] = this.isReferred;
    return data;
  }
}