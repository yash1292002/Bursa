import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/app_images.dart';
import '../../../../../consts/color_const.dart';
import '../../../../../widgets/custom_button.dart';
import 't_auth_dialog.dart';

class TBottomSheet extends StatefulWidget {
  const TBottomSheet({Key? key}) : super(key: key);

  @override
  State<TBottomSheet> createState() => _TBottomSheetState();
}

class _TBottomSheetState extends State<TBottomSheet> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16.0),
        Container(
          height: 2.0,
          width: 90.0,
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.3),
          ),
        ),

        /// close button
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppImages.closeIcon),
          ),
        ),

        /// login text ID text
        Text(
          'Login with Touch ID',
          style: GoogleFonts.poppins().copyWith(
            color: AppColors.greenColor,
            fontSize: width * .058,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16.0),

        /// touch sensor
        SvgPicture.asset(
          AppImages.touchScanIcon,
          height: height * 0.17,
          width: height * 0.11,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 16.0),

        /// touch sensor description
        Text(
          'Authenticate using '
          '\nTouch ID instead of entering your password',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins().copyWith(
            color: AppColors.greyColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),

        /// use touch ID buton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          child: CustomButton(
            onTap: () {
              Get.dialog(
                const TAuthDialog(),
                barrierDismissible: false,
              ).then((value) {
                Get.back(result: value);
              });
            },
            btnText: 'Use Touch ID',
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
