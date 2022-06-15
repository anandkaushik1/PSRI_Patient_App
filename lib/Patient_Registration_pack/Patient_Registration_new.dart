import 'package:chopper/chopper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/NewLogin/Model/PatientLoginResponse.dart';
import 'package:flutter_patient_app/OTPLogin/Login_Screen.dart';
import 'package:flutter_patient_app/OTPLogin/VerifyOtpResponseOTP.dart';
import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/PatientViewCategories/MasterCategoriesPatient.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/NewRegistrationRequest.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/NewRegistrationResponse.dart';
import 'package:flutter_patient_app/Patient_Registration_pack/OTPResponse.dart';
import 'package:flutter_patient_app/Project_View/Prescription_Pack/Prescription_Card_List.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtRequest.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnResigrationAppmtResponse.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OTPRequest.dart';
const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);
String valueName="",valueAge="0",valueMobile="",valueGander="2",DateOfBirth="",valueDOB="",typeAge="year",valueAddress="",valueEmail="";

var ctrName = TextEditingController();
var ctrMobile = TextEditingController();
var ctrEmail = TextEditingController();
var ctrDOB = TextEditingController();
var ctrGander = TextEditingController();
var ctrAddress = TextEditingController();
var ctrOTP = TextEditingController();
String yourGander="M";
String titleSelectionbyuser = "12";
String firebaseToken= "";
List<RadioModel> radioList= <RadioModel>[];
late BuildContext confContext,loadingContext,layoutContext;
enum SingingCharacter { male, female }
class Patient_Registration_new extends StatefulWidget {
  String? DoctorId="";
  String? AppmtDate="";
  String? AppmtTime="";
  String? dotNetDateFormat="";

  Patient_Registration_new({
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
    extends State<Patient_Registration_new> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? titleSelection = "";
  String? DoctorId="";
  String? AppmtDate="";
  String? AppmtTime="";
  String? dotNetDateFormat="";
  SingingCharacter ctrGender = SingingCharacter.male;

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
        // colors: Colors.indigo,
        size: 200.0,
      ),
    ),
    1: Center(
      child: FlutterLogo(
        //colors: Colors.teal,
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
  void initState() {
    // TODO: implement initState
    radioList= <RadioModel>[];
    radioList.add(new RadioModel(true, 'Mr.', 'FID'));
    radioList.add(new RadioModel(false, 'Baby', 'SEID'));
    radioList.add(new RadioModel(false, 'Master', 'SID'));
    radioList.add(new RadioModel(false, 'Mrs', 'AID'));
    radioList.add(new RadioModel(false, 'Ms', 'jhu'));

    ctrOTP.text = "";
    titleSelectionbyuser = "12";

    firebaseToken="";
    FirebaseMessaging.instance.getToken().then((value) {
      print(token);
      firebaseToken = value!;
    });


  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ctrName.text = "";
    ctrEmail.text = "";
    ctrMobile.text = "";
    ctrDOB.text = "";
    ctrGander.text = "";
    ctrAddress.text = "";
    ctrOTP.text = "";
  }

  void callDatePicker() async {
    var order = await getDate();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(order!);
    ctrDOB.text=formatted;
    DateOfBirth=ctrDOB.text.toString();
    /* setState(() {
      finaldate = order;
    });*/
  }
  Future<DateTime?> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1918),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    layoutContext=context;
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'New Registration',
          style: TextStyle(fontSize: 16.0),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(CompanyColors.appbar_color), Color(CompanyColors.appbar_color)]),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                    color: Color(CompanyColors.appbar_color).withOpacity(.3),
                    offset: Offset(0.0, 8.0),
                    blurRadius: 8.0)
              ]),
        ),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () =>
            //Navigator.of(context).pop()
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login_Screen()),
            )
        ),
      ),
      body:  new Container(
        child:  new Stack(
          children: <Widget>[
            Image.asset('assets/New_Icons/background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),


            new Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.center,
                child: ListView(
                  children: [
                   Column(

                        children: [

                          new Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(

                                backgroundColor: Colors.white70,
                                radius: 40,
                                backgroundImage: AssetImage(
                                    'assets/images/signup.png'),
                              ),
                            ),

                          ),

                          new Container(
                            // decoration: myBoxDecoration(),
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              // margin: EdgeInsets.only(bottom: 20),
                              child: new Column(
                                children: [
                                  new Container(
                                    child: new Text(
                                      "Title",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10,0,0,0),

                                    alignment: Alignment.topLeft,
                                  ),
                                  new Container(
                                    height: 30,
                                    margin: EdgeInsets.only(left: 10),
                                    child: new ListView.builder(
                                      itemCount: radioList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return new InkWell(
                                          //highlightColor: Colors.red,
                                            splashColor:Color(0xFFFFFFFF),
                                            onTap: () {
                                              setState(() {
                                                radioList.forEach((element) =>
                                                element.isSelected = false);
                                                radioList[index].isSelected =
                                                true;
                                                if (index == 0) {
                                                  titleSelection = "Mr.";
                                                  titleSelectionbyuser="12";
                                                } else if (index == 1) {
                                                  titleSelection = "Baby";
                                                  titleSelectionbyuser="1";

                                                }else if(index==2)
                                                {
                                                  titleSelection = "Master";
                                                  titleSelectionbyuser="11";
                                                }
                                                else if(index==3)
                                                {
                                                  titleSelection = "Mrs";
                                                  titleSelectionbyuser="13";
                                                }
                                                else
                                                {
                                                  titleSelection = "Ms";
                                                  titleSelectionbyuser="15";
                                                }
                                              });
                                            },
                                            child: new Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Center(
                                                        child: RadioItem(
                                                            radioList[index]),
                                                      ),
                                                      flex: 1,
                                                    ),
                                                  ],
                                                )));
                                      },
                                    ),
                                  ),
                                ],
                              )),


                          new Container(

                            margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: new Column(
                              children: [
                                new Container(
                                  child: TextField(
                                    autocorrect: true,
                                    controller:  ctrName,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      labelText: "Patient Name",
                                      labelStyle: TextStyle(
                                          color: Colors.white70),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white70),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                new Container(
                                  child: new Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: TextField(
                                      maxLength: 10,
                                      autocorrect: true,
                                      controller: ctrMobile,
                                      style:
                                      TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: 'Mobile No',

                                        labelStyle: TextStyle(
                                            color: Colors.white70),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                new Container(
                                  child: new Container(
                                    margin: EdgeInsets.only(top: 0),
                                    child: TextField(
                                      autocorrect: true,
                                      controller: ctrEmail,
                                      style:
                                      TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email Id',
                                        labelStyle: TextStyle(
                                            color: Colors.white70),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                new Container(
                                  child: Column(
                                    children: [
                                      new Container(

                                        child: Text("Gender",style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16,fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.start,
                                        ),
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(top: 10),
                                      ),
                                      new Container(
                                        child: new Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child:  RadioListTile<SingingCharacter>(
                                                title: const Text('Male',style: TextStyle(color: Colors.white70),),
                                                value: SingingCharacter.male,
                                                activeColor: Colors.white70,
                                                groupValue: ctrGender,
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    ctrGender = value!;

                                                    yourGander="M";
                                                  });
                                                },
                                              ),



                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: RadioListTile<SingingCharacter>(
                                                title: const Text('Female',style: TextStyle(color: Colors.white70),),
                                                value: SingingCharacter.female,
                                                groupValue: ctrGender,
                                                activeColor: Colors.white70,
                                                onChanged: (SingingCharacter? value) {
                                                  setState(() {
                                                    ctrGender = value!;

                                                    yourGander="F";
                                                  });
                                                },
                                              ),


                                            ),
                                          ],

                                        ),
                                      )
                                    ],
                                  ),

                                ),

                                new Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: new Container(

                                    child: TextField(
                                      onTap: (){
                                        callDatePicker();
                                      },
                                      autocorrect: true,
                                      style:
                                      TextStyle(color: Colors.white),
                                      keyboardType: TextInputType.phone,
                                      readOnly: true,
                                      showCursor: true,
                                      controller: ctrDOB,
                                      onChanged: (String value)
                                      {

                                        // DateOfBirth=value;
                                        //(() => password = value);
                                      },
                                      decoration: InputDecoration(
                                        labelText: 'Date Of Birth',
                                        labelStyle: TextStyle(
                                            color: Colors.white70),
                                        enabledBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white70,
                                          ),
                                        ),
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white,
                                              style: BorderStyle.solid),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          new Container(
                            margin: EdgeInsets.fromLTRB(15,0,15,0),
                            child: TextField(
                              autocorrect: true,
                              controller:  ctrAddress,
                              keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                labelText: "Address",
                                labelStyle: TextStyle(
                                    color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white70),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          new Container(
                            width: 290,
                            height: 50,
                            margin: EdgeInsets.only(top: 20),
                            child: InkWell(
                              child:

                              Container(
                                width:290,
                                height:40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(CompanyColors.button_color_new),
                                          Color(CompanyColors.button_color_new)
                                        ]),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(CompanyColors.button_color_new).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0)
                                    ]),
                                child:
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      if(validation(ctrName.text.toString(), ctrMobile.text.toString(), ctrEmail.text.toString(), ctrDOB.text.toString(), ctrAddress.text.toString()))
                                      {
                                        requestForOtp(ctrMobile.text.toString());
                                      }
                                    },
                                    child:

                                    Center(
                                      child: Text("Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins-Bold",
                                              fontSize: 18,
                                              letterSpacing: 1.0)),
                                    ),
                                  ),
                                ),
                              ),
                            ),),
                        ],
                      ),
                  
                  ],
                ),
              ),
            ),
          ],
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
/*  Widget customRadioButton()
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
  }*/

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

  bool  validation(String name,String mobile, String email,String Dob , String address)
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
    }
    else if (email == "" || email == "null" || email == null) {
      valid=false;
      toastMsg="Please enter email";
    }
    else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      valid=false;
      toastMsg="Please enter valid email";

    }

    else if (Dob == "" || Dob == "null" || Dob == null) {
      valid=false;
      toastMsg="Please enter DOB ";

    }else if (address == "" || address == "null" || address == null) {
      valid=false;
      toastMsg="Please enter address ";

    }
    /* else if (typeAge != "" && typeAge != "null" && typeAge != null) {
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
    }*/
    if(toastMsg.isNotEmpty) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg),
        duration: Duration(seconds: 3),
      ));
    }
    return valid;
  }

  Future requestForOtp(String strMobile) async {

    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    OTPRequest setObj=new OTPRequest();
    setObj.mobileNo=""+strMobile;
    setObj.isFamilyMember=false;
    print("Request  \n" + setObj.toJson().toString());
    OTPRequest obj=new OTPRequest.fromJson(setObj.toJson());
    Response<OTPResponse> response = (await myService.GenerateOTPForSignup(obj));
    print(response.body);
    var post = response.body;
    if(response!=null)
    {
      if(response.body!.status!.toString().toLowerCase()=="success"||response.body!.status!.toString().toLowerCase()=="true")
      {
        /*  Navigator.pop(dialogContext);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => MasterCategoriesPatient(
              pos: 0,
              PatientDetails: response.body.patientList.elementAt(0),
            )));*/
       /* _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body.oTPno.toString()),
          duration: Duration(seconds: 10),
        ));*/
        _ConformationOfOTP(""+response.body!.oTPno.toString());

      }else {
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body!.errorMessage.toString()),
          duration: Duration(seconds: 10),
        ));
      }

    }

  }

  Future forRegistration(String strOTP) async {
    Navigator.pop(confContext);
    _onLoading();
    String url=BasicUrl.sendUrl();
    final myService = MyServicePost.create(url);
    NewRegistrationRequest setObj=new NewRegistrationRequest();
    setObj.titleId=""+titleSelectionbyuser;
    //setObj.titleId="1";
    setObj.hospitalLocationId="1";
    setObj.IsUnRegPat="1";
    setObj.isFamilyMember = false;
    setObj.facilityID="3";
    setObj.paymentFlag="0";
    setObj.firstName=""+ctrName.text;
    setObj.middleName="";
    setObj.lastName="";
    setObj.mobile=""+ctrMobile.text;
    setObj.email=""+ctrEmail.text;
    String tempppp=ctrGender.toString();
    String gnd="";
    if(tempppp.toLowerCase().trim()=="singingcharacter.female")
    {
      gnd="1";
    }else
    {
      gnd="2";
    }
    setObj.gender=gnd/*ctrGender.toString()*/;
    // setObj.gender=""+yourGander;
    var formatter = new DateFormat('dd-MM-yyyy');
    var formatterSend = new DateFormat('yyyy-MM-dd');
    DateTime dataDate = formatter.parse(ctrDOB.text.toString());
    String dataStr = formatter.format(dataDate);
    setObj.dOB=""+dataStr;
    setObj.address=""+ctrAddress.text;
    setObj.oTP=""+strOTP;
    setObj.deviceTokenNo= firebaseToken.trim();
    print("Request  \n" + setObj.toJson().toString());
    NewRegistrationRequest obj=new NewRegistrationRequest.fromJson(setObj.toJson());
    Response<NewRegistrationResponse> response = (await myService.MobSaveRegistrationForPatient(obj));
    print(response.body);
    var post = response.body;
    NewRegistrationResponse res= new NewRegistrationResponse.fromJson(post!.toJson());
    print("Response"+res.toJson().toString());
    if(response!=null)
    {
      if(response.body!.status!.toString().toLowerCase()=="success")
      {
        Navigator.pop(loadingContext);
        PatientList data=setPatientDetails(response.body!);
        saveData(data);
        VerifyPatinetList senddata = VerifyPatinetList();
        senddata.patientName=""+data.patientName.toString();
        senddata.age=""+data.age.toString();
        senddata.mobileNo=""+data.mobileNo.toString();
        senddata.dOB=""+data.ageYear.toString();
        senddata.emailId=""+data.email.toString();
        senddata.encounterId=""+data.encounterId.toString();
        senddata.facilityID=""+data.facilityId.toString();
        senddata.gender=""+data.gender.toString();
        senddata.registrationId=(int.parse(""+data.regId.toString()));
        senddata.patientType=""+data.userType.toString();

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            settings: RouteSettings(name: "/CategoriesPatient"),
            builder: (BuildContext context) => CategoriesPatient(
              pos: 0,
              PatientDetails:  senddata,
            )));
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body!.errorMessage.toString()),
          duration: Duration(seconds: 3),
        ));
      }else {
        _scaffoldKey.currentState!.showSnackBar(SnackBar(
          content: Text("" + response.body!.errorMessage.toString()),
          duration: Duration(seconds: 3),
        ));
      }

    }

  }

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        loadingContext=context;
        return Dialog(
            child: new Container(
              height: 170,
              width: 100,
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: const Color(0xFFFFFF),
                borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
              ),
              child: new Center(
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new CircularProgressIndicator(),
                    new Text("Loading"),
                  ],
                ),
              ),
            ));
      },
    );

  }
  Future<void> _ConformationOfOTP(String strOtp) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        confContext=context;
        return AlertDialog(
          title: Text('Enter OTP'/*- '+strOtp*/),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // Text(""+aptMsg),
                new Container(
                  margin: EdgeInsets.only(top: 10),
                  child:   new TextFormField(
                    //obscureText: !_passwordVisible,
                    controller: ctrOTP,
                    decoration: InputDecoration(
                      labelText: 'Enter OTP',
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6.0)),

                    ),

                    keyboardType: TextInputType.number,
                    onChanged: (String value)
                    {

                    },

                  ),
                )


              ],
            ),
          ),
          actions: <Widget>[
            /* FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),*/
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                if(validationOtp(ctrOTP.text.toString())){
                  //ctrOTP.text=strOtp;
                  forRegistration(ctrOTP.text.toString());

                }
                /*  Navigator.push(
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


  bool validationOtp(String OTPCode) {
    bool valid = true;
    String toastMsg = "";
    if (OTPCode == "" || OTPCode == "null" || OTPCode == null) {
      valid = false;
      toastMsg = "Please enter OTP";
    } else if (OTPCode.length < 4) {
      valid = false;
      toastMsg = "Please enter valid OTP ";
    }
    if (!valid) {
      _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Text("" + toastMsg),
        duration: Duration(seconds: 5),
      ));
    }
    return valid;
  }




  PatientList setPatientDetails( NewRegistrationResponse details)
  {
    PatientList data=new PatientList();
    data.patientName=details.patientName.toString();
    data.mobileNo=details.mobileNo.toString();
    data.email=details.email.toString();
    data.age=details.age.toString();
    data.hISRegistrationId=details.hISRegistrationId.toString();
    data.hospitalID=details.hospitalID.toString();
    data.facilityId=details.facilityId.toString();
    data.encounterId=details.encounterId.toString();
    data.gender=details.gender.toString();
    data.role=details.role.toString();
    data.imagePath=details.imagePath.toString();
    data.userType=details.userType.toString();
    data.firstName=details.firstName.toString();
    data.middleName=details.middleName.toString();
    data.lasttName=details.lasttName.toString();
    data.uHIDMSG=details.uHIDMSG.toString();
    data.ageYear=details.ageYear.toString();
    data.ageMonth=details.ageMonth.toString();
    data.ageDays=details.ageDays.toString();
    data.regId=details.regId.toString();
    data.regNo=details.regNo.toString();
    data.IsUnRegPat=details.isUnRegPat;
    data.videoConsultationCode=details.videoConsultationCode.toString();
    return data;
  }

  void saveData(PatientList IpPatientobject) async
  {
    final SharedPreferences setPatientInfo = await SharedPreferences.getInstance();
    setPatientInfo.setString(CommonStrAndKey.loginId, "");
    setPatientInfo.setString(CommonStrAndKey.password, "");
    setPatientInfo.setString(CommonStrAndKey.registration_id, ""+IpPatientobject.regId.toString());
    setPatientInfo.setString(CommonStrAndKey.registration_no, ""+IpPatientobject.regNo.toString());
    setPatientInfo.setString(CommonStrAndKey.patient_name, ""+IpPatientobject.patientName.toString());
    setPatientInfo.setString(CommonStrAndKey.hospital_id, IpPatientobject.hospitalID.toString());
    setPatientInfo.setString(CommonStrAndKey.hospital_name, "PSRI Hospital");
    setPatientInfo.setString(CommonStrAndKey.facility_id, IpPatientobject.facilityId.toString());
    setPatientInfo.setString(CommonStrAndKey.gender, IpPatientobject.gender.toString());
    setPatientInfo.setString(CommonStrAndKey.age, IpPatientobject.age.toString());
    setPatientInfo.setString(CommonStrAndKey.email, IpPatientobject.email.toString());
    setPatientInfo.setString(CommonStrAndKey.encounter_id, IpPatientobject.encounterId.toString());
    setPatientInfo.setString(CommonStrAndKey.encounter_no, IpPatientobject.encounterId.toString());
    setPatientInfo.setString(CommonStrAndKey.mobileNo, IpPatientobject.mobileNo.toString());
    setPatientInfo.setString(CommonStrAndKey.patient_type, IpPatientobject.userType.toString());
    setPatientInfo.setString(CommonStrAndKey.IsUnRegPat, "true");

  }


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
            height: 30.0,
            width: 60.0,
            child: new Center(
              child: new Text(_item.buttonText,
                  style: new TextStyle(
                      color: _item.isSelected ? Colors.black : Colors.white,
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: new BoxDecoration(
              color: _item.isSelected ? Color(0xffffffff) : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? Color(0xffffffff) : Colors.white),
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

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}