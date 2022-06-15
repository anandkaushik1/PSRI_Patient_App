import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientLstCard.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientSearchWithFiltterRequest.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/PatientSearchWithFiltterResponse.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/TabbarForAppmt.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtResponse.dart';
import 'package:intl/intl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatient.dart';
import 'package:flutter_patient_app/Models/ListOfIpPatientResponse.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';


PatientSearchWithFiltterResponse res = new PatientSearchWithFiltterResponse();
late List<RadioModel> superRadioButtonList;
String tempTypeOfSearch="name";
bool visibleFlg=false;
int listSize=0;
class RegPatientAppmt extends StatefulWidget {
  List<RadioModel>? superRadioList;
  String? patientType = "";
  String? selectedDate;
  String? typeOfSearch="";
  String? valueOfSearch="";
  String? filter="";
  String? selectedDatedotNetFormat;
  String? selectedTime;

  RegPatientAppmt({
    this.patientType,
    this.selectedDate,
    this.superRadioList,
    this.typeOfSearch,
    this.valueOfSearch,
    this.filter,
    this.selectedTime,
    this.selectedDatedotNetFormat,
    Key? key,
  }) : super(key: key);

  @override
  _CardListScreenState createState() => _CardListScreenState(
    patientType: this.patientType,
    selectedDate: this.selectedDate,
    superRadioList: this.superRadioList,
    typeOfSearch: this.typeOfSearch,
    valueOfSearch: this.valueOfSearch,
    filter: this.filter,
    selectedTime: this.selectedTime,
    selectedDatedotNetFormat: this.selectedDatedotNetFormat,
  );
}

class _CardListScreenState extends State<RegPatientAppmt> {
  String? patientType = "";
  String? selectedDate;
  List<RadioModel>? superRadioList;
  String? typeOfSearch="";
  String? valueOfSearch="";
  String? filter="";
  String? selectedDatedotNetFormat="";
  String? selectedTime="";


  _CardListScreenState({
    this.patientType,
    this.selectedDate,
    this.superRadioList,
    this.typeOfSearch,
    this.valueOfSearch,
    this.filter,
    this.selectedTime,
    this.selectedDatedotNetFormat,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    visibleFlg=false;
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //do your stuff
      visibleFlg=false;
    }
  }
  @override
  Widget build(BuildContext context) {
    superRadioButtonList = superRadioList!;

    return layout(superRadioList!,visibleFlg,listSize);
  //  return callBackApiResponse(patientType,typeOfSearch,valueOfSearch);
  }

  Widget callBackApiResponse(List<RadioModel> radioList,bool visiFlg,int size,BuildContext context)
  {
    return FutureBuilder<PatientSearchWithFiltterResponse>(
      future: callApi('${patientType}',typeOfSearch!,valueOfSearch,context),
     // function where you call your api
      builder:
          (BuildContext context, AsyncSnapshot<PatientSearchWithFiltterResponse> data) {
        // AsyncSnapshot<Your object type>
        if (data.connectionState == ConnectionState.waiting) {
          return Loading(context,typeOfSearch!);
        } else {
          if (data.hasError)
            return new Container(
                color: Colors.white,
                child: Center(
                  child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
                )
            );
          else if (data.requireData.status!.toString().toLowerCase() == "success") {
            if (data.requireData.patientDetailsArray != null) {
              if (data.requireData.patientDetailsArray!.length > 0) {

          if (res.patientDetailsArray!.length > 0) {

            visibleFlg = true;
            listSize=res.patientDetailsArray!.length;
          } else {
            visibleFlg = false;
            listSize=0;

          }
                return listViewVisiabltOrNot(radioList,visibleFlg,listSize,context);
              } else {
                return Center(child: Text('Error: ${data.error}'));
              }
            } else {
              return Center(child: Text('Error: ${data.error}'));
            }
          } else {
            return Center(child: Text('Error: ${data.error}'));
          }
        }
      },
    );
  }

  Widget customRadioList(List<RadioModel> radioList, int pos) {
    String searchValue="";
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 88,
      child: new Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              width: 200,
              child: new Center(
                child: new ListView.builder(
                  itemCount: radioList!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return new InkWell(
                      //highlightColor: Colors.red,
                        splashColor: Color(0xff6a6fde),
                        onTap: () {
                          setState(() {
                            radioList
                                .forEach((element) => element.isSelected = false);
                            radioList[index].isSelected = true;
                            if(index==0)
                            {
                              tempTypeOfSearch="name";
                            }else if(index==1)
                            {
                              tempTypeOfSearch="uhid";
                            }else if(index==2)
                            {
                              tempTypeOfSearch="mobile";
                            }else
                            {
                              tempTypeOfSearch="bed";
                            }
                          });
                        },
                        child: new Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: RadioItem(radioList[index]),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            )));
                  },
                ),
              ),
            )
          ),
          Expanded(
            flex: 1,

            child:new Container(
                margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 75,
                      child:new TextFormField(
                        maxLines: 1,
                        style: new TextStyle(
                            color: Color(0xff6a6fde)
                        ),
                        onChanged: (String value)
                        {
                          searchValue = value;
                        },
                        decoration: new InputDecoration(

                          hintText: "Search...",
                          hintStyle: new TextStyle(color: Color(0xff6a6fde)),
                          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0)),

                        ),
                      ),
                    ),
                    Expanded(
                      flex: 25,
                      child: RaisedButton(
                        onPressed: ()  {

                          valueOfSearch= searchValue;
                          if(valueOfSearch=="")
                          {
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text("Please enter search value"),
                            ));
                          }else
                          {
                            setState(() {
                              valueOfSearch=searchValue;
                              typeOfSearch=tempTypeOfSearch;
                              visibleFlg=true;
                              //callApi(patientType, typeOfSearch, valueOfSearch,context);

                            });

                          }

                        },
                        color:Color(0xff6a6fde) ,
                        textColor: Colors.white,

                        child: Text("Search",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),

                        ),
                      ),
                    )

                  ],
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget layout(List<RadioModel> radioList,bool visiFlg,int size) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: customRadioList(radioList, 1),
      ),
      body:callBackApiResponse(radioList,visiFlg,size,context)
    );
  }

  Widget listViewVisiabltOrNot(List<RadioModel> radioList,bool visiFlg,int size,BuildContext context)
  {
    return Visibility(
      visible: visiFlg,
      child:SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: listSize,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 44.0,
                  child: FadeInAnimation(
                    child: PatientLstCard(
                      width: MediaQuery.of(context).size.width,
                      height: 88.0,
                      IpPatient: res.patientDetailsArray!.elementAt(index),
                      pos: index,
                      selectedTime: selectedTime,
                      selectedDate: selectedDatedotNetFormat,
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

  Future<PatientSearchWithFiltterResponse> callApi(String patientType,String typeSearch,searchValue,BuildContext context)
  async {
    String url=BasicUrl.sendUrl();
   // _onLoading(context);
    final myService = MyServicePost.create(url);
    PatientSearchWithFiltterRequest objddd = new PatientSearchWithFiltterRequest();
    if (typeSearch == "name") {
      objddd.bEDNo = "";
      objddd.mobile = "";
      objddd.patientName = "" + searchValue;
      objddd.registrationNo = "";
    } else if (typeSearch == "uhid") {
      objddd.bEDNo = "";
      objddd.mobile = "";
      objddd.patientName = "";
      objddd.registrationNo = "" + searchValue;
    } else if (typeSearch == "mobile") {
      objddd.bEDNo = "";
      objddd.mobile = "" + searchValue;
      objddd.patientName = "";
      objddd.registrationNo = "";
    } else if (typeSearch == "bed") {
      objddd.bEDNo = "" + searchValue;
      objddd.mobile = "";
      objddd.patientName = "";
      objddd.registrationNo = "";
    } else {
      objddd.bEDNo = "";
      objddd.mobile = "";
      objddd.patientName = "";
      objddd.registrationNo = "";
    }


 /*   objddd.bEDNo = "";
    objddd.mobile = "9810845913";
    objddd.patientName = "";
    objddd.registrationNo = "";*/


    //{"BEDNo":"","DoctorId":"105","FacilityId":"","Filter":"","HospitalLocationId":"","Mobile":"","OPIP":"I","PatientName":"","RegistrationNo":""}

    PatientSearchWithFiltterRequest objj =
    new PatientSearchWithFiltterRequest.fromJson(objddd.toJson());
    Response<PatientSearchWithFiltterResponse> responserrr =
    (await myService.GetRegisteredPatientList(objj));
    var postt = responserrr.body;
    print(responserrr.body);
    res = new PatientSearchWithFiltterResponse.fromJson(postt!.toJson());
    /*if (res != null) {
      if (res.status.toLowerCase() == "success") {

        setState(() {
          if (res.patientDetailsArray.length > 0) {

            visibleFlg = true;
            listSize=res.patientDetailsArray.length;
          } else {
            visibleFlg = false;
            listSize=0;

          }
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(""+res.msg.toString()),
        ));

      }
      // return Future.value(res);
    }*/
    return Future.value(res);
  }
}

Widget Loading(BuildContext forThis,String type) {
  bool isVisi=false;
  if(type!=null&&type!="")
    {
      isVisi=true;
    }
  return new Container(

      color: Colors.white,
      child:Visibility(
        visible: isVisi,
        child: new Center(
          child: SpinKitCubeGrid(size: 71.0, color:Color(0xff6a6fde)
          ),
        ),
      )
  );
}


String changeDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(2.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 40.0,
            width: 86.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Color(0xff6a6fde) : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Color(0xff6a6fde) : Colors.grey),
              borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          /* new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )*/
        ],
      ),
    );
  }

}
Future<void> _onLoading(BuildContext context) async{
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(

        child: new Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            new Container(
              height: 100,
              width: 100,
              color: Colors.white,
              child:new Center(
                child:  new Column(
                  children: <Widget>[

                new Center( child: new CircularProgressIndicator(),),
                new Center( child:    new Text("Loading"),),
                  ],
                ),
              )

            )

          ],
        ),
      );
    },
  );
}