import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import 'custom_cached__neywork_image.dart';

class RegisterShareCircularImage extends StatelessWidget {
  final String businessLogo;

  const RegisterShareCircularImage({Key? key, required this.businessLogo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return Container(
      margin: EdgeInsets.only(
          left: width * .03, bottom: height * .13, right: width * .0),
      height: height * .04,
      width: width * .085,
      decoration: BoxDecoration(
          color: white1, borderRadius: BorderRadius.circular(width * .0)),
      child: ClipRRect(
        child: FittedBox(
            fit: BoxFit.cover,
            child: CustomCachedNetworkImage(
              imageUrl: businessLogo,
            )),
      ),
    );
  }
}
