import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakacheck/core/utils/color_constant.dart';

class AnoALert extends StatefulWidget {
  const AnoALert({Key? key}) : super(key: key);

  @override
  State<AnoALert> createState() => _AnoALertState();
}

class _AnoALertState extends State<AnoALert> {
  bool paused = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Container(
                height: 156,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstant.boxBackBlack,
                    border: Border.all(color: ColorConstant.boxBackBlack),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.83,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/alert_red.svg"),
                                Expanded(
                                  child: Text(
                                    "Anonymous Alert",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: ColorConstant.red300,
                                      fontFamily: "Poppins",
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 32.0,
                                        ),
                                        child: IconButton(
                                            onPressed: (() {
                                              setState(() {
                                                log('tap');
                                                paused = !paused;
                                              });
                                            }),
                                            icon: Icon(
                                              paused
                                                  ? Icons.play_circle_outline
                                                  : Icons.pause_circle_outline,
                                              size: 64,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          );
  }
}
