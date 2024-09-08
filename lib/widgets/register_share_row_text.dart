import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/textstyle_const.dart';

var height = Get.height;
var width = Get.width;

class RegisterShareRowText extends StatelessWidget {
  final String heading_1;
  final String value_1;
  final String heading_2;
  final String value_2;
  final bool isGreen;
  final double marginLeft;
  final double? marginTop;

  const RegisterShareRowText(
      {Key? key,
      required this.heading_1,
      required this.value_1,
      required this.heading_2,
      required this.value_2,
      this.isGreen = false,
      this.marginLeft = 0,
      this.marginTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTop ?? height * .01, left: marginLeft),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:
                        EdgeInsets.only(left: width * .04, top: height * .0),
                    child: Text(
                      heading_1,
                      style: AppStyles.greySmallHeading,
                    )),
                Container(
                    margin: EdgeInsets.only(left: width * .04),
                    child: Text(value_1,
                        style: AppStyles.blueGreySmallHeadingValue)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:
                        EdgeInsets.only(left: width * .08, top: height * .0),
                    child: Text(
                      heading_2,
                      style: AppStyles.greySmallHeading,
                    )),
                Container(
                    margin: EdgeInsets.only(left: width * .08),
                    child: Text(value_2,
                        style: isGreen
                            ? AppStyles.greenSmallHeadingValue
                            : AppStyles.blueGreySmallHeadingValue)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
