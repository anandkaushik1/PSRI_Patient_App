import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Cross_Referral_List.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Cross_Referral_Visit_Response.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Referral_Details_Request.dart';
import 'package:flutter_patient_app/Project_View/ReferralDetails/Referral_Details_Response.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Referral_Details_Response res = new Referral_Details_Response();

class Cross_Referral_Card_List extends StatefulWidget {
  String? encounterNo = "";
  ReferralVisit? visit;

  Cross_Referral_Card_List({
    Key? key,
    this.encounterNo,
    this.visit,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
        encounterNo: this.encounterNo,
        visit: this.visit,
      );
}

class _CardListScreenState extends State<Cross_Referral_Card_List> {
  String? encounterNo = "";
  ReferralVisit? visit;

  _CardListScreenState({
    this.encounterNo,
    this.visit,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Referral_Details_Response>(
      future: callApi(visit!), // function where you call your api
      builder: (BuildContext context,
          AsyncSnapshot<Referral_Details_Response> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(
                        color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ));
          else
            return layout();
        }
      },
    );
  }
  Widget layout() {
    return Scaffold(
      appBar: patientDetails(visit!),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: res.referralVisitDetails!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Cross_Referral_List(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      referralVisit: res.referralVisitDetails!.elementAt(index),
                      ArgData: res.referralVisitDetails!,
                      pos: index,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget Loading(BuildContext forThis) {
  return new Container(
      color: Colors.white,
      child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
}



PreferredSize patientDetails( ReferralVisit myDoctor) {
  return PreferredSize(
    preferredSize: Size.fromHeight(40.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(CompanyColors.white),
      ),
      height: 40,
      child: Column(
        children: [

          new Container(
            margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [

                Expanded(
                  flex: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Flexible(
                            child :Text("" + myDoctor.doctorName!.toString(),
                              style: TextStyle(
                                  color: Color(CompanyColors.appbar_color),fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                               overflow: TextOverflow.ellipsis,
                            ),

                          ),
                          Text("" + myDoctor.encounterDate!.toString(),
                              style: TextStyle(
                                  color: Color(CompanyColors.appbar_color),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold)),

                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<Referral_Details_Response> callApi(ReferralVisit data) async {
  String url = BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  Referral_Details_Request objddd = new Referral_Details_Request();
  objddd.encounterId = "" + data.encounterId.toString();
  objddd.facilityId = "" + data.facilityID.toString();
  print("Request  \n" + objddd.toJson().toString());
  Referral_Details_Request objj =
      new Referral_Details_Request.fromJson(objddd.toJson());
  Response<Referral_Details_Response> responserrr =
      (await myService.GetReferralDetails(objj));
  var postt = responserrr.body;
  print(responserrr.body);
  res = new Referral_Details_Response.fromJson(postt!.toJson());
  return Future.value(res);
}
