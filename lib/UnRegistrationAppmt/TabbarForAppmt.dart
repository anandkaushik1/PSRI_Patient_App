import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Models/ListOfAppointmentResponse.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/RegPatientAppmt.dart';
import 'package:flutter_patient_app/UnRegistrationAppmt/UnRegistration.dart';

import 'package:intl/intl.dart';

var menuSelectedValue="Apmt";

class TabbarForAppmt extends StatelessWidget {
  static DateTime globelDate=DateTime.now();

  final DoctorAppAppointmentSchedule? AppointmentSchedule;

   TabbarForAppmt({
    Key? key,
    this.AppointmentSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Appointment',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.white,


      ),

      home: Material(

        child:  MyRegistrationPage(title: 'Appointment',AppointmentSchedule: AppointmentSchedule,),
      ),

    );

  }
}

class MyRegistrationPage extends StatefulWidget {
  DoctorAppAppointmentSchedule? AppointmentSchedule;
  final String? title;
  MyRegistrationPage({Key? key,
    this.title,
    this.AppointmentSchedule
  }) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState(AppointmentSchedule);
}

class _MyHomePageState extends State<MyRegistrationPage> with TickerProviderStateMixin,  WidgetsBindingObserver {
  DoctorAppAppointmentSchedule? AppmtSchedule;
  late TabController _tabController;
  var _selectedValue = DateTime.now();
  String strSelectedDate="";
  List<RadioModel> radioList= <RadioModel>[];
  _MyHomePageState(DoctorAppAppointmentSchedule? AppointmentSchedule){

      this.AppmtSchedule = AppointmentSchedule;
      this.strSelectedDate = AppointmentSchedule!.appointmentTime.toString();

  }
  Future<bool> _onWillPop() async {
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
            onPressed: () => exit(0),

            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
   // radioList!.add(new RadioModel(true, 'NAME', 'FID'));
    radioList!.add(new RadioModel(false, 'MRD NO', 'SEID'));
    radioList!.add(new RadioModel(false, 'MOBILE', 'THID'));
  //  radioList!.add(new RadioModel(false, 'BED NO', 'FOID'));
    _tabController = new TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
      onWillPop: _onWillPop,
      child:  new   Scaffold(

/*
        appBar: AppBar(
          title: Text('Dashbroad',style: TextStyle(fontSize: 16.0),textAlign: TextAlign.center,),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashbroad())),),
        ),
        body:   new Scaffold(
          backgroundColor: Colors.white,

          appBar: TabBar(
            controller: _tabController,
            indicatorColor:  Color(0xff5056ca),
            labelColor:  Color(0xff5056ca),
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[

              Tab(
                // icon: Icon(Icons.email),
                text: 'Registration',
              ),
              Tab(
                //icon: Icon(Icons.settings),
                text:'UnRegistration',
              ),

            ],

          ),

          body: TabBarView(

            controller: _tabController,
            children: <Widget>[


              Center(

                child:  CurrentTab("IPD",strSelectedDate, _selectedValue,radioList,AppmtSchedule),
              ),
              Center(
                child: CurrentTab("OPD",strSelectedDate, _selectedValue,radioList,AppmtSchedule),
              ),
            ],

          ),
          //  bottomSheet: buttonVisiableOrNot(menuSelectedValue),




        ),*/

      ),
    );
  }

/*
  Widget buttonVisiableOrNot(String menuSelectedType)
  {
    if(menuSelectedType.toLowerCase()=="ipd"||menuSelectedType.toLowerCase()=="opd")
    {
      return new Text("");
    }else
    {
      return new Container(
        child:  DatePickerTimeline(
          _selectedValue,
          onDateChange: (date) {
            // New date selected
            setState(() {
              _selectedValue = date;
            });
          },
        ),
      );
    }

  }*/

 /* Widget CurrentTab( String tabTitle,String strDate,DateTime _selectedDate, List<RadioModel> radioList,DoctorAppAppointmentSchedule Appmt)
  {
    try {
      menuSelectedValue = tabTitle;
      var dateFormate = DateFormat("dd-MM-yyyy").format(
          DateTime.parse(Dashbroad.globelDate.toString()));
      var dotNetDateFormat = DateFormat("yyyy-MM-dd").format(
          DateTime.parse(Dashbroad.globelDate.toString()));

      if (tabTitle.toLowerCase() == "ipd") {
        return RegPatientAppmt(
          patientType: "ip",
          selectedDate: convertDateFromat(_selectedValue),
          superRadioList: radioList,
          selectedDatedotNetFormat:dotNetDateFormat ,
          selectedTime: "" + AppmtSchedule.appointmentTime.toString(),
        );
      } else {
        return UnRegistration(
          DoctorId: "" + CommonStrAndKey.doctor_id,
          AppmtDate: ""+dateFormate,
          AppmtTime: "" + AppmtSchedule.appointmentTime.toString(),
          dotNetDateFormat: ""+dotNetDateFormat,
        );
      }
    }on Exception catch (_)
    {
      print("sdsad");
    }

  }*/


  Widget roundedButton(String buttonLabel, Color bgColor, Color textColor) {
    var loginBtn = new Container(
      padding: EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      decoration: new BoxDecoration(
        color: bgColor,
        borderRadius: new BorderRadius.all(const Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF696969),
            offset: Offset(1.0, 6.0),
            blurRadius: 0.001,
          ),
        ],
      ),
      child: Text(
        buttonLabel,
        style: new TextStyle(
            color: textColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
    return loginBtn;
  }

}

String convertDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}

class RadioModel {
  bool isSelected;
  final String buttonText;
  final String text;

  RadioModel(this.isSelected, this.buttonText, this.text);
}