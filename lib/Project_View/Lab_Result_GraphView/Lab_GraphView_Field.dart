class Lab_GraphView_Field {
  String? facilityId;
  String? fieldId;
  String? hospitalLocationId;
  String? serviceId;

  Lab_GraphView_Field(
      {this.facilityId, this.fieldId, this.hospitalLocationId, this.serviceId});

  Lab_GraphView_Field.fromJson(Map<String, dynamic> json) {
    facilityId = json['FacilityId'];
    fieldId = json['FieldId'];
    hospitalLocationId = json['HospitalLocationId'];
    serviceId = json['ServiceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FacilityId'] = this.facilityId;
    data['FieldId'] = this.fieldId;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['ServiceId'] = this.serviceId;
    return data;
  }
}