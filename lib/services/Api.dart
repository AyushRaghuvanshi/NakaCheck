import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio dio = Dio();

  String swtichDuty = 'https://nakacheck.azurewebsites.net/auth/onoffduty/';

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
