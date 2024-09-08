import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_images.dart';
import '../../consts/color_const.dart';
import '../custom_button.dart';

class StatusSuccessDialog extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const StatusSuccessDialog({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  State<StatusSuccessDialog> createState() => _StatusSuccessDialogState();
}

class _StatusSuccessDialogState extends State<StatusSuccessDialog> {
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
              SizedBox(height: height * 0.05),
              Image.asset(AppImages.celebrateImage, height: width * .25),

              /// Unsucessfull Access text
              SizedBox(height: height * 0.06),
              Text(
                'Request Successful',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// This operation couldn’t be completed
              SizedBox(height: height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  widget.text,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// Retry button
              SizedBox(height: height * 0.07),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: widget.onTap,
                  btnText: 'OK',
                ),
              ),

              SizedBox(height: height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
