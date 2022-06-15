import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/LabVisitResponse.dart';
import 'package:flutter_patient_app/Project_View/Lab_Result_Pack/Lab_Card_List.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'LabVisitRequest.dart';
import 'Lab_Report_Response.dart';

late List<_Page> _allPages ;
LabVisitResponse  res=new LabVisitResponse();
class LabReport extends StatefulWidget {
  PatientDetailsArray? IpPatient;
  LabReport({
    Key? key,
    this.IpPatient,

  }) : super(key: key);
  @override
  _NestedTabBarStateee createState() => _NestedTabBarStateee(IpPatient: IpPatient);
}

class _NestedTabBarStateee extends State<LabReport>
   {
     PatientDetailsArray? IpPatient;
     _NestedTabBarStateee({

       this.IpPatient,

     });

  @override
  void initState() {
    super.initState();
     _allPages=<_Page>[];
  }

  @override
  void dispose() {
    super.dispose();
    //_nestedTabControllerrr.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LabVisitResponse>(
      future: callApi( '${""}'), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<LabVisitResponse> data) {  // AsyncSnapshot<Your object type>
        if( data.connectionState == ConnectionState.waiting){
          return Loading(context);
        }else{
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                )
            );
          else
            _allPages.clear();
            for(int i=0;i<data.requireData.visitHistory!.length;i++)
            {
              _Page value=new _Page();
              //  value.text="12-3-5 IP";
              String sdad=data.requireData.visitHistory!.elementAt(i).encounterDate.toString();
              value.text=data.requireData.visitHistory!.elementAt(i).encounterDate.toString()+"-"+data.requireData.visitHistory!.elementAt(i).oPIP.toString()+"P";
              value.pos=i;
              _allPages.add(value);
            }
            return  layout(context);
        }


      },

    );
  }

  Widget layout(BuildContext context)
  {

    return DefaultTabController(
      length: _allPages!.length,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,

            title: Text('LabReport',style: TextStyle(fontSize: 16.0),),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop()),
            bottom: /*PreferredSize(
                child:*/ TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.3),
              indicatorColor: Colors.white,
              tabs:_allPages.map<Tab>((_Page page)
              {
                return Tab(text: page.text);
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
          ),
          body: TabBarView(
            children: _allPages.map<Widget>((_Page page) {
              return  Container(
                child: Center(
                  child: Lab_Card_List(
                    encounterNo: res.visitHistory!.elementAt(page.pos!.toInt()).encounterNo,
                    visit:res.visitHistory!.elementAt(page.pos!.toInt()),


                  ),
                ),
              );
            }).toList(),


          )

      ),

    );
  }




  Future<LabVisitResponse>  callApi(String r)
  async {
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    LabVisitRequest req=new LabVisitRequest();

    req.registrationNo=""+IpPatient!.registrationNo.toString();


    //{"BEDNo":"","DoctorId":"105","FacilityId":"","Filter":"","HospitalLocationId":"","Mobile":"","OPIP":"I","PatientName":"","RegistrationNo":""}

    LabVisitRequest objj=new LabVisitRequest.fromJson(req.toJson());
    Response<LabVisitResponse> responserrr = (await myService.GetInvestigationVisit(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res=new LabVisitResponse.fromJson(postt!.toJson());
    // Response{protocol=http/1.1, code=200, message=OK, url=http://124.124.193.75:8098/api/doctor/AppointmentSchedule}
    // {"DoctorId":"105","FacilityId":"2","Filter":"O","FromDate":"2019-12-26","HospitalLocationId":"1"}
    return Future.value(res);
  }
  Widget Loading(BuildContext forThis){

    return new Container(
        color: Colors.white,
        child:SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
    ));
  }


/*  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }*/

   /*  Future<bool> _onWillPop() async {
       return  Navigator.pop(context);
     }*/

}



class _Page {
   _Page({ /*this.icon,*/ this.text });
 /* final IconData icon;*/
   String? text;
   int? pos;
}


