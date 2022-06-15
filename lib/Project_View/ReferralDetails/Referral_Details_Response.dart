class Referral_Details_Response {
  List<ReferralVisitDetails>? referralVisitDetails;
  String? status;
  String? msg;

  Referral_Details_Response({this.referralVisitDetails, this.status, this.msg});

  Referral_Details_Response.fromJson(Map<String, dynamic> json) {
  if (json['ReferralVisitDetails'] != null) {
  referralVisitDetails= <ReferralVisitDetails>[];
  json['ReferralVisitDetails'].forEach((v) {
  referralVisitDetails!.add(new ReferralVisitDetails.fromJson(v));
  });
  }
  status = json['Status'];
  msg = json['Msg'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (this.referralVisitDetails != null) {
  data['ReferralVisitDetails'] =
  this.referralVisitDetails!.map((v) => v.toJson()).toList();
  }
  data['Status'] = this.status;
  data['Msg'] = this.msg;
  return data;
  }
  }

  class ReferralVisitDetails {
  String? referralId;
  String? referralDate;
  String? doctorName;
  String? note;
  String? doctorRemark;
  String? fromDoctorName;
  String? referralReplyDate;
  String? status;
  String? replyBy;

  ReferralVisitDetails(
  {this.referralId,
  this.referralDate,
  this.doctorName,
  this.note,
  this.doctorRemark,
  this.fromDoctorName,
  this.referralReplyDate,
  this.status,
  this.replyBy});

  ReferralVisitDetails.fromJson(Map<String, dynamic> json) {
  referralId = json['ReferralId'];
  referralDate = json['ReferralDate'];
  doctorName = json['DoctorName'];
  note = json['Note'];
  doctorRemark = json['DoctorRemark'];
  fromDoctorName = json['FromDoctorName'];
  referralReplyDate = json['ReferralReplyDate'];
  status = json['Status'];
  replyBy = json['ReplyBy'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ReferralId'] = this.referralId;
  data['ReferralDate'] = this.referralDate;
  data['DoctorName'] = this.doctorName;
  data['Note'] = this.note;
  data['DoctorRemark'] = this.doctorRemark;
  data['FromDoctorName'] = this.fromDoctorName;
  data['ReferralReplyDate'] = this.referralReplyDate;
  data['Status'] = this.status;
  data['ReplyBy'] = this.replyBy;
  return data;
  }
  }