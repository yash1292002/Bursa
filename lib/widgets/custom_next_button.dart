import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class CustomNextButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? btnColor;
  final double marginTop;
  final double marginBottom;

  const CustomNextButton(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.btnColor,
      required this.marginTop,
      required this.marginBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: width * .12,
        width: width * .75,
        margin: EdgeInsets.only(top: marginTop, bottom: marginBottom),
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.all(Radius.circular(width * .02)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Next",
              style: AppStyles.btnTextColor,
            ),
            Padding(
              padding: EdgeInsets.only(left: width * .02),
              child: Icon(
                Icons.arrow_right_alt,
                color: whiteColor,
                size: width * .08,
              ),
            )
          ],
        ),
      ),
    );
  }
}
