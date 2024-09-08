import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_const.dart';

TextStyle poppinsRegular = GoogleFonts.poppins();

TextStyle audioWide = GoogleFonts.audiowide();

var width = Get.width;

class AppStyles {
  static TextStyle registerSharesStatusText =
      poppinsRegular.copyWith(color: white1, fontSize: width * .030);
  static TextStyle companyNameText = poppinsRegular.copyWith(
      color: lightBlueColor,
      fontSize: width * .04,
      fontWeight: FontWeight.w600);

  static TextStyle greySmallHeading =
      poppinsRegular.copyWith(color: greyColor, fontSize: width * .03);

  static TextStyle blueGreySmallHeadingValue = poppinsRegular.copyWith(
    color: lightBlueColor,
    fontWeight: FontWeight.w600,
    fontSize: width * .03,
  );

  static TextStyle greenSmallHeadingValue = poppinsRegular.copyWith(
      color: greenColor, fontSize: width * .03, fontWeight: FontWeight.w600);

  static TextStyle btnTextColor = poppinsRegular.copyWith(
    color: whiteColor,
    fontSize: width * .04,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
  );
  static TextStyle hintTextStyle = poppinsRegular.copyWith(
    color: lightBlueColorWithopacity40,
    fontSize: width * .036,
    fontWeight: FontWeight.w500,
  );
  static TextStyle inputTextStyle = poppinsRegular.copyWith(
    color: blackColor,
    fontSize: width * .036,
    fontWeight: FontWeight.w500,
  );
  static TextStyle bigHintTextStyle = poppinsRegular.copyWith(
    color: lightBlueColorWithopacity40,
    fontSize: width * .04,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bigInputTextStyle = poppinsRegular.copyWith(
    color: blackColor,
    fontSize: width * .04,
    fontWeight: FontWeight.w500,
  );
}
