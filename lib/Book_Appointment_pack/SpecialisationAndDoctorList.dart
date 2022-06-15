
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/DoctorList_card_list_screen.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Specialisation_card_list_screen.dart';

import 'package:flutter_patient_app/PatientViewCategories/CategoriesPatient.dart';
import 'package:intl/intl.dart';

var menuSelectedValue = "Specialisation";

/*class SpecialisationAndDoctorList extends StatelessWidget {
  SpecialisationAndDoctorList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor List',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.white,
      ),
      home: Material(
        child: MyDoctorListPage(title: 'Doctor List'),
      ),
    );
  }
}*/

class SpecialisationAndDoctorList extends StatefulWidget {
  //final String title;

  SpecialisationAndDoctorList({
    Key? key,
  //  this.title,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SpecialisationAndDoctorList>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;

  _MyHomePageState() {
    this._tabController = _tabController;
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
          centerTitle: true,
          title: Text(
            'Doctor List',
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF17ead9),
                      Color(0xFF6078ea)
                    ]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
          ),
         /* leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => CategoriesPatient())),
          ),*/
         bottom: TabBar(

           controller: _tabController,
           indicatorColor: Color(0xff5056ca),
           labelColor: Color(0xff5056ca),
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
        return Specialisation_card_list_screen(

        );
      } else {
        return DoctorList_card_list_screen();
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
