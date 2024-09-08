import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/color_const.dart';

class PaymentFailedDialog extends StatefulWidget {
  const PaymentFailedDialog({Key? key, required this.message})
      : super(key: key);
  final String message;

  @override
  State<PaymentFailedDialog> createState() => _PaymentFailedDialogState();
}

class _PaymentFailedDialogState extends State<PaymentFailedDialog> {
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

              /// payment failed text
              SizedBox(height: height * 0.016),
              Text(
                'Payment Failed',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// The operation couldn’t be completed text
              SizedBox(height: height * 0.013),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'The operation couldn’t be completed',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// description text
              SizedBox(height: height * 0.062),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  widget.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

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
