import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class App {
  static bool authorized = false;
  static bool onduty = false;

  static Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    log("access   " + prefs.getString("access")!);
    App.authorized = prefs.containsKey("access");
  }

  static Future<void> dutyCheck() async {
    final prefs = await SharedPreferences.getInstance();
    App.onduty = prefs.getBool("onduty") ?? false;
  }

  static Future<void> sendLatLong() async {
    log("init lat long send");
    if (await Permission.location.request().isGranted) {
      Location location = new Location();
      final prefs = await SharedPreferences.getInstance();
      final _locationData = await location.getLocation();
      final lattitude = _locationData.latitude;
      final longitude = _locationData.longitude;

      Dio dio = Dio();
      dio.options.headers["Authorization"] =
          "Bearer ${prefs.getString("access")}";

      log("sending data fcm - ${prefs.getString("fcm_token")} \n lat - ${lattitude!.toStringAsFixed(4)} \n long - ${longitude!.toStringAsFixed(4)}");
      Response res = await dio.patch(
          'https://nakacheck-3.suhailahmad4.repl.co/auth/alert/',
          data: {
            "alert_id": prefs.getString("fcm_token"),
            "lattitude": lattitude.toStringAsFixed(4),
            "longitude": longitude.toStringAsFixed(4)
          },
          options: Options(
            headers: {"content-Type": "application/json"},
            validateStatus: (status) => true,
          ));

      if (res.statusCode == 200) {
        log("successful sent $res");
      } else {
        log("failed $res ${res.statusCode}");
      }
    }
  }
}
