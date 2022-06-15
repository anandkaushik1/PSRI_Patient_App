import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Project_View/Graph/Vertical_bar_label_New.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomDropDownFieldId extends StatefulWidget {
  //List<DoctorLabDetails> dropDownData
  final List<CommonDropDown>? dropDownData;
  final Function()? notifyParent;
  CustomDropDownFieldId({
    Key? key,
    this.dropDownData,
    @required this.notifyParent
   }) : super(key: key);

  @override
  MyCartCounterClass createState() => MyCartCounterClass(dropDownData :dropDownData,notifyParent: notifyParent);

}

class MyCartCounterClass extends State<CustomDropDownFieldId> {
 List<CommonDropDown>?  dropDownData;
 CommonDropDown selectedItem=new CommonDropDown("","");
 Function()? notifyParent;
  MyCartCounterClass( {
    this.dropDownData,
    @required this.notifyParent
    } );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedItem = dropDownData!.elementAt(0);

  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CommonDropDown>(
      value: selectedItem,
      underline: Container(),

      onChanged: (CommonDropDown? mydata) =>
          setState(() {
            selectedItem = mydata!;
            CommonStrAndKey.selectedPatient=mydata.titleId;
            widget.notifyParent!();
            print("value==="+CommonStrAndKey.selectedPatient);

          }),

          ///setState(() => selectedItem = string),
      selectedItemBuilder:
          (BuildContext context) {

        return dropDownData!.map((CommonDropDown mydata) {
         // CommonStrAndKey.selectedPatient=mydata;
          return Container(
            alignment: Alignment.center,
           margin: EdgeInsets.only(left: 10),
           child: Text(
            mydata.title,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue,fontSize: 10),));
        }).toList();
      },
      items: dropDownData!.map((CommonDropDown string) {
        return DropdownMenuItem<CommonDropDown>(

          child: Text(string.title,style: TextStyle(color: Colors.blue,fontSize: 10),),
          value: string,

        );
      }).toList(),
    );
  }
 Widget Loading(BuildContext forThis) {
   return new Container(
       color: Colors.white,
       child: SpinKitFadingCircle(size: 71.0, color: Color(0xff37b5ff)));
 }

}

