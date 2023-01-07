import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nakacheck/core/models/vehicle.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/presentation/Dashboard/dashboard.dart';
import 'package:nakacheck/services/Api.dart';

class RedirectionAlert extends StatefulWidget {
  RedirectionAlert({Key? key, required this.sus, required this.vehicle})
      : super(key: key);
  bool sus;
  Vehicle vehicle;
  @override
  State<RedirectionAlert> createState() => _RedirectionAlertState();
}

class _RedirectionAlertState extends State<RedirectionAlert> {
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
                        backgroundColor: (widget.sus)
                            ? ColorConstant.red300
                            : ColorConstant.switchGreen),
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
                        inactiveTrackColor: (widget.sus)
                            ? ColorConstant.red300
                            : ColorConstant.switchGreen,
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
                            : (widget.sus)
                                ? ColorConstant.red300
                                : ColorConstant.switchGreen,
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
                    widget.vehicle.number ?? "",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: (widget.sus)
                            ? (widget.sus)
                                ? ColorConstant.red300
                                : ColorConstant.switchGreen
                            : ColorConstant.switchGreen),
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
                              color: (widget.sus)
                                  ? (widget.sus)
                                      ? ColorConstant.red300
                                      : ColorConstant.switchGreen
                                  : ColorConstant.switchGreen,
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
                                              color: (widget.sus)
                                                  ? (widget.sus)
                                                      ? ColorConstant.red300
                                                      : ColorConstant
                                                          .switchGreen
                                                  : ColorConstant.switchGreen),
                                        ),
                                        Text(widget.vehicle.company??"",
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
                                              color: (widget.sus)
                                                  ? ColorConstant.red300
                                                  : ColorConstant.switchGreen),
                                        ),
                                        Text('remove',
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
                                              color: (widget.sus)
                                                  ? ColorConstant.red300
                                                  : ColorConstant.switchGreen),
                                        ),
                                        Text(widget.vehicle.color??"",
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
                                              color: (widget.sus)
                                                  ? ColorConstant.red300
                                                  : ColorConstant.switchGreen),
                                        ),
                                        Text(widget.vehicle.regDate??"",
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
                                              color: (widget.sus)
                                                  ? ColorConstant.red300
                                                  : ColorConstant.switchGreen),
                                        ),
                                        Container(
                                          width: 53,
                                          child: Text(widget.vehicle.regUnder??"",
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
                                    style: TextStyle(
                                        color: (widget.sus)
                                            ? ColorConstant.red300
                                            : ColorConstant.switchGreen),
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
