class LabVisitResponseRadio {
  List<VisitHistory>? visitHistory;
  String? status;
  String? msg;

  LabVisitResponseRadio({this.visitHistory, this.status, this.msg});

  LabVisitResponseRadio.fromJson(Map<String, dynamic> json) {
    if (json['VisitHistory'] != null) {
      visitHistory= <VisitHistory>[];
      json['VisitHistory'].forEach((v) {
        visitHistory!.add(new VisitHistory.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visitHistory != null) {
      data['VisitHistory'] = this.visitHistory!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class VisitHistory {
  String? encounterDate;
  String? encDate;
  String? encTime;
  String? doctorName;
  String? hospitalName;
  String? hospitalId;
  String? encounterId;
  String? encounterNo;
  String? name;
  String? regNo;
  String? oPIP;
  String? pI;
  String? dischargeDate;
  int? doctorId;
  String? mobileNo;
  String? registrationId;
  int? facilityID;
  String? specialization;
  String? isRadiology;



  VisitHistory(
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
        this.pI,
        this.dischargeDate,
        this.doctorId,
        this.mobileNo,
        this.registrationId,
        this.facilityID,
        this.isRadiology,
        this.specialization});

  VisitHistory.fromJson(Map<String, dynamic> json) {
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
    pI = json['PI'];
    dischargeDate = json['DischargeDate'];
    doctorId = json['DoctorId'];
    mobileNo = json['MobileNo'];
    registrationId = json['RegistrationId'];
    facilityID = json['FacilityID'];
    isRadiology=json['IsRadiology'];
    specialization = json['Specialization'];
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
    data['PI'] = this.pI;
    data['DischargeDate'] = this.dischargeDate;
    data['IsRadiology'] =this.isRadiology;
    data['DoctorId'] = this.doctorId;
    data['MobileNo'] = this.mobileNo;
    data['RegistrationId'] = this.registrationId;
    data['FacilityID'] = this.facilityID;
    data['Specialization'] = this.specialization;
    return data;
  }
}