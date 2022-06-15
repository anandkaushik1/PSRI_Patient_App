class FullCaseReport {


   String?  titleName;
   String?  subTitleName;
   String?  firstLinedetails;
   String?  secLinedetails;
   String?  thirdLinedetails;
   String?  date;
   String?  enterBy;
   String?  otherStringSummery;
   String?  tvDrugInstructions;

  FullCaseReport({this.titleName, this.subTitleName ,
    this.firstLinedetails, this.secLinedetails ,
    this.thirdLinedetails, this.date ,
    this.enterBy, this.otherStringSummery ,
    this.tvDrugInstructions,
                    });

  FullCaseReport.fromJson(Map<String, dynamic> json) {
    titleName = json['TitleName'];
    subTitleName = json['SubTitleName'];
    firstLinedetails = json['FirstLinedetails'];
    secLinedetails = json['SecLinedetails'];
    thirdLinedetails = json['ThirdLinedetails'];
    date = json['Date'];
    enterBy = json['EnterBy'];
    otherStringSummery = json['OtherStringSummery'];
    tvDrugInstructions = json['TvDrugInstructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TitleName'] = this.titleName;
    data['SubTitleName'] = this.subTitleName;
    data['FirstLinedetails'] = this.firstLinedetails;
    data['SecLinedetails'] = this.secLinedetails;
    data['ThirdLinedetails'] = this.thirdLinedetails;
    data['Date'] = this.date;
    data['EnterBy'] = this.enterBy;
    data['OtherStringSummery'] = this.otherStringSummery;
    data['TvDrugInstructions'] = this.tvDrugInstructions;
    return data;
  }
}