import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nakacheck/core/app_export.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/presentation/Alert/alert.dart';
import 'package:nakacheck/presentation/Dashboard/anonymousAlert.dart';
import 'package:nakacheck/presentation/Dashboard/search.dart';
import 'package:nakacheck/presentation/login_page_one_screen/login_page_one_screen.dart';
import 'package:nakacheck/services/Api.dart';
import 'package:nakacheck/services/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/utils/size_utils.dart';

class DashBoard extends ConsumerStatefulWidget {
  const DashBoard();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<DashBoard> {
  late TextEditingController _numberplate;
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    _numberplate = TextEditingController();
    App.sendLatLong();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _numberplate.dispose();
  }

  RefreshController _refreshController = RefreshController();
  @override
  Widget build(BuildContext context) {
    AsyncValue<dynamic> alerts = ref.watch(App.alertGetProvider);

    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: Stack(children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "\"A Soldier Is Never Out Of Duty\"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 35,
                      color: ColorConstant.yellow800),
                ),
                ElevatedButton(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      if (prefs.getBool("duty")!) {
                        Api api = Api();
                        api.switchduty();
                        prefs.clear();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPageOneScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Log Out",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            )),
          ]),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 70,
        backgroundColor: ColorConstant.gray900,
        leadingWidth: 72,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset(
                  "assets/images/assam_logo.png",
                ),
              );
            },
          ),
        ),
        title: Text(
          "${App.name}",
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
                    value: App.onduty,
                    activeTrackColor: ColorConstant.switchGreen,
                    activeColor: Colors.white,
                    inactiveTrackColor: ColorConstant.red300,
                    onChanged: ((value) {
                      Api api = Api();
                      api.switchduty();

                      setState(() {
                        App.onduty = !App.onduty;
                      });
                    })),
                Text(
                  App.onduty ? "On-Duty" : "Off-Duty",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 13,
                    color: App.onduty
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: (MediaQuery.of(context).size.width / 2) - 20,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: (() {
                            setState(() {
                              index = 0;
                            });
                          }),
                          child: Center(
                            child: Text(
                              "Recent\n Alerts",
                              maxLines: null,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.whiteA700,
                                fontSize: getFontSize(
                                  20,
                                ),
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 2,
                        width: 50,
                        color: (index == 0)
                            ? ColorConstant.yellow800
                            : Colors.transparent,
                      )
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: 64,
                  color: Colors.grey,
                ),
                Container(
                  width: (MediaQuery.of(context).size.width / 2) - 20,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                index = 1;
                              });
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Center(
                                child: Text(
                                  "Anonymous\n Alerts",
                                  maxLines: null,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      20,
                                    ),
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 2,
                          width: 50,
                          color: (index == 1)
                              ? ColorConstant.yellow800
                              : Colors.transparent,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Container(
                child: (index == 0)
                    ? Expanded(
                        child: alerts.when(
                          data: (data) => SmartRefresher(
                            enablePullDown: true,
                            controller: _refreshController,
                            onRefresh: () async {
                              ref.refresh(App.alertGetProvider);
                              await Future.delayed(Duration(seconds: 1));
                              _refreshController.refreshCompleted();
                            },
                            child: ListView.builder(
                              itemCount: alerts.value.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    ref.watch(numberPlate.notifier).state =
                                        alerts.value[index]["vehicle_number"];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Alert(
                                                numberplate: alerts.value[index]
                                                    ["vehicle_number"],
                                              )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Container(
                                        height: 156,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: ColorConstant.boxBackBlack,
                                            border: Border.all(
                                                color:
                                                    ColorConstant.boxBackBlack),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.83,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(alerts
                                                                            .value[
                                                                        index][
                                                                    "alert_type"] ==
                                                                "High Alert"
                                                            ? "assets/images/alert_red.svg"
                                                            : "assets/images/alert_yellow.svg"),
                                                        Expanded(
                                                          child: Text(
                                                            "${alerts.value[index]["vehicle_number"][0]}${alerts.value[index]["vehicle_number"][1]} ${alerts.value[index]["vehicle_number"][2]}${alerts.value[index]["vehicle_number"][3]} ${alerts.value[index]["vehicle_number"][4]}${alerts.value[index]["vehicle_number"][5]} ${alerts.value[index]["vehicle_number"][6]}${alerts.value[index]["vehicle_number"][7]}${alerts.value[index]["vehicle_number"][8]}${alerts.value[index]["vehicle_number"][9]}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              fontSize: 28,
                                                              color: alerts.value[
                                                                              index]
                                                                          [
                                                                          "alert_type"] ==
                                                                      "High Alert"
                                                                  ? ColorConstant
                                                                      .red300
                                                                  : ColorConstant
                                                                      .yellow800,
                                                              fontFamily:
                                                                  "Poppins",
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "The Vehicle Was Spotted At ${alerts.value[index]["sender_location"].split(",")[0]} , ${alerts.value[index]["sender_location"].split(",")[1]}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
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
                                              color:
                                                  ColorConstant.boxArrowColor,
                                            )
                                          ],
                                        )),
                                  ),
                                );
                              },
                            ),
                          ),
                          loading: () => Center(
                            child: CircularProgressIndicator(),
                          ),
                          error: (error, stackTrace) => Center(
                            child: Text("Error"),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return AnoALert();
                          },
                        ),
                      ))
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
