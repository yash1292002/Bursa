import 'package:bursa_flutter/consts/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_images.dart';
import '../../../consts/textstyle_const.dart';

class TabButton extends StatelessWidget {
  final Function()? onTap;
  final String? tabText;
  final Color? tabDataColor;
  final Color? tabBackColor;

  const TabButton({Key? key,
    required this.onTap,
    this.tabText = 'Equity',
    this.tabDataColor = AppColors.whiteColor,
    this.tabBackColor = Colors.transparent,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.0),
        child: Ink(
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: tabBackColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const SizedBox(),
              Text(tabText!,
                style: poppinsRegular.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: tabDataColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: SvgPicture.asset(AppImages.upDownArrowIcon, color: tabDataColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
