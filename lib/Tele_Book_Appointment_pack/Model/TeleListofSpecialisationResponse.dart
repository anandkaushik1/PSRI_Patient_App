class TeleListofSpecialisationResponse {
  List<SpecialisationDoctorListArray>? specialisationDoctorListArray;
  String? status;
  String? msg;
  String? getId;

  TeleListofSpecialisationResponse(
      {this.specialisationDoctorListArray, this.status, this.msg, this.getId});

  TeleListofSpecialisationResponse.fromJson(Map<String, dynamic> json) {
    if ((json['SpecialisationDoctorListArray'] != null)||(json['SpecialisationDoctorListArray'] != "")) {
      specialisationDoctorListArray= <SpecialisationDoctorListArray>[];
      json['SpecialisationDoctorListArray'].forEach((v) {
        specialisationDoctorListArray
            !.add(new SpecialisationDoctorListArray.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specialisationDoctorListArray != null) {
      data['SpecialisationDoctorListArray'] =
          this.specialisationDoctorListArray!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class SpecialisationDoctorListArray {
  int? iD;
  String? name;
  String? resultType;
  String? specialisationImagePath;
  bool? allowTeleConsultation;

  SpecialisationDoctorListArray(
      {this.iD,
        this.name,
        this.resultType,
        this.specialisationImagePath,
        this.allowTeleConsultation});

  SpecialisationDoctorListArray.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    resultType = json['ResultType'];
    specialisationImagePath = json['SpecialisationImagePath'];
    allowTeleConsultation = json['AllowTeleConsultation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Name'] = this.name;
    data['ResultType'] = this.resultType;
    data['SpecialisationImagePath'] = this.specialisationImagePath;
    data['AllowTeleConsultation'] = this.allowTeleConsultation;
    return data;
  }
}