import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

void notificationInit() async {
  final _fcm = await FirebaseMessaging.instance;
  final token = await _fcm.getToken();
  final prefs = await SharedPreferences.getInstance();
  log(token.toString());
  prefs.setString("fcm_token", token ?? "null");
  _fcm.getInitialMessage().then((value) {
    if (value != null) {
      //logic when app is terminated
      print(value.notification!.title! + value.notification!.body!);
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
//logic when app in background
    print(event.notification!.title! + event.notification!.body!);
  });
}
