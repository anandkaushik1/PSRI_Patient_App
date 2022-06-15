import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Card_List.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Visit_Request.dart';
import 'package:flutter_patient_app/Project_View/Vital_Pack/Vital_Visit_Response.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

late List<_Page> _allPages;

Vital_Visit_Response res = new Vital_Visit_Response();

class Vital extends StatefulWidget {
  VerifyPatinetList? IpPatient;

  Vital({
    Key? key,
    this.IpPatient,
  }) : super(key: key);

  @override
  _NestedTabBarStateee createState() =>
      _NestedTabBarStateee(IpPatient: IpPatient!);
}

class _NestedTabBarStateee extends State<Vital> {
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
    return FutureBuilder<Vital_Visit_Response>(
      future: callApi('${""}'), // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<Vital_Visit_Response> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context);
        } else {
          if (data.hasError)
            return noDataFound(context);
          else if (data.requireData == null) {
            return noDataFound(context);
          } else {
            if (data.requireData.status!.toString().toLowerCase() == "success") {
              _allPages.clear();
              for (int i = 0; i < data.requireData.vitalVisit!.length; i++) {
                _Page value = new _Page();
                //  value.text="12-3-5 IP";
                String sdad = data.requireData.vitalVisit!
                    .elementAt(i)
                    .encDate
                    .toString();
                value.text = data.requireData.vitalVisit!
                    .elementAt(i)
                    .encDate
                    .toString()+"-"+
                    data.requireData.vitalVisit!
                        .elementAt(i)
                        .visitType
                        .toString()+"P";
                value.pos = i;
                _allPages.add(value);
              }
              return layout(context);
            }else{
              return noDataFound(context);

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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Color(CompanyColors.appbar_color),
            centerTitle: true,
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop()),
            title: Text(
              'Vitals',
              style: TextStyle(fontSize: 16.0),
            ),
            bottom: patientDetails(context, IpPatient!),
          ),
          body: TabBarView(
            children: _allPages.map<Widget>((_Page page) {
              return Container(
                child: Center(
                  child: Vital_Card_List(
                    visit: res.vitalVisit!.elementAt(page.pos!.toInt()),
                    encounterNo: res.vitalVisit!.elementAt(page.pos!.toInt()).encounterNo.toString(),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }

  Future<Vital_Visit_Response> callApi(String r) async {
    String url = BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    Vital_Visit_Request req = new Vital_Visit_Request();
    req.registrationId = "" + IpPatient!.registrationId.toString();
    Vital_Visit_Request objj = new Vital_Visit_Request.fromJson(req.toJson());
    Response<Vital_Visit_Response> responserrr =
        (await myService.GetVitalVisit(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new Vital_Visit_Response.fromJson(postt!.toJson());
   return Future.value(res);
  }


  Widget noDataFound(BuildContext context) {
    new Future.delayed(new Duration(seconds: 2), () {
      Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
    });
    return new Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'No Record Found',
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ));
  }

  Widget Loading(BuildContext forThis) {
    return new Container(
        color: Colors.white,
        child: SpinKitCubeGrid(
            size: 71.0, color: Color(CompanyColors.appbar_color)));
    ;
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
            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
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
                                  page.text.toString(),
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


class _Page {
  _Page({/*this.icon,*/ this.text});

  /* final IconData icon;*/
  String? text;
  int? pos;
}

Widget noDataFound(BuildContext context) {
  Navigator.of(context).popUntil(ModalRoute.withName("/CategoriesPatient"));
  return new Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'No Record Found ',
          style: TextStyle(color: Colors.grey, fontSize: 10),
        ),
      ));
}
