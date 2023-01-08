import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nakacheck/core/app_export.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/services/Api.dart';
import 'package:nakacheck/services/provider.dart';
import 'package:toast/toast.dart';

class Alert extends ConsumerStatefulWidget {
  String numberplate;
  Alert({Key? key, required this.numberplate}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AlertState();
}

class _AlertState extends ConsumerState<Alert> {
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(alertsprov);
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.red300),
                onPressed: (() async {
                  ToastContext().init(context);
                  Api api = Api();
                  String res = await api.report(widget.numberplate);
                  if (res == 'success') {
                    Toast.show("Alerted",
                        duration: Toast.lengthLong, gravity: Toast.bottom);
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
                  String res = await api.spotted(widget.numberplate);
                  if (res == 'success') {
                    Toast.show("Alerted",
                        duration: Toast.lengthLong, gravity: Toast.bottom);
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
        elevation: 0,
      ),
      body: FutureBuilder(
          future: api.chksus(widget.numberplate),
          builder: (context, snapshot) {
            log(snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.done) {
              final snap = snapshot.data as Map;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${snap['data']['number'][0]}${snap['data']['number'][1]} ${snap['data']['number'][2]}${snap['data']['number'][3]} ${snap['data']['number'][4]}${snap['data']['number'][5]} ${snap['data']['number'][6]}${snap['data']['number'][7]}${snap['data']['number'][8]}${snap['data']['number'][9]}",
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
                                  height: 206,
                                  width: 136,
                                  child: Image.network(
                                    "https://nakacheck-3.suhailahmad4.repl.co" +
                                        snap['data']['picture'],
                                  ),
                                ),
                                Container(
                                  width: 195,
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '• Company:  ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: ColorConstant.red300),
                                            ),
                                            Text(snap['data']['company'],
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
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
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '• Color:  ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: ColorConstant.red300),
                                            ),
                                            Text(snap['data']['color'],
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '• Reg. Date:  ',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: ColorConstant.red300),
                                            ),
                                            Text(
                                                snap['data']
                                                    ['registrationDate'],
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
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
                                              child: Text(
                                                  snap['data']
                                                      ['registeredUnder'],
                                                  style:
                                                      TextStyle(fontSize: 14)),
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
                            child: Container(
                                child: data.when(
                              data: (data) {
                                log(data.toString());

                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    int timecolon = data[index]['time']
                                        .toString()
                                        .indexOf(':');
                                    String time = data[index]['time']
                                            .toString()
                                            .substring(
                                                timecolon - 2, timecolon) +
                                        data[index]['time']
                                            .toString()
                                            .substring(
                                                timecolon, timecolon + 3);
                                    String location = data[index]
                                                ['sender_location']
                                            .toString()
                                            .split(',')[0] +
                                        data[index]['sender_location']
                                            .toString()
                                            .split(',')[1];
                                    log(location);
                                    return Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${time} - ',
                                              style: TextStyle(
                                                  color: (snap['Suspicious'] ==
                                                          "True")
                                                      ? ColorConstant.red300
                                                      : ColorConstant
                                                          .yellow800),
                                            ),
                                            Text(
                                                'Vehicle Spotted at ${location}'),
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
              );
            } else {
              return Center(
                child:
                    CircularProgressIndicator(color: ColorConstant.yellow800),
              );
            }
          }),
    );
  }
}
