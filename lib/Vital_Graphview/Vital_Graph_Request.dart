class Vital_Graph_Request {
  String? dateRange;
  String? facilityId;
  String? fromDate;
  String? hospitalLocationId;
  String? registrationId;
  String? toDate;
  List<XmlVitalId>? xmlVitalId;

  Vital_Graph_Request(
      {this.dateRange,
        this.facilityId,
        this.fromDate,
        this.hospitalLocationId,
        this.registrationId,
        this.toDate,
        this.xmlVitalId});

  Vital_Graph_Request.fromJson(Map<String, dynamic> json) {
    dateRange = json['DateRange'];
    facilityId = json['FacilityId'];
    fromDate = json['FromDate'];
    hospitalLocationId = json['HospitalLocationId'];
    registrationId = json['RegistrationId'];
    toDate = json['ToDate'];
    if (json['xmlVitalId'] != null) {
      xmlVitalId= <XmlVitalId>[];
      json['xmlVitalId'].forEach((v) {
        xmlVitalId!.add(new XmlVitalId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateRange'] = this.dateRange;
    data['FacilityId'] = this.facilityId;
    data['FromDate'] = this.fromDate;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['RegistrationId'] = this.registrationId;
    data['ToDate'] = this.toDate;
    if (this.xmlVitalId != null) {
      data['xmlVitalId'] = this.xmlVitalId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class XmlVitalId {
  String? vitalId;

  XmlVitalId({this.vitalId});

  XmlVitalId.fromJson(Map<String, dynamic> json) {
    vitalId = json['VitalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VitalId'] = this.vitalId;
    return data;
  }
}