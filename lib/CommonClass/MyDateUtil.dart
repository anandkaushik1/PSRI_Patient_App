import 'package:intl/intl.dart';
class MyDateMethod{


  static bool isAfterDatewithCurrentDate(String fromdate,String todate)
  {

    DateTime fromDT=convertStringToDateYMD(fromdate);
    DateTime toDT=convertStringToDateYMD(todate);
    print(fromDT.toString()+" isAfterDatewithCurrentDate="+toDT.toString());

    if(fromDT.isAfter(toDT))
    {
      print(" now true  =");
      return true;
    }else
    {
      print(" now false =");
      return false;
    }
  }


  static DateTime convertStringToDateDMY(String strDate)
  {
    DateTime dtDate;
    dtDate= new DateFormat("dd-MM-yyyy").parse(strDate);
    print("convertStringToDateDMY="+dtDate.toString());
    return dtDate;
  }

  static String convertDateToStringYMD(DateTime vdate)
  {
    String strDate;
    strDate = DateFormat("yyyy-MM-dd").format(vdate);
    print("convertDateToStringYMD="+strDate);
    return strDate;
  }

  static String convertDateToStringDMY(DateTime vdate)
  {
    String strDate;
    strDate = DateFormat("yyyy-MM-dd").format(vdate);
    print("convertDateToStringDMY="+strDate);
    return strDate;
  }


  static bool compareTimewithCurrentTimeProgressNoteEdit(String strDate,String mint)
  {
    String tempStrDate=strDate.trim();
    DateTime dtDate,nowDate;
    dtDate = new DateFormat("dd/MM/yyyy HH:mm").parse(tempStrDate);
    nowDate= new DateFormat("yyyy-MM-dd HH:mm").parse(DateTime.now().subtract(Duration(minutes: 120)).toString());

    print(" selected date time =  "+tempStrDate+"  "+dtDate.toString());
    print(" now date time date =  "+nowDate.toString());
    if(dtDate.isAfter(nowDate))
    {
      print(" now true time =");
      return true;

    }else{
      print(" now false time =");
      return false;
    }



  }

  String convertDateToStringFromatForView(var date) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MM-yyyy');
    String formatted = formatter.format(date);
    print(formatted); // something like 2013-04-20
    return formatted;
  }
  static bool compareTimewithbothSelectedTime(String strFromDate,String strFromTime,String strToDate, strToTime)
  {
    String tempFromStrDate=strFromDate+" "+strFromTime;
    String tempToStrDate=strToDate+" "+strToTime;
    DateTime fromDateTime,toDateTime;
    fromDateTime = new DateFormat("yyyy-MM-dd HH:mm").parse(tempFromStrDate);
    toDateTime= new DateFormat("yyyy-MM-dd HH:mm").parse(tempToStrDate);
    print(" selected date time ="+fromDateTime.toString());
    print(" now date time date ="+toDateTime.toString());
    if(toDateTime.isAfter(fromDateTime))
    {
      print(" now true time =");
      return true;

    }else{
      print(" now false time =");
      return false;
    }



  }

  // for Appointment
  static bool isBeforeDatewithCurrentDate(String fromdate,String todate)
  {

    DateTime fromDT=convertStringToDateYMD(fromdate);
    DateTime toDT=convertStringToDateYMD(todate);
    print(fromDT.toString()+" isBeforeDatewithCurrentDate="+toDT.toString());

    if(fromDT.isBefore(toDT))
    {
      print(" now true  =");
      return true;
    }else
    {
      print(" now false =");
      return false;
    }
  }
  // for Appointment
  static DateTime convertStringToDateYMD(String strDate)
  {
    DateTime dtDate;
    dtDate = new DateFormat("yyyy-MM-dd").parse(strDate);
    print("convertStringToDateDMY="+dtDate.toString());
    return dtDate;
  }

  // for Appointment
  static bool compareTimewithCurrentTime(String strDate,String time)
  {
    String tempStrDate=strDate+" "+time;
    DateTime dtDate,nowDate;
    dtDate = new DateFormat("yyyy-MM-dd HH:mm").parse(tempStrDate);
    nowDate= new DateFormat("yyyy-MM-dd HH:mm").parse(DateTime.now().toString());
    print(" selected date time ="+tempStrDate+""+dtDate.toString());
    print(" now date time date ="+nowDate.toString());
    if(dtDate.isAfter(nowDate))
    {
      print(" now true time =");
      return true;

    }else{
      print(" now false time =");
      return false;
    }



  }

}