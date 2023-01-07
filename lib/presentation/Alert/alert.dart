import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/presentation/Dashboard/dashboard.dart';
import 'package:nakacheck/services/Api.dart';

class Alert extends StatefulWidget {
  const Alert({Key? key}) : super(key: key);

  @override
  State<Alert> createState() => _AlertState();
}

class _AlertState extends State<Alert> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Scaffold(
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.red300),
                    onPressed: (() {}),
                    child: Container(
                        height: 48,
                        width: 130,
                        child: Center(child: Text('SPOTTED')))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.switchGreen),
                    onPressed: (() {}),
                    child: Container(
                        height: 48,
                        width: 130,
                        child: Center(child: Text('CAUGHT')))),
              )
            ],
          ),
          backgroundColor: ColorConstant.gray900,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: ColorConstant.gray900,
            leadingWidth: 72,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Image.asset(
                "assets/images/assam_logo.png",
              ),
            ),
            title: Text(
              "Jai Hind XYZ",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: ColorConstant.gray100),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Switch(
                        value: switchState,
                        activeTrackColor: ColorConstant.switchGreen,
                        activeColor: Colors.white,
                        inactiveTrackColor: ColorConstant.red300,
                        onChanged: ((value) async {
                          setState(() {
                            switchState = !switchState;
                          });
                          Api api = Api();
                          String result = await api.switchduty();
                          if (result != 'success') {
                            return;
                          }

                          // log("u naughty");
                        })),
                    Text(
                      switchState ? "On-Duty" : "Off-Duty",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 13,
                        color: switchState
                            ? ColorConstant.switchGreen
                            : ColorConstant.red300,
                      ),
                    )
                  ],
                ),
              )
            ],
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UP14 AK 6969',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: ColorConstant.red300),
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Row(
                          children: [
                            Container(
                              color: ColorConstant.red300,
                              height: 206,
                              width: 136,
                            ),
                            Container(
                              width: 195,
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '• Company:  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorConstant.red300),
                                        ),
                                        Text('Maruti',
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '• Model:  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorConstant.red300),
                                        ),
                                        Text('800',
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '• Color:  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorConstant.red300),
                                        ),
                                        Text('Pink',
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '• Reg. Date:  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorConstant.red300),
                                        ),
                                        Text('01/01/1991',
                                            style: TextStyle(fontSize: 14)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '• Registered Under:  ',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: ColorConstant.red300),
                                        ),
                                        Container(
                                          width: 53,
                                          child: Text('Jethalal Upadhyay',
                                              style: TextStyle(fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 250,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Text(
                                    '13:01 - ',
                                    style:
                                        TextStyle(color: ColorConstant.red300),
                                  ),
                                  Text('Vehicle Spotted at IMS'),
                                ],
                              ),
                            );
                          },
                          itemCount: 100,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}