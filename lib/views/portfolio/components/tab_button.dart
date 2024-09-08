import 'package:flutter/material.dart';

import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';

class CustomTabButton extends StatelessWidget {
  final Function()? onTap;
  final Color? btnColor;
  final Color? btnTextColor;
  final String? btnText;

  const CustomTabButton({Key? key,
    required this.onTap,
    this.btnColor = AppColors.lightBlueColor,
    this.btnText = 'Last weak',
    this.btnTextColor = AppColors.whiteColor,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Ink(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 32.0),
            decoration: BoxDecoration(
              color: btnColor,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: AppColors.lightBlueColor,
                width: 1.0,
              ),
            ),
            child: Text(btnText!,
              style: poppinsRegular.copyWith(
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
                color: btnTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
