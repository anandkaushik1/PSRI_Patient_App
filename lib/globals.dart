library  flutter_patient_app.globals;

import 'package:firebase_messaging/firebase_messaging.dart';

bool isLoggedIn = false;

final globals thing = new globals._private();

 class globals {
  static  RemoteMessage myvideoData = new RemoteMessage();
  globals._private() { print('#2'); }

}