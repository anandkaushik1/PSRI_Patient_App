class Lab_Report_Request {
  String? encounterId;
  String? facilityId;
  String? fromDate;
  String? hospitalId;
  String? labType;
  String? oPIP;
  String? registrationId;
  String? todate;

  Lab_Report_Request(
      {this.encounterId,
        this.facilityId,
        this.fromDate,
        this.hospitalId,
        this.labType,
        this.oPIP,
        this.registrationId,
        this.todate});

  Lab_Report_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    fromDate = json['FromDate'];
    hospitalId = json['HospitalId'];
    labType = json['LabType'];
    oPIP = json['OPIP'];
    registrationId = json['RegistrationId'];
    todate = json['Todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['FromDate'] = this.fromDate;
    data['HospitalId'] = this.hospitalId;
    data['LabType'] = this.labType;
    data['OPIP'] = this.oPIP;
    data['RegistrationId'] = this.registrationId;
    data['Todate'] = this.todate;
    return data;
  }
}