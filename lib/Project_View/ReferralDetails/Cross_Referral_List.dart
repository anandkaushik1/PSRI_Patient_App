import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Referral_Details_Response.dart';

double selectMargn = 0;
 String lastDate="";
  int nextIndex=0;
class Cross_Referral_List extends StatelessWidget {
  final double? width;
  final double? height;
  final ReferralVisitDetails? referralVisit;
  final int? pos;
  final List<ReferralVisitDetails>? ArgData;
  const Cross_Referral_List({
    Key? key,
    this.width,
    this.height,
    this.referralVisit,
    this.pos,
    this.ArgData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        print("Container clicked");
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => Categroies()),
//        );
      },
        child:ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: height!.toDouble(),
            maxWidth: MediaQuery.of(context).size.width,

          ),
      child: Container(
          /*width: width,
          height: height,*/
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(CompanyColors.shadow_color),
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              new Center(
                  child: new Container(
                      child: dateTitle(pos!.toInt(),referralVisit!,ArgData!),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(6.0),
                        color: Color(CompanyColors.appbar_color),
                      ),
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                      height: 30,
                      width: 200,
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center)),
              new Container(
                child: displayReferDate(referralVisit!),
              ),
              new Container(
                child: displayReferBy(referralVisit!),
              ),

              new Container(
                child: displayReferTo(referralVisit!),
              ),
              new Container(
                child: displayStatus(referralVisit!),
              ),
              new Container(
                child: displayNote(referralVisit!),
              ),
              new Container(
                child: displayLine(),
              ),
              new Container(
                child: displayReferralReplyDate(referralVisit!),
              ),
              new Container(
                child: displayReplyBy(referralVisit!),
              ),
              new Container(
                child: displayDoctorRemark(referralVisit!),
              ),
              //new Text(ReferralVisit.bMI),
              //  new Text(ReferralVisit.bPDiastolic),
            ],
          )),)
    );
  }


  Widget dateLogin(int pos ,ReferralVisitDetails date, List<ReferralVisitDetails> ListData) {
    nextIndex=pos+1;
    if(nextIndex<ListData.length&&nextIndex!=0) {
      nextIndex=pos+1;
      lastDate = ListData
          .elementAt(nextIndex)
          .referralDate.toString();
    }else
      {
        nextIndex=pos;
        lastDate = ListData
            .elementAt(nextIndex)
            .referralDate.toString();
      }
    if (date.referralDate != lastDate||pos==0) {
      return new Text(
        date.referralDate.toString(),
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontSize: 17.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }else {
      return new Text("");
    }
  }
  Widget displayReferDate(ReferralVisitDetails data) {

      return RowView("Refer Date", data.referralDate.toString());

  }
  Widget displayReferBy(ReferralVisitDetails data) {

    return RowView("Refer By", data.fromDoctorName.toString());

  }
  Widget displayReferTo(ReferralVisitDetails data) {

    return RowView("Refer To", data.doctorName.toString());

  }
  Widget displayStatus(ReferralVisitDetails data) {

    return RowView("Status", data.status.toString());

  }
  Widget displayNote(ReferralVisitDetails data) {

    return RowView("Note", data.note.toString());

  }

  Widget displayReferralReplyDate(ReferralVisitDetails data) {

    return RowView("Reply Date", data.referralReplyDate.toString());

  }
  Widget displayReplyBy(ReferralVisitDetails data) {

    return RowView("Reply By", data.replyBy.toString());

  }
  Widget displayDoctorRemark(ReferralVisitDetails data) {

    return RowView("Remark", data.doctorRemark.toString());

  }
  Widget displayLine() {

    return new Container(

        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(1.0),
          color: Color(CompanyColors.bluegray),
        ),
        height: 2,

        width: double.infinity,
        alignment: Alignment.center);

  }
  Widget RowView(String title, String value) {
    return new Container(

      child: new Column(
        children: <Widget>[

          new Container(
            margin: EdgeInsets.only(top: 15),
           child : new Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(CompanyColors.bluegray),
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Text(
                    value,
                    textAlign: TextAlign.start,
                    style: new TextStyle(
                      fontSize: 14.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      color: Color(CompanyColors.appbar_color),
                    ),
                  ),
                ),
              ],
            ),
          ),

          new Container(

              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(1.0),
                color: Color(CompanyColors.bluegray),
              ),
              height: 1,

              width: double.infinity,
              alignment: Alignment.center),


        ],
      ),
    );
  }

  Widget dateTitle(
      int pos, ReferralVisitDetails date, List<ReferralVisitDetails> ListData) {
    nextIndex = pos + 1;
    if (nextIndex < ListData.length && nextIndex != 0) {
      nextIndex = pos + 1;
      lastDate = ListData.elementAt(nextIndex).referralDate.toString();
    } else {
      nextIndex = pos;
      lastDate = ListData.elementAt(nextIndex).referralDate.toString();
    }
    if (date.referralDate != lastDate || pos == 0||date.referralDate!.isNotEmpty) {
      selectMargn = 0;
      return layoutHeaderDate(date.referralDate.toString());
    } else {
      selectMargn = 0;
      return new Visibility(visible: false, child: new Text(""));
    }
  }

  Widget layoutHeaderDate(String Date) {
    return new Visibility(
      visible: true,
      child: new Container(
          child: new Text(
            Date,
            textAlign: TextAlign.center,
            style: new TextStyle(
              fontSize: 13.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(6.0),
            color: Color(CompanyColors.appbar_color),
          ),
          height: 40,
          width: 130,
          margin: EdgeInsets.only(bottom: 0),
          alignment: Alignment.center),
    );
  }


}
