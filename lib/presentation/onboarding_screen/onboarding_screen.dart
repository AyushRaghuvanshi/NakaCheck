import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/core/utils/image_constant.dart';
import 'package:nakacheck/core/utils/size_utils.dart';
import 'package:nakacheck/presentation/login_page_one_screen/login_page_one_screen.dart';

import 'package:nakacheck/widgets/custom_button.dart';
import 'package:nakacheck/widgets/custom_image_view.dart';

class OnboardingScreen extends StatelessWidget {
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: getPadding(
                    bottom: 201,
                  ),
                  child: Text(
                    "Technology On The Case",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: getFontSize(
                        22,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 1.50,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width,
                  padding: getPadding(
                    left: 32,
                    top: 39,
                    right: 32,
                    bottom: 39,
                  ),
                  decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: fs.Svg(
                      //     ImageConstant.imgSplash,
                      //   ),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: SingleChildScrollView(
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
                          svgPath: ImageConstant.imgObjects,
                          height: getVerticalSize(
                            399.00,
                          ),
                          width: getHorizontalSize(
                            142.00,
                          ),
                          margin: getMargin(
                            top: 43,
                          ),
                        ),
                        CustomButton(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPageOneScreen(),
                                ));
                          }),
                          height: 48,
                          width: 296,
                          text: "Log In",
                          margin: getMargin(
                            top: 85,
                            bottom: 94,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
