import 'dart:convert';
import 'dart:developer';

import 'package:anyline_plugin/anyline_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:permission_handler/permission_handler.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  void scanWithAnyline() async {
    var status = await Permission.camera.status;
    var anylinePlugin = AnylinePlugin();
    var config = await rootBundle.loadString("assets/anylineconfig.json");
    if (status.isGranted) {
      log(status.isGranted.toString());
      var stringResult;
      try {
        stringResult = await anylinePlugin.startScanning(config);
      } catch (e) {
        throw Exception(e);
      }
      Map<String, dynamic> result = jsonDecode(stringResult ?? "");
      log(result['licensePlate'].toString());
    } else {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scanWithAnyline();
        },
      ),
    );
  }
}
