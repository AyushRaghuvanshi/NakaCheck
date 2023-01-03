import 'dart:convert';
import 'dart:developer';

import 'package:anyline_plugin/anyline_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakacheck/presentation/Dashboard/search.dart';
import 'package:nakacheck/widgets/custom_text_form_field.dart';
import 'package:permission_handler/permission_handler.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late TextEditingController _numberplate;



  @override
  void initState() {
    // TODO: implement initState
    _numberplate = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _numberplate.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmailTextArea(
        controller: _numberplate,
        labelText: 'Number Plate',
        hintText: 'DL 64C 1222',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // scanWithAnyline();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Search(),
              ));
        },
      ),
    );
  }
}
