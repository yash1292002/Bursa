import 'package:bursa_flutter/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/color_const.dart';
import '../../../../widgets/custom_button.dart';

class ScanFailedDialog extends StatefulWidget {
  const ScanFailedDialog({Key? key}) : super(key: key);

  @override
  State<ScanFailedDialog> createState() => _ScanFailedDialogState();
}

class _ScanFailedDialogState extends State<ScanFailedDialog> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: (){
                      Get.back();
                    },
                    icon: Image.asset(
                      "assets/icons/closeicon.png",
                      height: width * .04,
                      width: width * .04,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
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
                    // Get.dialog(
                    //   const AllSetDialog(),
                    //   barrierDismissible: false,
                    // );
                  },
                  btnText: 'OK',
                ),
              ),

              /// try scan with face button
              SizedBox(height: height * 0.02),
              /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: () {
                    Get.back();

                    Get.to(SignInScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  btnText: 'Sign In with Email Address or Mobile number',
                  btnColor: AppColors.whiteColor,
                  borderColor: AppColors.greenColor,
                  btnTextColor: AppColors.greenColor,
                  btnTextSize: 12.0,
                ),
              ),

              /// or Text
              SizedBox(height: height * 0.025),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        AppImages.rowDotLine,
                        color: AppColors.lightBlueColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        'Or',
                        style: GoogleFonts.poppins().copyWith(
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Image.asset(
                        AppImages.rowDotLine,
                        color: AppColors.lightBlueColor,
                      ),
                    ),
                  ],
                ),
              ),

              /// signin with email or mobile button
              SizedBox(height: height * 0.016),
              TextButton(
                onPressed: () {

                  Get.back();

                  Get.off(AuthenticationDashBoardScreen(),
                  transition: Transition.rightToLeft,
                  );
                },
                child: Text(
                  'Register Now',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greenColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(height: height * 0.045),*/
            ],
          ),
        ),
      ),
    );
  }
}
