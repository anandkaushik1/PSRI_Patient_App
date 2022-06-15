import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_List.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Request.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Response.dart';
import 'package:flutter_patient_app/Project_View/Diagnosis_pack/Diagnosis_Visit_Response.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Diagnosis_Response res=new Diagnosis_Response();

class Diagnosis_Card_List extends StatefulWidget {
  String? encounterId="";
  DiagnosisVisit? visit;
  Diagnosis_Card_List({
    Key? key,
    this.encounterId,
    this.visit,
  }) : super(key: key);


  @override
  _CardListScreenState createState() => _CardListScreenState(
    encounterId: this.encounterId,
    visit: this.visit,
  );
}

class _CardListScreenState extends State<Diagnosis_Card_List> {
  String? encounterId;
  DiagnosisVisit? visit;
  _CardListScreenState({
    Key? key,
    this.encounterId,
    this.visit,
  });
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<Diagnosis_Response>(

      future: callApi(visit!), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<Diagnosis_Response> data) {  // AsyncSnapshot<Your object type>
        if( data.connectionState == ConnectionState.waiting){
          return Loading(context);
        }else{
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10, fontWeight: FontWeight.w500),),
                )
            );
          else
            return  layout();
        }
      },
    );

  }
  Widget layout()
  {
    return Scaffold(
      appBar: patientDetails(visit!),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: res.patientDiagnosisArray!.length,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: Diagnosis_List(
                      width: MediaQuery.of(context).size.width,
                      height: 88.0,
                      DiagnosisResult:res.patientDiagnosisArray!.elementAt(index),
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

Widget Loading(BuildContext forThis){

  return new Container(
      color: Colors.white,
      child:SpinKitCubeGrid(size: 71.0, color:Color(CompanyColors.appbar_color)
      ));
}



PreferredSize patientDetails( DiagnosisVisit myDoctor) {
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
                            child :Text("" + myDoctor.doctorName.toString(),
                              style: TextStyle(
                                  color: Color(CompanyColors.appbar_color),fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                               overflow: TextOverflow.ellipsis,
                            ),

                          ),
                          Text("Encounter No : " + myDoctor.encounterNo.toString(),
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
Future<Diagnosis_Response>  callApi(DiagnosisVisit data)
async {
  String url=BasicUrl.sendUrl();
  final myService = MyServicePost.create(url);
  Diagnosis_Request objddd=new Diagnosis_Request();

  objddd.encounterId=""+data.encounterId.toString();

  objddd.facilityId=""+data.facilityID.toString();
  objddd.registrationId=""+data.registrationId.toString();

  Diagnosis_Request objj=new Diagnosis_Request.fromJson(objddd.toJson());
  Response<Diagnosis_Response> responserrr = (await myService.PatientDiagnosis(objj));
var postt = responserrr.body;
print(responserrr.body);
   res=new Diagnosis_Response.fromJson(postt!.toJson());
return Future.value(res);
}