import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio dio = Dio();

  String swtichDuty =
      'https://nakacheck-3.suhailahmad4.repl.co/alerts/auth/onoffduty/';
  String getalerts =
      "https://nakacheck-3.suhailahmad4.repl.co/alerts/get/vehicle/";
  String chkSus =
      "https://nakacheck-3.suhailahmad4.repl.co/alerts/checkSuspicious/";
  String spot =
      "https://nakacheck-3.suhailahmad4.repl.co/alerts/caughtSuspicious/";

  String alert =
      "https://nakacheck-3.suhailahmad4.repl.co/alerts/reportSuspicious/";
  Future<String> switchduty() async {
    Response res = await dio.put(swtichDuty,
        options: Options(validateStatus: (status) => true));
    if (res.statusCode == 200) {
      return 'success';
    } else {
      return 'failed';
    }
  }

  updatelocation() async {}

  getAlerts(String vehicle_number) async {
    log("here +" + vehicle_number);
    if (vehicle_number.isEmpty) {
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('access')}";

    Response res =
        await dio.get(getalerts + "?vehicle_number=${vehicle_number}");
    log(res.data.toString());
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      return res.data;
    }
  }

  Future<String> spotted(String numberPlate) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('access')}";
    Response res = await dio.post(spot, data: {"vehicle_number": numberPlate});
    if (res.statusCode == 200) {
      return 'success';
    } else {
      return 'failed';
    }
  }

  Future<String> report(String numberPlate) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('access')}";
    Response res = await dio.post(alert, data: {"vehicle_number": numberPlate});
    log(res.statusCode.toString());
    if (res.statusCode == 201) {
      return 'success';
    } else {
      return 'failed';
    }
  }

  Future<Map<String, dynamic>> chksus(String numberPlate) async {
    final prefs = await SharedPreferences.getInstance();
    dio.options.headers["Authorization"] =
        "Bearer ${prefs.getString('access')}";
    Response res = await dio.post(chkSus, data: {"number": numberPlate});

    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception('Server Error');
    }
  }
}

final prov = Provider<Api>(
  (ref) => Api(),
);
