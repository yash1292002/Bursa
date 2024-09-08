import 'package:flutter/material.dart';

import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';

class OtherServiceBox extends StatelessWidget {
  final String? imagePath;
  final String? text;
  final Function()? onTap;

  const OtherServiceBox({Key? key,
    this.imagePath = 'assets/icons/issuce_crtification.png',
    this.text = 'Issue Digital Certificate',
    required this.onTap,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height * .21,
        child: Container(
          width: width * .32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * .03),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: height * .015,
                  left: width * .04,
                ),
                child: Image.asset(
                  //otherService[index]['image'],
                  //'assets/icons/issuce_crtification.png',
                  imagePath!,
                  height: height * .075,
                  width: width * .12,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: width * .04,
                  top: height * .015,
                ),
                child: Text(
                  //otherService[index]['title'],
                  //'Issue Digital Certificate',
                  text!,
                  style: poppinsRegular.copyWith(
                      color: AppColors.blackColor,
                      fontSize: width * .035,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
