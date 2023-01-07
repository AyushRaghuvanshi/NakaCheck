import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio dio = Dio();

  String swtichDuty =
      'https://nakacheck-3.suhailahmad4.repl.co/auth/onoffduty/';
  String chkSus =
      "https://nakacheck-3.suhailahmad4.repl.co/alerts/checkSuspicious/";
  Future<String> switchduty() async {
    Response res = await dio.put(swtichDuty,
        options: Options(validateStatus: (status) => true));
    if (res.statusCode == 200) {
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
