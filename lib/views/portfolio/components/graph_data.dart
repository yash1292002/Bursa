import 'package:flutter/material.dart';

import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';

class GraphData extends StatelessWidget {
  final Color? boxColor;
  final String? text;
  final String? percentText;

  const GraphData({Key? key,
    this.boxColor = AppColors.darkBlueColor,
    this.text = 'Text',
    this.percentText = '5%',
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 13.0,
          width: 13.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: boxColor,
          ),
        ),
        const SizedBox(width: 13.0),
        Expanded(
          child: Text(text!,
            style: poppinsRegular.copyWith(
              fontSize: 11.0,
              fontWeight: FontWeight.w400,
              color: AppColors.lightBlueColor,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Text(percentText!,
          style: poppinsRegular.copyWith(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlueColor,
          ),
        ),
      ],
    );
  }
}
