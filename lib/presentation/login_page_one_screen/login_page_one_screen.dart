import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nakacheck/core/app_export.dart';
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/core/utils/image_constant.dart';
import 'package:nakacheck/core/utils/size_utils.dart';
import 'package:nakacheck/presentation/Dashboard/dashboard.dart';
import 'package:nakacheck/widgets/custom_image_view.dart';
import 'package:nakacheck/widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageOneScreen extends StatefulWidget {
  @override
  State<LoginPageOneScreen> createState() => _LoginPageOneScreenState();
}

class _LoginPageOneScreenState extends State<LoginPageOneScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool onLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Container(
          height: getVerticalSize(
            774.00,
          ),
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: Padding(
                    padding: getPadding(
                      left: 12,
                      right: 20,
                      bottom: 88,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width,
                          padding: getPadding(
                            left: 44,
                            top: 39,
                            right: 44,
                            bottom: 0,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: getMargin(
                                      top: 1,
                                    ),
                                    decoration: BoxDecoration(),
                                    child: Text(
                                      "Naka Check",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: ColorConstant.yellow800,
                                        fontSize: getFontSize(
                                          16,
                                        ),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.15,
                                        height: 1.50,
                                      ),
                                    ),
                                  ),
                                  CustomImageView(
                                    svgPath: ImageConstant.imgEye,
                                    height: getSize(
                                      24.00,
                                    ),
                                    width: getSize(
                                      24.00,
                                    ),
                                    margin: getMargin(
                                      bottom: 1,
                                    ),
                                  ),
                                ],
                              ),
                              CustomImageView(
                                svgPath: ImageConstant
                                    .imgIconsaxboldshieldsearchYellow800,
                                height: getSize(
                                  266.00,
                                ),
                                width: getSize(
                                  266.00,
                                ),
                                margin: getMargin(
                                  top: 74,
                                  bottom: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        EmailTextArea(
                            controller: _email,
                            labelText: 'Unique Id',
                            hintText: 'Enter ID'),
                        Padding(
                          padding: getPadding(top: 32),
                          child: EmailTextArea(
                              controller: _password,
                              labelText: 'Password',
                              hintText: 'Must be 6 characters long'),
                        ),
                        onLoading == false
                            ? GestureDetector(
                                onTap: (() async {
                                  if (_email.text.isEmpty ||
                                      _password.text.length < 6) {
                                    return;
                                  }
                                  Dio dio = Dio();
                                  log("signing in");
                                  setState(() {
                                    onLoading = true;
                                  });
                                  Response res = await dio.post(
                                      'https://nakacheck-3.suhailahmad4.repl.co/auth/login/',
                                      data: {
                                        "userID": _email.text,
                                        "password": _password.text
                                      },
                                      options: Options(
                                        validateStatus: (status) => true,
                                      ));

                                  if (res.statusCode == 201) {
                                    log("successful sigin $res");
                                    // if (true) {
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString("access",
                                        jsonDecode(res.toString())['access']);
                                    prefs.setString("name",
                                        jsonDecode(res.toString())['name']);
                                    App.name =
                                        jsonDecode(res.toString())['name'];
                                    await App.dutyCheck();

                                    prefs.setBool("duty",
                                        jsonDecode(res.toString())['onDuty']);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DashBoard(),
                                      ),
                                    );
                                  } else {
                                    log("failed $res");
                                  }

                                  setState(() {
                                    onLoading = true;
                                  });

                                  //Demo
                                }),
                                child: Container(
                                  width: getHorizontalSize(
                                    328.00,
                                  ),
                                  margin: getMargin(
                                    top: 13,
                                  ),
                                  padding: getPadding(
                                    left: 139,
                                    top: 9,
                                    right: 139,
                                    bottom: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.yellow800,
                                    borderRadius: BorderRadius.circular(
                                      getHorizontalSize(
                                        8.00,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: getPadding(
                                          top: 5,
                                        ),
                                        child: Text(
                                          "Log In",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: ColorConstant.whiteA700,
                                            fontSize: getFontSize(
                                              16,
                                            ),
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.15,
                                            height: 1.50,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                child: Padding(
                                  padding: getPadding(
                                      left: 12, right: 20, bottom: 88, top: 5),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                        color: ColorConstant.yellow800),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
