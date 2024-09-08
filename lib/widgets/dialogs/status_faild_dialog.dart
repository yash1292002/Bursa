import 'package:bursa_flutter/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/color_const.dart';
import '../../../../widgets/custom_button.dart';

class StatusFailedDialog extends StatefulWidget {
  final String text;
  const StatusFailedDialog({Key? key, required this.text}) : super(key: key);

  @override
  State<StatusFailedDialog> createState() => _StatusFailedDialogState();
}

class _StatusFailedDialogState extends State<StatusFailedDialog> {
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
                'Request Failed',
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
                  onTap: () {
                    Get.back();
                  },
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
