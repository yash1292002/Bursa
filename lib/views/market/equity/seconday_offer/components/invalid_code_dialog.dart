import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/color_const.dart';

class InvalidCodeDialog extends StatefulWidget {
  const InvalidCodeDialog({Key? key}) : super(key: key);

  @override
  State<InvalidCodeDialog> createState() => _InvalidCodeDialogState();
}

class _InvalidCodeDialogState extends State<InvalidCodeDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.032),
              SvgPicture.asset(AppImages.failedIcon),

              /// Invalid Code text
              SizedBox(height: height * 0.016),
              Text(
                'Invalid Code',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// The code is invalid or expired text
              SizedBox(height: height * 0.013),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'The code you have entered is invalid or expired',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /* /// description text
              SizedBox(height: height * 0.062),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'loremiosd ipdo olore sit amet loremiosd ipdo olore sit amet loremiosd '
                      'ipdo olore sit amet loremiosd ipdo olore sit amet loremiosd '
                      'ipdo olore sit amet ',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),*/

              /// ok button
              SizedBox(height: height * 0.062),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  btnText: 'OK',
                ),
              ),

              SizedBox(height: height * 0.056),
            ],
          ),
        ),
      ),
    );
  }
}
