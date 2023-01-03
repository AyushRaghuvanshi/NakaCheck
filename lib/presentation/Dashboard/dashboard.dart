import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/presentation/Dashboard/search.dart';
import '../../core/utils/size_utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  late TextEditingController _numberplate;
  bool switchState = false;
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
                    onChanged: ((value) {
                      setState(() {
                        switchState = !switchState;
                      });

                      log("u naughty");
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
      ),
      //
      //
      //
      //
      //
      //
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Alerts",
                maxLines: null,
                style: TextStyle(
                  color: ColorConstant.whiteA700,
                  fontSize: getFontSize(
                    34,
                  ),
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      log("clicked at $index");
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                          height: 156,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorConstant.boxBackBlack,
                              border:
                                  Border.all(color: ColorConstant.boxBackBlack),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
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
                                          SvgPicture.asset(
                                              "assets/images/alert.svg"),
                                          Expanded(
                                            child: Text(
                                              "UP 14 AK $index",
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
                                            child: Text(
                                              "The Vehicle Was Spotted At Dasna",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ColorConstant.boxArrowColor,
                              )
                            ],
                          )),
                    ),
                  );
                },
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
      //
      //
      //
      //
      //
      //
      //
      //
      //
      //

      backgroundColor: ColorConstant.gray900,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.yellow800,
        child: Icon(
          Icons.search_outlined,
          color: ColorConstant.whiteA700,
        ),
        onPressed: () {
          // scanWithAnyline();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Search(),
            ),
          );
        },
      ),
    );
  }
}
