class Lab_Details_Request {
  String? diagSampleId;
  String? encodedDate;
  String? facilityId;
  String? hospitalId;
  String? labNo;
  String? oPIP;
  String? registrationId;
  String? serviceId;
  String? serviceName;

  Lab_Details_Request(
  {this.diagSampleId,
  this.encodedDate,
  this.facilityId,
  this.hospitalId,
  this.labNo,
  this.oPIP,
  this.registrationId,
  this.serviceId,
  this.serviceName});

  Lab_Details_Request.fromJson(Map<String, dynamic> json) {
  diagSampleId = json['DiagSampleId'];
  encodedDate = json['EncodedDate'];
  facilityId = json['FacilityId'];
  hospitalId = json['HospitalId'];
  labNo = json['LabNo'];
  oPIP = json['OPIP'];
  registrationId = json['RegistrationId'];
  serviceId = json['ServiceId'];
  serviceName = json['ServiceName'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['DiagSampleId'] = this.diagSampleId;
  data['EncodedDate'] = this.encodedDate;
  data['FacilityId'] = this.facilityId;
  data['HospitalId'] = this.hospitalId;
  data['LabNo'] = this.labNo;
  data['OPIP'] = this.oPIP;
  data['RegistrationId'] = this.registrationId;
  data['ServiceId'] = this.serviceId;
  data['ServiceName'] = this.serviceName;
  return data;
  }
  }