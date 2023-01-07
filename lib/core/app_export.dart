import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';

class App {
  static String name = "Constable";
  static bool authorized = false;
  static bool onduty = false;

  static Future<void> loginCheck() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("name")) {
      name = prefs.getString("access")!;
      log(prefs.getString("access").toString());
    }
    if (prefs.containsKey("access")) {
      log(prefs.getString("access").toString());
    }
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
      Response res =
          await dio.patch('https://nakacheck-3.suhailahmad4.repl.co/auth/alert',
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
        log("successful sent lat long $res");
      } else {
        log("failed $res ${res.statusCode}");
      }
    }
  }

  static final alertGetProvider = FutureProvider<dynamic>((ref) async {
    log("alert get");
    final prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString("access")}";

    log("sending data fcm - ${prefs.getString("fcm_token")} \n ");
    Response res = await dio.get(
      'https://nakacheck-3.suhailahmad4.repl.co/alerts/get/',
      options: Options(
        headers: {"content-Type": "application/json"},
        validateStatus: (status) => true,
      ),
    );

    if (res.statusCode == 200) {
      log("successful sent $res");
      return res.data;
    } else {
      log("failed $res ${res.statusCode}");
    }
  });
}
