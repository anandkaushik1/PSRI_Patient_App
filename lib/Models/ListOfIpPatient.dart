class ListOfIpPatientResquest {
  String?  bEDNo;
  String?  doctorId;
  String?  facilityId;
  String?  filter;
  String?  hospitalLocationId;
  String?  mobile;
  String?  oPIP;
  String?  patientName;
  String?  registrationNo;
  String?  fromDate;

  ListOfIpPatientResquest(
      {this.bEDNo,
        this.doctorId,
        this.facilityId,
        this.filter,
        this.hospitalLocationId,
        this.mobile,
        this.oPIP,
        this.patientName,
        this.registrationNo,
        this.fromDate
      });

  ListOfIpPatientResquest.fromJson(Map<String, dynamic> json) {
    bEDNo = json['BEDNo'];
    doctorId = json['DoctorId'];
    facilityId = json['FacilityId'];
    filter = json['Filter'];
    hospitalLocationId = json['HospitalLocationId'];
    mobile = json['Mobile'];
    oPIP = json['OPIP'];
    patientName = json['PatientName'];
    registrationNo = json['RegistrationNo'];
    fromDate = json['FromDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BEDNo'] = this.bEDNo;
    data['DoctorId'] = this.doctorId;
    data['FacilityId'] = this.facilityId;
    data['Filter'] = this.filter;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['Mobile'] = this.mobile;
    data['OPIP'] = this.oPIP;
    data['PatientName'] = this.patientName;
    data['RegistrationNo'] = this.registrationNo;
    data['FromDate'] = this.fromDate;
    return data;
  }
}