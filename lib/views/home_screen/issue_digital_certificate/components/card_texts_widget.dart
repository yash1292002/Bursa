import 'package:bursa_flutter/consts/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTextsWidget extends StatelessWidget {
  final String? titleText;
  final Color? titleTextColor;
  final String? descText;
  final Color? descTextColor;
  final double? titleTextSize;
  final double? descTextSize;
  final FontWeight? titleFontWeight;
  final FontWeight? descFontWeight;

  const CardTextsWidget({
    Key? key,
    this.titleText = 'Type of grant',
    this.titleTextColor,
    this.descText = 'Shares',
    this.descTextColor,
    this.titleTextSize = 11.0,
    this.descTextSize = 12.0,
    this.titleFontWeight = FontWeight.w500,
    this.descFontWeight = FontWeight.w600,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          titleText!,
          style: GoogleFonts.poppins().copyWith(
            fontSize: titleTextSize,
            color: titleTextColor ?? AppColors.greyColor,
            fontWeight: titleFontWeight,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          descText!,
          style: GoogleFonts.poppins().copyWith(
            letterSpacing: .4,
            fontSize: descTextSize,
            color: descTextColor ?? AppColors.lightBlueColor,
            fontWeight: descFontWeight,
          ),
        ),
      ],
    );
  }
}
