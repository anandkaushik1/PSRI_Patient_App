package com.psri_patient_app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
//import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
//import io.flutter.view.FlutterMain
import io.inway.ringtone.player.FlutterRingtonePlayerPlugin
import me.carda.awesome_notifications.AwesomeNotificationsPlugin
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
import `in`.jvapps.system_alert_window.SystemAlertWindowPlugin
import io.flutter.view.FlutterMain.*
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
//import io.flutter.plugins.androidalarmmanager.AlarmService;
///import io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin;

@Suppress("DEPRECATION")
public class Application() : FlutterApplication(), PluginRegistrantCallback {


  override fun onCreate() {
        super.onCreate()
        //FlutterFirebaseMessagingService.setPluginRegistrant(this)
        startInitialization(this)
        //  FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
       // SystemAlertWindowPlugin.setPluginRegistrant(this);
    }
  override fun registerWith(registry: PluginRegistry?) {

     /* if (!registry!!.hasPlugin("io.flutter.plugins.firebase.messaging")) {
          FlutterFirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin"));
      }*/
        if (!registry!!.hasPlugin("io.inway.ringtone.player")) {
            FlutterRingtonePlayerPlugin.registerWith(registry.registrarFor("io.inway.ringtone.player.FlutterRingtonePlayerPlugin"))
        }

        if (!registry!!.hasPlugin("me.carda.awesome_notifications")) {
            AwesomeNotificationsPlugin.registerWith(registry.registrarFor("me.carda.awesome_notifications.AwesomeNotificationsPlugin"))
        }
        if (!registry!!.hasPlugin("com.dexterous.flutterlocalnotifications")) {
            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
        }
      if (!registry!!.hasPlugin("io.flutter.plugins.sharedpreferences")) {
          SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
      }
        if (!registry!!.hasPlugin("in.jvapps")) {
            SystemAlertWindowPlugin.registerWith(registry.registrarFor("in.jvapps.system_alert_window"));
        }

       PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
       /* if (!registry!!.hasPlugin("io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin")) {
            AndroidAlarmManagerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.androidalarmmanager.AndroidAlarmManagerPlugin"));
        }*/
    }

}

