class DocTypeResponse {
  List<DocumentTypeList>? documentTypeList;
  String? status;
  String? msg;
  String? getId;

  DocTypeResponse({this.documentTypeList, this.status, this.msg, this.getId});

  DocTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['DocumentTypeList'] != null) {
      documentTypeList= <DocumentTypeList>[];
      json['DocumentTypeList'].forEach((v) {
        documentTypeList!.add(new DocumentTypeList.fromJson(v));
      });
    }
    status = json['Status'];
    msg = json['Msg'];
    getId = json['GetId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.documentTypeList != null) {
      data['DocumentTypeList'] =
          this.documentTypeList!.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    data['Msg'] = this.msg;
    data['GetId'] = this.getId;
    return data;
  }
}

class DocumentTypeList {
  int? documentId;
  String? documentType;

  DocumentTypeList({this.documentId, this.documentType});

  DocumentTypeList.fromJson(Map<String, dynamic> json) {
    documentId = json['DocumentId'];
    documentType = json['DocumentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentId'] = this.documentId;
    data['DocumentType'] = this.documentType;
    return data;
  }
}