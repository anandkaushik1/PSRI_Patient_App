class SaveFeedbackResponseModel {
  String?  status;
  String?  message;

  SaveFeedbackResponseModel({this.status, this.message});

  SaveFeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    return data;
  }
}
