import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_Response.dart';
import 'package:flutter_patient_app/feedback_pack/Feedback_list.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

double _rating = 1.0;

class Feedback_list_empty_card extends StatefulWidget {
  double? width;
  double? height;
  CustomerInfo? dataValue;
  int? pos;

  Feedback_list_empty_card({
    Key? key,
    this.width,
    this.height,
    this.dataValue,
    this.pos,
  }) : super(key: key);

  @override
  MyAppFeedBack createState() => MyAppFeedBack(
        height: this.height,
        width: this.width,
        dataValue: this.dataValue,
        pos: this.pos,
      );
}

class MyAppFeedBack extends State<Feedback_list_empty_card> {
  final double? width;
  final double? height;
  final CustomerInfo? dataValue;
  final int? pos;

  MyAppFeedBack({
    Key? key,
    this.width,
    this.height,
    this.dataValue,
    this.pos,
  });

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      /*onTap: () {
        print("Container clicked");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Categroies()),
        );
      },*/
      child: Container(
          width: width,
          height: height,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                offset: const Offset(0.0, 4.0),
              ),
            ],
          ),
          child: new Column(
            /*  mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,*/
            children: <Widget>[
              new Row(
                children: <Widget>[
                  /* Expanded(
                    flex: 15, // color: Colors.green,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50.0),
                        bottomLeft: Radius.circular(50.0),
                        topLeft: Radius.circular(50.0),
                        topRight: Radius.circular(50.0),
                      ),
                      child:new Container(
                          alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 2),
                      child :  new SvgPicture.asset(
                          'assets/icons/male_icon.svg',
                          height: 40,
                          width: 20,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),*/
                  Expanded(
                    flex: 100,
                    child: GestureDetector(
                        onTap: () {
                          print("Container clicked");
                          /*  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Categroies(
                                  IpPatient: IpPatient,
                                  pos: pos,
                                )));*/
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            setTitleOfFeedback(dataValue!.title.toString()),
                            new Text(
                              "" + dataValue!.subTitle.toString(),
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                            ),
                            new Container(
                              child: Center(
                                child: RatingBar.builder(
                                  initialRating: getRatingaValue(),
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 4.0),
                                  itemBuilder: (context, index) {
                                    switch (index) {
                                      case 0:
                                        return Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          color: Colors.red,
                                        );
                                      case 1:
                                        return Icon(
                                          Icons.sentiment_dissatisfied,
                                          color: Colors.redAccent,
                                        );
                                      case 2:
                                        return Icon(
                                          Icons.sentiment_neutral,
                                          color: Colors.amber,
                                        );
                                      case 3:
                                        return Icon(
                                          Icons.sentiment_satisfied,
                                          color: Colors.lightGreen,
                                        );
                                      case 4:
                                        return Icon(
                                          Icons.sentiment_very_satisfied,
                                          color: Colors.green,
                                        );
                                      default:
                                        return Container();
                                    }
                                  },
                                  onRatingUpdate: (rating) {
                                    setState(() {
                                      int number = rating.toInt();
                                      print(
                                          'rating : ${number},  datavalue : ${dataValue}');
                                      updateratingInList(dataValue!,pos!.toInt(),number);
                                      Feedback_list.mapForFeedBack.putIfAbsent(
                                          dataValue!.subDeptId.toString(), () => dataValue!);
                                      if (pos!.toInt() % 2 == 0) {
                                        _rating = 2;
                                      } else {
                                        _rating = 5;
                                      }
                                    });
                                  },
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                      flex: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[],
                      )),
                ],
              ),
            ],
          )),
    );
  }

  Widget setTitleOfFeedback(String data) {
    if (data.isEmpty) {
      return new Container(
        child: new Text(
          "" + data,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      );
    } else {
      return new Container(
        width: MediaQuery.of(context).size.width,
        color: Color(CompanyColors.appbar_color),
        padding: EdgeInsets.all(10.0),
        child: new Text(
          "" + data,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      );
    }
  }

  getRatingaValue() {
    String? ratingvalue = dataValue!.initialRating!;
    return double.parse('${ratingvalue}');
  }

  updateratingInList(CustomerInfo info, int pos, int value) {
    info.initialRating = '${value}';
    print('position value = $pos');

    setState(() {
      Feedback_list.dataCustomer.removeAt(pos);
      Feedback_list.dataCustomer.insert(pos, info);
    });
  }


}
