import 'package:dio/dio.dart';

class Api {
  Dio dio = Dio();
  String swtichDuty = 'https://nakacheck.azurewebsites.net/auth/onoffduty/';
  Future<String> switchduty() async {
    Response res = await dio.put(swtichDuty,
        options: Options(validateStatus: (status) => true));
    if (res.statusCode == 200) {
      return 'success';
    } else {
      return 'failed';
    }
  }

  updatelocation() async{
    
  }
}
