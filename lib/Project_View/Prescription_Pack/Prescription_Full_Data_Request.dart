
class Prescription_Full_Data_Request {
  String?  encounterId;
  String?  facilityId;
  String?  fromDate;
  String?  hospitalId;
  String?  registrationId;
  String?  todate;

  Prescription_Full_Data_Request({this.encounterId,
        this.facilityId,
        this.fromDate,
        this.hospitalId,
        this.registrationId,
        this.todate});

  Prescription_Full_Data_Request.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    facilityId = json['FacilityId'];
    fromDate = json['FromDate'];
    hospitalId = json['HospitalId'];
    registrationId = json['RegistrationId'];
    todate = json['Todate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['FacilityId'] = this.facilityId;
    data['FromDate'] = this.fromDate;
    data['HospitalId'] = this.hospitalId;
    data['RegistrationId'] = this.registrationId;
    data['Todate'] = this.todate;
    return data;
  }
}