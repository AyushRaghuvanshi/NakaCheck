import 'dart:convert';
import 'dart:developer';
import 'package:anyline_plugin/anyline_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nakacheck/core/models/vehicle.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/core/utils/size_utils.dart';
import 'package:nakacheck/presentation/Alert/redirection.dart';
import 'package:nakacheck/services/Api.dart';
import 'package:nakacheck/services/provider.dart';
import 'package:nakacheck/widgets/search_textform.dart';
import 'package:permission_handler/permission_handler.dart';

class Search extends ConsumerWidget {
  TextEditingController _plate = TextEditingController();
  void scanWithAnyline(dynamic context, dynamic ref) async {
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
      _plate.text = result['licensePlate'];
      Api api = Api();
      String plate = _plate.text;
      plate = plate.replaceAll(' ', '');
      log(plate);
      dynamic res = await api.chksus(plate);
      Vehicle vehicle = Vehicle(
          res['data']['company'],
          res['data']['number'],
          res['data']['color'],
          res['data']['registrationDate'],
          res['data']['registrationUnder'],
          res['data']['picture'],
          res['data']['model']);
      ref.watch(numberPlate.notifier).state = vehicle.number;
      if (res['Suspicious'] == 'True') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RedirectionAlert(sus: true, vehicle: vehicle),
            ));
        log('sus');
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RedirectionAlert(sus: false, vehicle: vehicle),
            ));
        log('all ok');
      }
    } else {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: ColorConstant.gray900,
          ),
          child: Container(
            width: size.width,
            padding: getPadding(
              left: 16,
              top: 25,
              right: 16,
              bottom: 25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    icon: Icon(Icons.arrow_back)),

                Container(
                  width: getHorizontalSize(
                    188.00,
                  ),
                  margin: getMargin(
                    top: 56,
                  ),
                  child: Text(
                    "Enter the vehicle\nnumber",
                    maxLines: null,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: getFontSize(
                        22,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.27,
                    ),
                  ),
                ),

                CustomTextFormField(
                  width: 328,
                  controller: _plate,
                  hintText: "DL 1CA 8010",
                  margin: getMargin(
                    top: 37,
                  ),
                  fontStyle: TextFormFieldFontStyle.PoppinsRegular14WhiteA700,
                  suffix: GestureDetector(
                    onTap: (() async {
                      if (_plate.text.isEmpty) {
                        return;
                      }
                      log(_plate.text);
                      Api api = Api();
                      String plate = _plate.text;
                      plate = plate.replaceAll(' ', '');
                      log(plate);
                      dynamic res = await api.chksus(plate);
                      log(res['data'].toString());
                      Vehicle vehicle = Vehicle(
                          res['data']['company'],
                          res['data']['number'],
                          res['data']['color'],
                          res['data']['registrationDate'],
                          res['data']['registeredUnder'],
                          res['data']['picture'],
                          res['data']['model']);
                      ref.watch(numberPlate.notifier).state =
                          vehicle.number ?? "";
                      if (res['Suspicious'] == 'True') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RedirectionAlert(sus: true, vehicle: vehicle),
                            ));
                        log('sus');
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RedirectionAlert(
                                  sus: false, vehicle: vehicle),
                            ));
                        log('all ok');
                      }
                    }),
                    child: Container(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      padding: getPadding(
                        left: 14,
                        top: 12,
                        right: 10,
                        bottom: 12,
                      ),
                      margin: getMargin(
                        top: 7,
                        right: 7,
                        bottom: 7,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstant.yellow800,
                        borderRadius: BorderRadius.circular(
                          getHorizontalSize(
                            6.00,
                          ),
                        ),
                      ),
                    ),
                  ),
                  suffixConstraints: BoxConstraints(
                    minWidth: getHorizontalSize(
                      18.00,
                    ),
                    minHeight: getVerticalSize(
                      18.00,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: getPadding(
                      top: 21,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 2,
                          width: 96,
                          margin: getMargin(
                            top: 9,
                            bottom: 11,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: getPadding(
                            left: 8,
                          ),
                          child: Text(
                            "or",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // color: ColorConstant.whiteA700B2,
                              fontSize: getFontSize(
                                15,
                              ),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          height: getVerticalSize(
                            2.00,
                          ),
                          width: getHorizontalSize(
                            97.00,
                          ),
                          margin: getMargin(
                            left: 8,
                            top: 9,
                            bottom: 11,
                          ),
                          decoration: BoxDecoration(
                            // color: ColorConstant.whiteA700B2,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              getHorizontalSize(
                                1.00,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Container(
                      margin: getMargin(
                        top: 23,
                        bottom: 5,
                      ),
                      width: 164,
                      height: 48,
                      child: ElevatedButton(
                          onPressed: (() {
                            scanWithAnyline(context, ref);
                          }),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFF89E31),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          child: Row(
                            children: [
                              Container(
                                // padding: const EdgeInsets.all(8.0),
                                margin: getMargin(
                                  // left: 23,
                                  top: 13,
                                  right: 29,
                                  bottom: 13,
                                ),
                                child: Icon(Icons.camera_alt_outlined),
                              ),
                              Text(
                                'Scan',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins'),
                              )
                            ],
                          )),
                    ),
                  ),
                )
                // CustomTextFormField(
                //   width: 164,
                //   focusNode: FocusNode(),
                //   hintText: "Scan",
                //   margin: getMargin(
                //     top: 23,
                //     bottom: 5,
                //   ),
                //   // variant: TextFormFieldVariant.FillYellow800,
                //   // padding: TextFormFieldPadding.PaddingT9,
                //   // fontStyle: TextFormFieldFontStyle.PoppinsBold18,
                //   textInputAction: TextInputAction.done,
                //   alignment: Alignment.center,
                //   prefix: Container(
                //     margin: getMargin(
                //       left: 23,
                //       top: 13,
                //       right: 29,
                //       bottom: 13,
                //     ),
                //     child: CustomImageView(
                //       // svgPath: ImageConstant.imgCamera,
                //     ),
                //   ),
                //   prefixConstraints: BoxConstraints(
                //     minWidth: getSize(
                //       22.00,
                //     ),
                //     minHeight: getSize(
                //       22.00,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
