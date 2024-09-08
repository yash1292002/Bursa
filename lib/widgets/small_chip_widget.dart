import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/color_const.dart';

class SmallChip extends StatelessWidget {
  final Color? chipColor;
  final String? chipText;
  final Function()? onTap;
  final double? chipTextSize;

  const SmallChip({Key? key,
    required this.onTap,
    this.chipColor,
    this.chipText = 'Approved',
    this.chipTextSize,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30.0),
        child: Ink(
          
          padding: const EdgeInsets.only(left: 5.0, right: 5.0,top: 5,bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: chipColor ?? greenColor,
          ),
          child: Text(chipText!,
            style: GoogleFonts.poppins().copyWith(
              color: white1,
              fontSize: chipTextSize ?? MediaQuery.of(context).size.width * 0.024,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
