import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/ImageTakecameraNgallary/Model/DocTypeResponse.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomDropDown extends StatefulWidget {
  final List<DocumentTypeList>? patientlist;

  CustomDropDown({
    Key? key,
    this.patientlist,
   }) : super(key: key);

  @override
  MyCartCounterClass createState() => MyCartCounterClass(patientlist :patientlist);

}

class MyCartCounterClass extends State<CustomDropDown> {
 //String UserId;
// VerifyPatinetList selectedItem =new VerifyPatinetList();
 List<DocumentTypeList>?  patientlist;
 DocumentTypeList selectedItem=new DocumentTypeList();
  MyCartCounterClass( {
    this.patientlist,
    } );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DocumentTypeList obj=new DocumentTypeList();
    obj.documentType="Select Document Type";
    obj.documentId=0;

    patientlist!.insert(0,obj);
    CommonStrAndKey.typeOfDocDropDown=obj;
    selectedItem = patientlist!.elementAt(0);

    //UserId =CommonStrAndKey.galobsharedPrefs!.getString(CommonStrAndKey.myID) ?? '';
   /// Home_Screen.ctrCounterValue.text= Home_Screen.ctrCounterValue.text;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
     child : DropdownButton<DocumentTypeList>(
      value: selectedItem,
      underline: Container(),
      onChanged: (DocumentTypeList? mydata) =>
          setState(() {
            selectedItem = mydata!;
            CommonStrAndKey.typeOfDocDropDown=mydata;
          }),
          ///setState(() => selectedItem = string),
      selectedItemBuilder:
          (BuildContext context) {

        return patientlist!.map((DocumentTypeList mydata) {
         // CommonStrAndKey.typeOfDocDropDown=mydata;
          return Text(
            mydata.documentType!,style: TextStyle(color: Colors.blue,),);
        }).toList();
      },
      items: patientlist!.map((DocumentTypeList string) {
        return DropdownMenuItem<DocumentTypeList>(
          child: Text(string.documentType!,style: TextStyle(color: Colors.blue,),),
          value: string,

        );
      }).toList(),
    ),);
  }
 Widget Loading(BuildContext forThis) {
   return new Container(
       color: Colors.white,
       child: SpinKitFadingCircle(size: 71.0, color: Color(0xff37b5ff)));
 }

}

