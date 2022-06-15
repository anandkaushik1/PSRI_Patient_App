
  class BasicUrl
{
  static  String versionApi="http://43.242.214.195:7777/api/EMR";
  // blk uat
/*  static   String  baseUrlToken="http://115.111.242.220:8098/api/token";
 static   String  baseUrl="http://115.111.242.220:8098/api/PatientApp";
 static   String  baseUrlGraph="http://115.111.242.220:8098/api/Graph";*/

 // blk live
/* static   String  baseUrlToken="http://115.111.242.220:8066/api/token";
 static   String  baseUrl="http://115.111.242.220:8066/api/PatientApp";
 static   String  baseUrlGraph="http://115.111.242.220:8066/api/Graph";*/

 // venkeshwar sunil.g , 123
/*   static   String  baseUrlToken="http://182.72.111.138:416/api/token";
   static   String  baseUrl="http://182.72.111.138:416/api/PatientApp";
   static   String  baseUrlGraph="http://182.72.111.138:416/api/Graph";*/

   //dhaka https://apimir.evercarebd.com:8009/ login id 10409,pw=Ehd10409
  /* static   String  baseUrlToken="https://apimir.evercarebd.com:8009/api/token";
   static   String  baseUrl="https://apimir.evercarebd.com:8009/api/PatientApp";
   static   String  baseUrlGraph="https://apimir.evercarebd.com:8009/api/Graph";*/
  //balaji
 // doctor id: 21, Password : 21
/*  static   String  baseUrlToken="http://182.71.164.45:58/api/token";
  static   String  baseUrl="http://182.71.164.45:58/api/PatientApp";
  static   String  baseUrlGraph="http://182.71.164.45:58/api/Graph";*/

  // @@@Ehd10409 , 10409 https://apimir.evercarebd.com:8013
/*  static   String  baseUrlToken="https://apimir.evercarebd.com:8013/api/token";
  static   String  baseUrl="https://apimir.evercarebd.com:8013/api/PatientApp";
  static   String  baseUrlGraph="https://apimir.evercarebd.com:8013/api/Graph";*/

    /// child trust
   /* static   String  baseUrlToken="http://1.6.80.128:822/api/token";
    static   String  baseUrl="http://1.6.80.128:822/api/PatientApp";
    static   String  baseUrlGraph="http://1.6.80.128:822/api/Graph";*/


    // venkeshwarhttp://118.185.58.101:86/  9910068478 p 1715
   /* static   String  baseUrlToken="http://118.185.58.99:4021/api/token";
    static   String  baseUrl="http://118.185.58.99:4021/api/PatientApp";
    static   String  baseUrlGraph="http://118.185.58.99:4021/api/Graph";*/


// venkeshwarhttp://136.233.110.147:86/" 9910068478 p 1715 or 190186369 9568596282
    /*static   String  baseUrlToken="http://136.233.110.147:86/api/token";
    static   String  baseUrl="http://136.233.110.147:86/api/PatientApp";
    static   String  baseUrlGraph="http://136.233.110.147:86/api/Graph";*/
   // heathworldAWS

 /*   static   String  baseUrlToken="http://13.235.220.196:511/api/token";
    static   String  baseUrl="http://13.235.220.196:511/api/PatientApp";
    static   String  baseUrlGraph="http://13.235.220.196:511/api/Graph";*/

   /* static   String  baseUrlToken="http://1.6.80.128:822/api/token";
    static   String  baseUrl="http://1.6.80.128:822/api/PatientApp";
    static   String  baseUrlGraph="http://1.6.80.128:822//api/Graph";

*/
  // chaitanya uat http://122.176.112.55:5200
   /* static   String  baseUrlToken="http://122.176.112.55:5200/api/token";
    static   String  baseUrl="http://122.176.112.55:5200/api/PatientApp";
    static   String  baseUrlGraph="http://122.176.112.55:5200/api/Graph";*/

    // chaitanya live http://122.176.112.55:8080 9023296065 p-1202
 /*   static   String  baseUrlToken="http://122.176.112.55:8080/api/token";
    static   String  baseUrl="http://122.176.112.55:8080/api/PatientApp";
    static   String  baseUrlGraph="http://122.176.112.55:8080/api/Graph";*/

    // demo heathcare database live http://122.176.112.55:8080 9023296065 p-1202
  /*  static   String  baseUrlToken="http://13.235.220.196:667/api/token";
    static   String  baseUrl="http://13.235.220.196:667/api/PatientApp";
    static   String  baseUrlGraph="http://13.235.220.196:667/api/Graph";*/

  /// kkch uat http://1.6.80.128:825/
   /* static   String  baseUrlToken="http://1.6.80.128:825/api/token";
    static   String  baseUrl="http://1.6.80.128:825/api/PatientApp";
    static   String  baseUrlGraph="http://1.6.80.128:825/api/Graph";
    static   String  baseUrlDoc="http://1.6.80.128:824";*/


    // aspl demo db http://13.235.220.196:607
    // static   String  baseUrlToken="http://13.235.220.196:607/api/token";
    // static   String  baseUrl="http://13.235.220.196:607/api/PatientApp";
    // static   String  baseUrlGraph="http://13.235.220.196:607/api/Graph";
    // static   String  baseUrlDoc="http://13.235.220.196:607";


//  PSRI UAT Data base http://182.75.170.98:210/

   // PSRI Patient App  db  UAT
    static   String  baseUrlToken="http://182.75.170.98:210/api/token";
    static   String  baseUrl="http://182.75.170.98:210/api/PatientApp";
    static   String  baseUrlGraph="http://182.75.170.98:210/api/Graph";
    static   String  baseUrlDoc="http://182.75.170.98:209";



    // PSRI Patient App live db http://182.75.170.98:210/
 /*   static   String  baseUrlToken="http://182.74.143.146:210/api/token";
    static   String  baseUrl="http://182.74.143.146:210/api/PatientApp";
    static   String  baseUrlGraph="http://182.74.143.146:210/api/Graph";
    static   String  baseUrlDoc="http://182.74.143.146:210/";*/

    static String sendUrlForTitleList()
    {
      return "http://182.75.170.98:210/api/common";
    }


    static String sendUrl()
  {
    return baseUrl;
  }
 static String sendUrlGraph()
 {
   return baseUrlGraph;
 }
 static String sendUrlToken()
 {
   return baseUrlToken;
 }


   static String sendUrlCaseSheetTest()
   {
     return baseUrlDoc+"/api/PatientApp";
   }
    static String sendUrlTesting()
    {
      return baseUrlDoc+"/api/PatientApp";
    }
    static String sendUrlToViewDocumnet()
    {
      return baseUrlDoc+"/api/PatientApp";
    }
    static String sendUrlImage()
    {
      return baseUrlDoc.trim()+"/API/ShowFile/DownloadAttachment?fileName=";
    }

    static String sendUrlTestingImage()
    {
      return baseUrlDoc.trim()+"/API/ShowFile/DownloadAttachment?fileName=";
    }


    static String sendVersionUrl()
   {
    return versionApi;
   }


}