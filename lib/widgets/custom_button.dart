import 'package:bursa_flutter/consts/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String? btnText;
  final double? btnTextSize;
  final Color? btnColor;
  final Color? btnTextColor;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final Color? borderColor;
  final double? btnWidth;
  final double? btnHeight;
  final double? borderRadius;
  final bool enabled;

  const CustomButton({
    Key? key,
    required this.onTap,
    this.btnTextSize = 16.0,
    this.btnText = 'Button Text',
    this.btnTextColor = AppColors.white1,
    this.margin,
    this.btnColor = AppColors.greenColor,
    this.borderColor = AppColors.greenColor,
    this.btnWidth,
    this.btnHeight,
    this.borderRadius = 6.0,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(horizontal: 0.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? btnColor : AppColors.greenColor,
          elevation: 0.0,
          
          shadowColor: btnColor,
          // side: BorderSide(
          //   color: enabled ? btnColor! : AppColors.greenColor,
          //   width: 1.0,
          // ),
          minimumSize: Size(
              btnWidth ?? MediaQuery.of(context).size.width, btnHeight ?? 45.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius!)),
        ),
        child: Center(
          child: Text(
            btnText!,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: btnTextColor,
              fontSize: btnTextSize,
            ),
          ),
        ),
      ),
    );
  }
}
