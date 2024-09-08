import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Container(
      width: width * .2,
      height: height * .05,
      padding: EdgeInsets.only(bottom: height * .001),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(width * .08)),
      child: Row(
        children: [
          Image.asset(
            "assets/images/dubai.png",
            height: height * .04,
            // width: width * .8,
          ),
          Container(
            margin: EdgeInsets.only(
              left: width * .02,
            ),
            child: Text(
              '+971',
              style: poppinsRegular.copyWith(
                color: blackColor,
                fontSize: width * .04,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
