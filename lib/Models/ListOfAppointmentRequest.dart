

class ListOfAppointmentRequest {

  String?  doctorId;
  String?  facilityId;
  String?  filter;
  String?  hospitalLocationId;
  String?  fromDate;

  ListOfAppointmentRequest(
      {
        this.doctorId,
        this.facilityId,
        this.filter,
        this.hospitalLocationId,
        this.fromDate
      });

  ListOfAppointmentRequest.fromJson(Map<String, dynamic> json) {

    doctorId = json['DoctorId'];
    facilityId = json['FacilityId'];
    filter = json['Filter'];
    hospitalLocationId = json['HospitalLocationId'];

    fromDate = json['FromDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['DoctorId'] = this.doctorId;
    data['FacilityId'] = this.facilityId;
    data['Filter'] = this.filter;
    data['HospitalLocationId'] = this.hospitalLocationId;

    data['FromDate'] = this.fromDate;
    return data;
  }
}