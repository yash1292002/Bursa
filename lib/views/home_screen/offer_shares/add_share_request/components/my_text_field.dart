import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../../../consts/color_const.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? prefixText;
  final String? suffixText;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const MyTextField(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.hintText = '',
      this.prefixText = '',
      this.suffixText = 'suffix text',
      this.onChanged,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        inputFormatters: [
          ThousandsFormatter(),
        ],
        // enabled: false,
        style: GoogleFonts.poppins().copyWith(
          color: AppColors.lightBlueColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          prefixText: prefixText,
          prefixStyle: GoogleFonts.poppins().copyWith(
            color: AppColors.lightBlueColor,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              suffixText!,
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.greyColor,
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins().copyWith(
            color: greyColor2,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class MyTextField1 extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? hintText;
  final String? suffixText;
  final Function(String)? onChanged;
  final FocusNode? focusNode;

  const MyTextField1(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.hintText = 'hint text',
      this.suffixText = 'suffix text',
      this.onChanged,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.0,
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        enabled: false,
        inputFormatters: [
          ThousandsFormatter(),
        ],
        style: GoogleFonts.poppins().copyWith(
          color: AppColors.lightBlueColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(
              suffixText!,
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.greyColor,
                fontSize: 10.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins().copyWith(
            color: greyColor2,
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
