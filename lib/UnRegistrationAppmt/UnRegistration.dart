import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtRequest.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtResponse.dart';
import 'package:intl/intl.dart';
const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);
String valueName="",valueAge="0",valueMobile="",valueGander="2",valueDOB="",typeAge="year";
class UnRegistration extends StatefulWidget {
  String? DoctorId="";
  String? AppmtDate="";
  String? AppmtTime="";
  String? dotNetDateFormat="";

  UnRegistration({
    this.DoctorId,
    this.AppmtDate,
    this.AppmtTime,
    this.dotNetDateFormat,
    Key? key,
  }) : super(key: key);
  @override
  _UnRegistrationState createState() => _UnRegistrationState(
        DoctorId:this.AppmtDate,
        AppmtDate:this.AppmtDate,
        AppmtTime:this.AppmtTime,
        dotNetDateFormat: this.dotNetDateFormat,

      );
}

class _UnRegistrationState
    extends State<UnRegistration> {
  String? DoctorId="";
  String? AppmtDate="";
  String? AppmtTime="";
  String? dotNetDateFormat="";

  _UnRegistrationState({
    this.DoctorId,
    this.AppmtDate,
    this.AppmtTime,
    this.dotNetDateFormat,

  }) ;
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Male'),
    1: Text('Female'),
    /*2: Text('Logo 3'),*/
  };
  final Map<int, Widget> ageWidgets = const <int, Widget>{
    0: Text('Year(s)'),
    1: Text('Month(s)'),
    2: Text('day(s)'),
    /*2: Text('Logo 3'),*/
  };
  final Map<int, Widget> icons = const <int, Widget>{
    0: Center(
      child: FlutterLogo(
      //  colors: Colors.indigo,
        size: 200.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
      //  colors: Colors.teal,
        size: 200.0,
      ),
    ),
    /* 2: Center(
      child: FlutterLogo(
        colors: Colors.cyan,
        size: 200.0,
      ),
    ),*/
  };
  int sharedValue = 0;
  int AgeValue = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return  Scaffold(
      body: new Center(
        child: new Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(143, 148, 251, .2),
                    blurRadius: 20.0,
                    offset: Offset(0, 10)
                )
              ]
          ),
        child:SingleChildScrollView(
          child:

        Column(
          children: <Widget>[

            new Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),

              color:Color(0xff6a6fde) ,
              child: new SizedBox(

                child: new Column(children: <Widget>[
                  new Center(
                    child: new Text("Appointment for Unregistered Patient",
                     style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Colors.white ),),
                  ),
                 new Row(children: <Widget>[
                   Expanded(
                     child:new Container(
                       alignment: Alignment.centerLeft,
                       child: new Text("Date "+AppmtDate!.toString(),
                         style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Colors.white),),
                 ),

                   ),
                   Expanded(
                       child:new Container(
                         alignment: Alignment.centerRight,
                         child: new Text("Time "+AppmtTime!.toString(),
                           style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold,color:Colors.white),),
                       ),

                   ),
                 ],)
                ],)

              ),

            ),
            new Container(
              child: new TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                ),
                keyboardType: TextInputType.text,
                onChanged: (String value)
                {
                  //setState(() => doctorId = value);
                  valueName=value;
                },
              ),
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
            ),

            new Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
              child: new TextFormField(
                //obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  labelText: 'Mobile',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0)),

                ),

                  keyboardType: TextInputType.number,
                onChanged: (String value)
                {
                  valueMobile=value;
                  //(() => password = value);
                },

              ),
            ),

            new Container(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: new Column(
                children: <Widget>[
                  new TextFormField(

                    decoration: InputDecoration(
                      labelText: 'Age',

                      contentPadding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0)),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value)
                    {
                      valueAge=value;
                      //setState(() => doctorId = value);
                    },
                  ),

                  customRadioButtonForAge(),


                ],

              ),
              decoration: myBoxDecoration(),
            ),


            new Container(
              height: 55,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: customRadioButton(),
              decoration: myBoxDecoration(),
            ),
            new Container(
              width: 600,
              height: 50,
              margin: EdgeInsets.only(top: 20),
              child: new RaisedButton(

                color: Color(0xff6a6fde),
                textColor: Colors.white,
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0),
                    side: BorderSide(color: Colors.white)
                ),
                child: Text('Submit',

                  style: TextStyle(
                    background: Paint()
                      ..color = Colors.transparent,
                    // decoration: TextDecoration(BlendMode.color))

                  ),

                ),

                onPressed: () {

                  if(validation(valueName, valueMobile, valueAge, valueGander, typeAge))
                    {
                      bookAppointment(AppmtDate!.toString(), AppmtTime!.toString());
                    }

                },


              ),
            ),


          ],
        ),
      ),
      ),

      ),


    );


  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        width: 1, //                   <--- border width here
      ),
        borderRadius: BorderRadius.circular(6.0),
    );
  }
  Widget customRadioButton()
  {
    return new Container(
      child:
          SizedBox(
            width: 600.0,
            height: 60,
            child: CupertinoSegmentedControl<int>(
              children: logoWidgets,
              onValueChanged: (int val) {
                setState(() {
                  sharedValue = val;
                  if (val == 0) {
                    valueGander = "2";
                  } else {
                    valueGander = "1";
                  }
                });
              },
              groupValue: sharedValue,
            ),
          ),


    );
  }

  Widget customRadioButtonForAge()
  {
    return
      SizedBox(
        width: 600.0,
        height: 40,

        child: CupertinoSegmentedControl<int>(

          children: ageWidgets,
          onValueChanged: (int val) {
            setState(() {
              AgeValue = val;
              if (val == 0) {
                typeAge="year";
              } else if (val == 1) {
                typeAge="month";
              } else if (val == 2) {
                typeAge="day";
              }
            });
          },
          groupValue: AgeValue,

        ),

      );

  }

  bool  validation(String name,String mobile, String age,String gander , typeAge)
  {
    bool valid = true;
    String toastMsg="";
    if (name == "" || name == "null" || name == null) {
      valid=false;
      toastMsg="Please enter name";

    } else if (mobile == "" || mobile == "null" || mobile == null) {
      valid=false;
      toastMsg="Please enter mobile no";

    } else  if (mobile.length<10) {
        valid=false;
        toastMsg="Please enter valid mobile no";



    }else if (age == "" || age == "null" || age == null||age=="0") {
      valid=false;
      toastMsg="Please enter age";

    }  else if (gander == "" || gander == "null" || gander == null) {
      valid=false;
      toastMsg="Please enter gander infomation ";

    }
    else if (typeAge != "" && typeAge != "null" && typeAge != null) {
      int intAge=int.parse(age);
      if (typeAge == "year") {
        if(intAge<1||intAge>100)
          {
            toastMsg="Please enter valid year(s) ";
            valid=false;
          }

      } else if (typeAge == "month") {
        if(intAge<1||intAge>12)
        {
          toastMsg="Please enter valid month(s) (Less 13)";
          valid=false;
        }

      } else if (typeAge == "day") {
        if(intAge<1||intAge>31)
        {
          toastMsg="Please enter valid day(s) ";
          valid=false;
        }
      }
    }
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(toastMsg),
    ));
    return valid;
  }
  Future bookAppointment(String strDate,String timeSlot) async {

    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    UnResigrationAppmtRequest setObj=new UnResigrationAppmtRequest();

    setObj.hospitalLocationId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.hospital_id) ?? '';
    setObj.facilityID=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.facility_id_first) ?? '';
    setObj.mobile=""+valueMobile;
    setObj.gender=""+valueGander;
    if (typeAge == "day") {
      setObj.ageDay = "" + valueAge;
    } else if (typeAge == "month") {
      setObj.ageMonth = "" + valueAge;
    } else {
      setObj.ageYear = "" + valueAge;
    }
    setObj.appFromTime=""+timeSlot;
    setObj.appToTime=""+timeSlot;
  /*  var dateNotFromat = DateFormat("yyyy-MM-dd").format(
        DateTime.parse(Dashbroad.globelDate.toString()));*/
    setObj.appointmentDate=""+dotNetDateFormat.toString();
    setObj.appointmentSource=""+CommonStrAndKey.AppointmentBookingthroughMobile;
    setObj.dOB="";
    setObj.doctorId=CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.doctor_id) ?? '';
    setObj.fullName=""+valueName;
    setObj.visitTypeId="1";


    UnResigrationAppmtRequest obj=new UnResigrationAppmtRequest.fromJson(setObj.toJson());
    Response<UnResigrationAppmtResponse> response = (await myService.SaveAppointmentUnRegisteredPatient(obj));
    print(response.body);
    var post = response.body;
    if(response!=null)
    {
      if(response.body!.status.toString().toLowerCase()=="success")
      {

       if(response.body!.errorMessage!=null&&response.body!.errorMessage.toString().trim()!="") {
         _ConformationOfAppointment(response.body!.errorMessage.toString());
       }else {
         Scaffold.of(context).showSnackBar(SnackBar(
           content: Text("" + post!.errorMessage.toString()),
         ));
       }
      }
    }

  }

  Future<void> _ConformationOfAppointment(String aptMsg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment Booked'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(""+aptMsg),

              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                 /*Navigator.push(
                 context,
                 MaterialPageRoute(builder: (mContext) => Dashbroad()),
                );*/
              },
            ),
          ],
        );
      },
    );
  }
}