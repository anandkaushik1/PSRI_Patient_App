class LastVisitResponse {
  List<LastVisit>? lastVisit;
  String?  status;
  String?  msg;

  LastVisitResponse({this.lastVisit, this.status, this.msg});

  LastVisitResponse.fromJson(Map<String, dynamic> json) {
    if (json['LastVisit'] != null) {
      lastVisit= <LastVisit>[];
      json['LastVisit'].forEach((v) {
        lastVisit!.add(new LastVisit.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastVisit != null) {
      data['LastVisit'] = this.lastVisit!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class LastVisit {
  String?  encounterDate;
  String?  encDate;
  String?  encTime;
  String?  doctorName;
  String?  hospitalName;
  String?  hospitalId;
  String?  encounterId;
  String?  encounterNo;
  String?  name;
  String?  regNo;
  String?  oPIP;
  int? doctorId;
  String?  mobileNo;
  String?  registrationId;
  int? facilityID;
  String?  specialization;
  int? isFeedbackGiven;

  LastVisit(
      {this.encounterDate,
        this.encDate,
        this.encTime,
        this.doctorName,
        this.hospitalName,
        this.hospitalId,
        this.encounterId,
        this.encounterNo,
        this.name,
        this.regNo,
        this.oPIP,
        this.doctorId,
        this.mobileNo,
        this.registrationId,
        this.facilityID,
        this.specialization,
        this.isFeedbackGiven});

  LastVisit.fromJson(Map<String, dynamic> json) {
    encounterDate = json['EncounterDate'];
    encDate = json['EncDate'];
    encTime = json['EncTime'];
    doctorName = json['DoctorName'];
    hospitalName = json['HospitalName'];
    hospitalId = json['HospitalId'];
    encounterId = json['EncounterId'];
    encounterNo = json['EncounterNo'];
    name = json['Name'];
    regNo = json['RegNo'];
    oPIP = json['OPIP'];
    doctorId = json['DoctorId'];
    mobileNo = json['MobileNo'];
    registrationId = json['RegistrationId'];
    facilityID = json['FacilityID'];
    specialization = json['Specialization'];
    isFeedbackGiven = json['IsFeedbackGiven'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EncounterDate'] = this.encounterDate;
    data['EncDate'] = this.encDate;
    data['EncTime'] = this.encTime;
    data['DoctorName'] = this.doctorName;
    data['HospitalName'] = this.hospitalName;
    data['HospitalId'] = this.hospitalId;
    data['EncounterId'] = this.encounterId;
    data['EncounterNo'] = this.encounterNo;
    data['Name'] = this.name;
    data['RegNo'] = this.regNo;
    data['OPIP'] = this.oPIP;
    data['DoctorId'] = this.doctorId;
    data['MobileNo'] = this.mobileNo;
    data['RegistrationId'] = this.registrationId;
    data['FacilityID'] = this.facilityID;
    data['Specialization'] = this.specialization;
    data['IsFeedbackGiven'] = this.isFeedbackGiven;
    return data;
  }
}