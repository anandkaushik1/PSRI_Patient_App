import 'package:flutter/material.dart';
import 'package:flutter_patient_app/ApiChopper/BaseUrl.dart';
import 'package:flutter_patient_app/ApiChopper/my_service_post.dart';
import 'package:flutter_patient_app/Book_Appointment_pack/Model/ListofDoctorResponse.dart';
import 'package:flutter_patient_app/Color_Code/Color_theme.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Favourite_Doctor/Favourite_Doctor_Request.dart';
import 'package:flutter_patient_app/Favourite_Doctor/Favourite_Doctor_Response.dart';
import 'package:flutter_patient_app/Tele_Book_Appointment_pack/TeleBook_Appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favourite_Doctor extends StatefulWidget {
  DoctorList? doctorList;
  int? pos;
  @override
  _Favourite_DoctorState createState() => _Favourite_DoctorState();
}

class _Favourite_DoctorState extends State<Favourite_Doctor> {

  Favourite_Doctor_Response? responseData;
  DoctorList? doctorList;
  int? pos;
  List<GetDoctorListArrayy> duplicateItems = <GetDoctorListArrayy>[];
  List<GetDoctorListArrayy> userlist = <GetDoctorListArrayy>[];
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteDoctor();
    CommonStrAndKey.globelDate= DateTime.now();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(CompanyColors.appbar_color),
        elevation: 0,
        title: Text('Favourite Doctor'),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ),
      body: Column(

        children: <Widget>[
          Expanded(
            flex: 100,
            child: new Container(
              color: Color(CompanyColors.grey),
              margin: EdgeInsets.fromLTRB(5, 0, 5, 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    new Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: setSearchBar(),
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: showList(),
                      width: double.infinity,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  getFavouriteDoctor() async {
    CommonStrAndKey.galobsharedPrefs = await SharedPreferences.getInstance();
    String mobileNo = CommonStrAndKey.galobsharedPrefs!
        .getString(CommonStrAndKey.mobileNo) ??
        '';

    String url = BasicUrl.baseUrl;
    final myService = MyServicePost.create(url);
    Favourite_Doctor_Request payload = new Favourite_Doctor_Request();
    payload.departmentId = '0';
    payload.hospitalLocationId = '1';
    payload.mobileno = mobileNo;
    payload.parameterType = 'P';


    print(' Response++++++++> ${payload.toJson().toString()} ');
    Favourite_Doctor_Request payloadata =
    new Favourite_Doctor_Request.fromJson(payload.toJson());
    var response = await myService.FavouriteDOctor(payloadata);




    setState(() {
      responseData = response.body;


      print(' Response++++++++> ${response.body!.msg.toString()} ');

      if(response.body!.status!.toString().toLowerCase()=="success")
        {
          if (responseData != null && responseData!.getDoctorListArrayy!.length > 0)  {

        for(var data in responseData!.getDoctorListArrayy!) {
          duplicateItems.add(data);
          userlist.add(data);
        }


      }
        }
      else{
        return noDataFound(context);
      }


    });
  }
   noDataFound(BuildContext context) {
    new Future.delayed(new Duration(seconds: 1), () {
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

  showList() {
    return getDocumentListData();
  }


  setSearchBar() {
    return new Card(
      child: new ListTile(
        leading: new Icon(Icons.search),
        title: new TextField(
          onChanged: (value) {
            filterSearchResults(value);
          },
          controller: editingController,
          decoration: new InputDecoration(
              hintText: 'Search', border: InputBorder.none),
        ),
        trailing: new IconButton(
          icon: new Icon(Icons.cancel),
          onPressed: () {
            editingController.clear();
            filterSearchResults('');
          },
        ),
      ),
    );
  }

  void filterSearchResults(String query) {
    List<GetDoctorListArrayy> dummySearchList = <GetDoctorListArrayy>[];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<GetDoctorListArrayy> dummyListData = <GetDoctorListArrayy>[];
      dummySearchList.forEach((item) {
        if (item.doctorName!.toString().toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        } else {}
      });
      setState(() {
        userlist.clear();
        userlist.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        userlist.clear();
        userlist.addAll(duplicateItems);
      });
    }
  }

  getDocumentListData() {
    if (responseData != null) {
      if (userlist != null && userlist.length >0) {
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: userlist.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                CommonStrAndKey.globelDate= DateTime.now();
                CommonStrAndKey.doctorForAppointment = userlist[index].doctorId.toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeleBook_Appointment(
                    doctorId: userlist[index].doctorId.toString(),
                    nameDoctor:userlist[index].doctorName.toString() ,

                  )),
                );
              },
              child: Card(
                child: ListTile(

                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name : ${userlist[index].doctorName}",
                          style: TextStyle(
                              color: Color(CompanyColors.appbar_color), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "Doctor : ${userlist[index].designation} ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 5,
                        ),

                        //Text("Dr R. Verma  "+ dateValue, style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300))
                      ],
                    )),
              ),
            );
          },
        );
      } else {
         setState(() {
       });
        return Center(
          child: Text('No Record Found',style: TextStyle( color : Colors.grey,fontSize: 10),),
        );

      }
    }


  }

}
