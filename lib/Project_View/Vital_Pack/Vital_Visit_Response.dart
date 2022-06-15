class Vital_Visit_Response {
  List<VitalVisit>? vitalVisit;
  String? status;
  String? msg;

  Vital_Visit_Response({this.vitalVisit, this.status, this.msg});

  Vital_Visit_Response.fromJson(Map<String, dynamic> json) {
    if (json['VitalVisit'] != null) {
      vitalVisit= <VitalVisit>[];
      json['VitalVisit'].forEach((v) {
        vitalVisit!.add(new VitalVisit.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vitalVisit != null) {
      data['VitalVisit'] = this.vitalVisit!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class VitalVisit {
  String? encounterId;
  String? registrationNo;
  String? encounterNo;
  String? encounterDate;
  String? encDate;
  String? encTime;
  String? registrationId;
  String? doctorName;
  String? hospitalId;
  String? hospitalName;
  String? facilityID;
  String? name;
  String? visitType;
  String? mobileNo;
  String? doctorId;
  String? specialization;

  VitalVisit(
      {this.encounterId,
        this.registrationNo,
        this.encounterNo,
        this.encounterDate,
        this.encDate,
        this.encTime,
        this.registrationId,
        this.doctorName,
        this.hospitalId,
        this.hospitalName,
        this.facilityID,
        this.name,
        this.visitType,
        this.mobileNo,
        this.doctorId,
        this.specialization});

  VitalVisit.fromJson(Map<String, dynamic> json) {
    encounterId = json['EncounterId'];
    registrationNo = json['RegistrationNo'];
    encounterNo = json['EncounterNo'];
    encounterDate = json['EncounterDate'];
    encDate = json['EncDate'];
    encTime = json['EncTime'];
    registrationId = json['RegistrationId'];
    doctorName = json['DoctorName'];
    hospitalId = json['HospitalId'];
    hospitalName = json['HospitalName'];
    facilityID = json['FacilityID'];
    name = json['Name'];
    visitType = json['VisitType'];
    mobileNo = json['MobileNo'];
    doctorId = json['DoctorId'];
    specialization = json['Specialization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterId'] = this.encounterId;
    data['RegistrationNo'] = this.registrationNo;
    data['EncounterNo'] = this.encounterNo;
    data['EncounterDate'] = this.encounterDate;
    data['EncDate'] = this.encDate;
    data['EncTime'] = this.encTime;
    data['RegistrationId'] = this.registrationId;
    data['DoctorName'] = this.doctorName;
    data['HospitalId'] = this.hospitalId;
    data['HospitalName'] = this.hospitalName;
    data['FacilityID'] = this.facilityID;
    data['Name'] = this.name;
    data['VisitType'] = this.visitType;
    data['MobileNo'] = this.mobileNo;
    data['DoctorId'] = this.doctorId;
    data['Specialization'] = this.specialization;
    return data;
  }
}