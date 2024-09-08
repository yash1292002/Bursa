import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class GrantTypeGridItemBuilder extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSelected;
  final String text;

  const GrantTypeGridItemBuilder(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            // color: darkBlueColor,
            color: isSelected ? darkblue1 : whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(width * .02),
            ),
            border: !isSelected
                ? Border.all(
                    color: blackColorWithOpacity50,
                    width: width * .001,
                  )
                : null),
        alignment: Alignment.center,
        child: Text(
          text,
          style: poppinsRegular.copyWith(
            fontSize: width * .033,
            color: isSelected ? whiteColor : lightGrey,
          ),
        ),
      ),
    );
  }
}
