class Lab_Garph_View {
  String? dateRange;
  String? fieldId;
  String? fromDate;
  String? hospitalLocationId;
  String? registrationId;
  String? toDate;

  Lab_Garph_View(
      {this.dateRange,
      this.fieldId,
      this.fromDate,
      this.hospitalLocationId,
      this.registrationId,
      this.toDate});

  Lab_Garph_View.fromJson(Map<String, dynamic> json) {
    dateRange = json['DateRange'];
    fieldId = json['FieldId'];
    fromDate = json['FromDate'];
    hospitalLocationId = json['HospitalLocationId'];
    registrationId = json['RegistrationId'];
    toDate = json['ToDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DateRange'] = this.dateRange;
    data['FieldId'] = this.fieldId;
    data['FromDate'] = this.fromDate;
    data['HospitalLocationId'] = this.hospitalLocationId;
    data['RegistrationId'] = this.registrationId;
    data['ToDate'] = this.toDate;
    return data;
  }
}
