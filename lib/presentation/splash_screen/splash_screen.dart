import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:nakacheck/core/utils/color_constant.dart';
import 'package:nakacheck/core/utils/image_constant.dart';
import 'package:nakacheck/core/utils/size_utils.dart';
import 'package:nakacheck/widgets/custom_image_view.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray900,
        body: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: ColorConstant.gray900,
            // image: DecorationImage(
            //   image: fs.Svg(
            //     ImageConstant.imgSplash,
            //   ),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Container(
            width: size.width,
            padding: getPadding(
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  svgPath: ImageConstant.imgIconsaxboldshieldsearch,
                  height: getSize(
                    327.00,
                  ),
                  width: getSize(
                    327.00,
                  ),
                  margin: getMargin(
                    top: 16,
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 21,
                  ),
                  child: Text(
                    "Naka Check",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: ColorConstant.whiteA700,
                      fontSize: getFontSize(
                        40,
                      ),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
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
