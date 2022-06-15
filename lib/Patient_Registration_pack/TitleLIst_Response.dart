class titleIDList_Response {
  List<Title>? title;
  String?  status;
  String?  msg;

  titleIDList_Response({this.title, this.status, this.msg});

  titleIDList_Response.fromJson(Map<String, dynamic> json) {
    if (json['title'] != null) {
      title= <Title>[];
      json['title'].forEach((v) {
        title!.add(new Title.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    return data;
  }
}

class Title {
  int? titleId;
  String?  titleName;
  String?  gender;

  Title({this.titleId, this.titleName, this.gender});

  Title.fromJson(Map<String, dynamic> json) {
    titleId = json['TitleId'];
    titleName = json['TitleName'];
    gender = json['Gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TitleId'] = this.titleId;
    data['TitleName'] = this.titleName;
    data['Gender'] = this.gender;
    return data;
  }
}

