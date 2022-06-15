class Apmt_Slot_List_Request {
  String? doctorId;
  String? facilityId;
  String? filter;
  String? fromDate;
  String? hospitalLocationId;

  Apmt_Slot_List_Request(
      {this.doctorId,
        this.facilityId,
        this.filter,
        this.fromDate,
        this.hospitalLocationId});

  Apmt_Slot_List_Request.fromJson(Map<String, dynamic> json) {
    doctorId = json['DoctorId'];
    facilityId = json['FacilityId'];
    filter = json['Filter'];
    fromDate = json['FromDate'];
    hospitalLocationId = json['HospitalLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DoctorId'] = this.doctorId;
    data['FacilityId'] = this.facilityId;
    data['Filter'] = this.filter;
    data['FromDate'] = this.fromDate;
    data['HospitalLocationId'] = this.hospitalLocationId;
    return data;
  }
}