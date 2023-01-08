import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nakacheck/core/app_export.dart';
import 'package:nakacheck/core/models/vehicle.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/services/Api.dart';
import 'package:nakacheck/services/provider.dart';
import 'package:toast/toast.dart';

class RedirectionAlert extends ConsumerStatefulWidget {
  RedirectionAlert({Key? key, required this.sus, required this.vehicle})
      : super(key: key);
  bool sus;
  Vehicle vehicle;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RedirectionAlertState();
}

class _RedirectionAlertState extends ConsumerState<RedirectionAlert> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(alertsprov);
    return Scaffold(
      bottomNavigationBar: (!widget.sus)
          ? null
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.red300,
                      ),
                      onPressed: (() async {
                        ToastContext().init(context);
                        Api api = Api();
                        String res =
                            await api.report(widget.vehicle.number ?? "");
                        if (res == 'success') {
                          Toast.show("Alerted",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                          Navigator.pop(context);
                        }
                      }),
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
                      onPressed: (() async {
                        ToastContext().init(context);
                        Api api = Api();
                        String res =
                            await api.spotted(widget.vehicle.number ?? "");
                        if (res == 'success') {
                          Toast.show("Spotted",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                          Navigator.pop(context);
                        }
                      }),
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
                    onChanged: ((value) async {
                      setState(() {
                        App.onduty = !App.onduty;
                      });
                      Api api = Api();
                      String result = await api.switchduty();
                      if (result != 'success') {
                        return;
                      }
                    })),
                Text(
                  App.onduty ? "On-Duty" : "Off-Duty",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      color: App.onduty
                          ? ColorConstant.switchGreen
                          : ColorConstant.red300),
                )
              ],
            ),
          )
        ],
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vehicle.number![0] +
                    widget.vehicle.number![1] +
                    " " +
                    widget.vehicle.number![2] +
                    widget.vehicle.number![3] +
                    " " +
                    widget.vehicle.number![4] +
                    widget.vehicle.number![5] +
                    " " +
                    widget.vehicle.number![6] +
                    widget.vehicle.number![7] +
                    widget.vehicle.number![8] +
                    widget.vehicle.number![9],
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: (widget.sus)
                        ? (widget.sus)
                            ? ColorConstant.red300
                            : ColorConstant.yellow800
                        : ColorConstant.yellow800),
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 32,
                child: Text(
                  widget.sus
                      ? "Suspicious Vehicle attest under Fir : " +
                          widget.vehicle.fir.toString()
                      : "Safe Vehicle",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: widget.sus
                          ? ColorConstant.red300
                          : ColorConstant.yellow800),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Image.network(
                            "https://nakacheck-3.suhailahmad4.repl.co/" +
                                (widget.vehicle.picture ?? "")),
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
                                                : ColorConstant.yellow800
                                            : ColorConstant.yellow800),
                                  ),
                                  Text(widget.vehicle.company ?? "",
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
                                            : ColorConstant.yellow800),
                                  ),
                                  Text(widget.vehicle.model ?? "",
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
                                            : ColorConstant.yellow800),
                                  ),
                                  Text(widget.vehicle.color ?? "",
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
                                            : ColorConstant.yellow800),
                                  ),
                                  Text(widget.vehicle.regDate ?? "",
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
                                            : ColorConstant.yellow800),
                                  ),
                                  Container(
                                    width: 53,
                                    child: Text(widget.vehicle.regUnder ?? "",
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
                  Container(
                    height: 250,
                    child: Container(
                        child: data.when(
                      data: (data) {
                        log(data.toString());

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            String location = data[index]['sender_location']
                                    .toString()
                                    .split(',')[0] +
                                data[index]['sender_location']
                                    .toString()
                                    .split(',')[1];
                            log(location);
                            DateTime timenow =
                                DateTime.parse(data[index]['time']);
                            timenow =
                                timenow.add(Duration(hours: 5, minutes: 30));
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      timenow.hour.toString() +
                                          ":" +
                                          timenow.minute.toString() +
                                          "- ",
                                      style: TextStyle(
                                          color: (widget.sus)
                                              ? ColorConstant.red300
                                              : ColorConstant.yellow800),
                                    ),
                                    Text('Vehicle Spotted at ${location}'),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: data.length,
                        );
                      },
                      error: (error, stackTrace) {},
                      loading: () => Center(
                        child: CircularProgressIndicator(),
                      ),
                    )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
