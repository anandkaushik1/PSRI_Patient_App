
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Graph_Vital/Sub_View_Vertical_bar_label.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomDropDownDisplayTime extends StatefulWidget {
  //List<DoctorLabDetails> dropDownData
  final List<CommonDropDownForFilter>? dropDownData;
  final Function()? notifyParent;
  CustomDropDownDisplayTime({
    Key? key,
    this.dropDownData,
    @required this.notifyParent
   }) : super(key: key);

  @override
  MyCartCounterClass createState() => MyCartCounterClass(dropDownData :dropDownData,notifyParent: notifyParent);

}

class MyCartCounterClass extends State<CustomDropDownDisplayTime> {
 List<CommonDropDownForFilter>?  dropDownData;
 CommonDropDownForFilter selectedItem=new CommonDropDownForFilter("","");
 Function()? notifyParent;
  MyCartCounterClass( {
    this.dropDownData,
    @required this.notifyParent
    } );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedItem = dropDownData!.elementAt(3);

  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<CommonDropDownForFilter>(
      value: selectedItem,
      underline: Container(),

      onChanged: (CommonDropDownForFilter? mydata) =>
          setState(() {
            selectedItem = mydata!;
            CommonStrAndKey.selectedGraphDisplayTime=mydata.titleId;
            widget.notifyParent!();
            print("value==="+CommonStrAndKey.selectedGraphDisplayTime);

          }),

          ///setState(() => selectedItem = string),
      selectedItemBuilder:
          (BuildContext context) {

        return dropDownData!.map((CommonDropDownForFilter mydata) {

          return Container(
            alignment: Alignment.center,
           margin: EdgeInsets.only(left: 10),
           child: Text(
            mydata.title,textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue,fontSize: 10),));
        }).toList();
      },
      items: dropDownData!.map((CommonDropDownForFilter string) {
        return DropdownMenuItem<CommonDropDownForFilter>(

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

