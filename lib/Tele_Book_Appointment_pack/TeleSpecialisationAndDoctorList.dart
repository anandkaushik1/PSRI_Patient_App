
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/DoctorList_card_list_screen.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Specialisation_card_list_screen.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';

import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleDoctorList_card_list_screen.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleSpecialisation_card_list_screen.dart';
import 'package:intl/intl.dart';

var menuSelectedValue = "Specialisation";


class TeleSpecialisationAndDoctorList extends StatefulWidget {
  //final String title;

  TeleSpecialisationAndDoctorList({
    Key? key,
  //  this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<TeleSpecialisationAndDoctorList>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  _MyHomePageState() {
   // this._tabController = _tabController;
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

    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /*new WillPopScope(
      onWillPop: _onWillPop,
      child:*/ new Scaffold(
        appBar: AppBar(
          backgroundColor: Color(CompanyColors.appbar_color),
          centerTitle: true,
          title: Text(
            'Consult Doctor',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             Color(0xFF17ead9),
          //             Color(0xFF6078ea)
          //           ]),
          //       borderRadius: BorderRadius.circular(6.0),
          //       boxShadow: [
          //         BoxShadow(
          //             color: Color(0xFF6078ea).withOpacity(.3),
          //             offset: Offset(0.0, 8.0),
          //             blurRadius: 8.0)
          //       ]),
          // ),
         /* leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoriesPatient())),
          ),*/
         bottom: TabBar(

           controller: _tabController,
           indicatorColor: Color(CompanyColors.white),
           labelColor: Color(CompanyColors.grey),
           unselectedLabelColor: Colors.white,
           tabs: <Widget>[
             Tab(
               // icon: Icon(Icons.email),
               text: 'Specialisation',
             ),
             Tab(
               //icon: Icon(Icons.settings),
               text: 'DoctorList',
             ),
           ],
         ),
        ),
       /* body: new Scaffold(

          backgroundColor: Colors.white,

          appBar: TabBar(

            controller: _tabController,
            indicatorColor: Color(0xff5056ca),
            labelColor: Color(0xff5056ca),
            unselectedLabelColor: Colors.black54,
            tabs: <Widget>[
              Tab(
                // icon: Icon(Icons.email),
                text: 'Specialisation',
              ),
              Tab(
                //icon: Icon(Icons.settings),
                text: 'DoctorList',
              ),
            ],
          ),
*/
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Center(
                child: CurrentTab("Specialisation"),
              ),
              Center(
                child: CurrentTab("DoctorList"),
              ),
            ],
          ),
          //  bottomSheet: buttonVisiableOrNot(menuSelectedValue),
       // ),
      );
    //);
  }

  Widget CurrentTab(String tabTitle) {

      menuSelectedValue = tabTitle;

      if (tabTitle.toLowerCase() == "specialisation") {
        return TeleSpecialisation_card_list_screen(

        );
      } else {
        return TeleDoctorList_card_list_screen();
      }

  }
}

String convertDateFromat(var date) {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(now);
  print(formatted); // something like 2013-04-20
  return formatted;
}
