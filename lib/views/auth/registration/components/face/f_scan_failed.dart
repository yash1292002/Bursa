import 'package:bursa_flutter/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../widgets/custom_button.dart';
import 'f_all_set_dialog.dart';


class FScanFailed extends StatefulWidget {
  const FScanFailed({Key? key}) : super(key: key);

  @override
  State<FScanFailed> createState() => _FScanFailedState();
}

class _FScanFailedState extends State<FScanFailed> {
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
              SizedBox(height: height * 0.06),
              SvgPicture.asset(AppImages.failedIcon),

              /// Unsucessfull Access text
              SizedBox(height: height * 0.06),
              Text(
                'Login Failed',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// This operation couldn’t be completed
              SizedBox(height: height * 0.015),
              Text(
                'This operation couldn’t be completed',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.greyColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),

              /// Retry button
              SizedBox(height: height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: () {
                    Get.back();
                    Get.dialog(
                      const FAllSetDialog(),
                      barrierDismissible: false,
                    );
                  },
                  btnText: 'OK',
                ),
              ),

              SizedBox(height: height * 0.045),
            ],
          ),
        ),
      ),
    );
  }
}
