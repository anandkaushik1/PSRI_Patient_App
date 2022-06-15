import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Card_List.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/VisitHistoryResponse.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'VisitHistory_Request.dart';

late List<_Page> _allPages;

VisitHistoryResponse res = new VisitHistoryResponse();

class Prescription extends StatefulWidget {
  VerifyPatinetList? IpPatient;

  Prescription({
    Key? key,
    this.IpPatient,
  }) : super(key: key);

  @override
  _NestedTabBarStateee createState() =>
      _NestedTabBarStateee(IpPatient: IpPatient!);
}

class _NestedTabBarStateee extends State<Prescription> {
  VerifyPatinetList? IpPatient;

  _NestedTabBarStateee({
    this.IpPatient,
  });

  @override
  void initState() {
    super.initState();
    _allPages= <_Page>[];
  }

  @override
  void dispose() {
    super.dispose();
    //_nestedTabControllerrr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VisitHistoryResponse>(
      future: callApi('${""}'),
      // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<VisitHistoryResponse> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError) {
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'No Record Found',
                    style: TextStyle(color: Color(CompanyColors.appbar_color),
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
                  ),
                ));
          }else {
            bool validData = false;
            if (data.requireData != null) {
              if (data.requireData.visitHistory != null) {
                if (data.requireData.visitHistory!.length > 0) {
                  validData = true;
                }
              }
            }
            if (validData) {
              _allPages.clear();
              for (int i = 0; i < data.requireData.visitHistory!.length; i++) {
                _Page value = new _Page();
                //  value.text="12-3-5 IP";
                String tempData = data.requireData.visitHistory!
                        .elementAt(i)
                        .encDate
                        .toString()+ /*+
                    "\n" +
                    data.requireData.visitHistory
                        .elementAt(i)
                        .encTime
                        .toString() +*/
                    "-" +
                    data.requireData.visitHistory!.elementAt(i).oPIP.toString() +
                    "P";
                //value.text=data.requireData.visitHistory.elementAt(i).encounterDate.toString()+"\n"+data.requireData.visitHistory.elementAt(i).oPIP+"P";
                value.text = tempData;
                value.pos = i;
                _allPages.add(value);
              }
              return layout(context);
            } else {
              return new Center(
                child: new Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  child: new Text(
                    "No Record Found",
                    style: TextStyle(color: Color(CompanyColors.appbar_color), fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ),
              );
            }
          }
        }
      },
    );
  }

  Widget layout(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
          backgroundColor: Color(CompanyColors.button_txt_color),
          appBar: AppBar(
            backgroundColor: Color(CompanyColors.appbar_color),
            centerTitle: true,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop()),
            title: Text(
              'Prescription',
              style: TextStyle(fontSize: 16.0),
            ),
            bottom: patientDetails(context, IpPatient!),
          ),
          body: TabBarView(
            children: _allPages.map<Widget>((_Page page) {
              return Container(
                child: Center(
                  child: Prescription_Card_List(
                    visit: res.visitHistory!.elementAt(page.pos!.toInt()),
                    encounterNo:
                        res.visitHistory!.elementAt(page.pos!.toInt()).encounterNo.toString(),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Future<VisitHistoryResponse> callApi(String r) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    VisitHistoryRequest req = new VisitHistoryRequest();

    req.mobileNo = "" + IpPatient!.registrationNo.toString();
    print("Request  \n" + req.toJson().toString());
    print(
        "==========================================================================");
    print("Request  \n" + req.toJson().toString());

    VisitHistoryRequest objj = new VisitHistoryRequest.fromJson(req.toJson());
    Response<VisitHistoryResponse> responserrr =
        (await myService.MobGetVisitHistory(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new VisitHistoryResponse.fromJson(postt!.toJson());
    //if (res.status.toLowerCase() != "success") {
     // Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
    //}
    print(res.toJson().toString());
    return Future.value(res);
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(size: 71.0, color: Color(CompanyColors.appbar_color)));
  }
}

PreferredSize patientDetails(BuildContext context, VerifyPatinetList myPatient) {
  return PreferredSize(
    preferredSize: Size.fromHeight(70.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(CompanyColors.appbar_color),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          )),
      height: 70,
      child: Column(
        children: [

          new Container(
            margin: EdgeInsets.fromLTRB(0, 0, 20,0),
            child: Row(
              children: [
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 7),

                    decoration: new BoxDecoration(
                        border: new Border(
                            right: new BorderSide(
                                width: 1.0, color: Colors.white24))),
                    child: new Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 2),
                      child: new SvgPicture.asset(
                        'assets/New_Icons/male_icon_white.svg',
                        height: 40,
                        width: 23,
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.fill,
                      ),
                    ),

                    //child: Icon(Icons.person_pin, color: Colors.white),
                  ),
                ),
                Expanded(
                  flex: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("" + myPatient.patientName.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text("" + myPatient.registrationNo.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    /*  SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child :Text("" + myPatient.doctorName,
                              style: TextStyle(
                                  color: Colors.white,fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                            ),),
                          Text("" + myPatient.encounterNo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),*/
                      //Text("Dr R. Verma  "+ dateValue, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                      TabBar(
                        isScrollable: true,
                        unselectedLabelColor: Colors.white.withOpacity(0.6),
                        indicatorColor: Colors.white,
                        tabs: _allPages.map<Tab>((_Page page) {
                          return Tab(
                            child: Center(
                              child: Container(
                                child: Text(
                                  page.text!.toString(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                          //text: page.text);
                        }).toList(),
                        /*    preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),*/
                      )
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

Widget customBottomBar(PatientDetailsArray Result) {
  return PreferredSize(
    preferredSize: Size.fromHeight(80.0),
    child: Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            Expanded(
                child: new Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "" + Result.patientName.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            )),
            Expanded(
              child: new Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "" + Result.registrationNo.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        new Row(
          children: <Widget>[
            Expanded(
              child: new Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Text(
                  "" + Result.doctorName.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: new Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "" + Result.encounterNo.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
        TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.white.withOpacity(0.3),
          indicatorColor: Colors.white,
          tabs: _allPages.map<Tab>((_Page page) {
            return Tab(
              child: Center(
                child: Text(
                  page.text!.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            //text: page.text);
          }).toList(),
          /*    preferredSize: Size.fromHeight(30.0)),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),*/
        ),
      ],
    ),
  );
}

class _Page {
  _Page({/*this.icon,*/ this.text});

  /* final IconData icon;*/
  String? text;
  int? pos;
}
