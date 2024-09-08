import 'package:bursa_flutter/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/color_const.dart';

class IDButton extends StatelessWidget {
  final String? iconPath;
  final String? idText;
  final String? idDesc;
  final Function()? onTap;
  final double? margin;
  final double? hPadding;
  final double? vPadding;
  final bool? isEnabled;

  const IDButton({
    Key? key,
    required this.onTap,
    this.iconPath = AppImages.faceIdIcon,
    this.idText = 'Face ID',
    this.idDesc =
        'Authenticate using  Face ID instead of entering your password',
    this.margin,
    this.hPadding,
    this.vPadding,
    this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: margin ?? 20.0),
        padding: EdgeInsets.symmetric(
            horizontal: hPadding ?? 20.0, vertical: vPadding ?? 24.0),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80.0,
              width: 80.0,
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greenColor.withOpacity(0.1),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath!,
                  height: 45.0,
                  width: 45.0,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        idText!,
                        style: GoogleFonts.poppins().copyWith(
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      isEnabled != null
                          ? (isEnabled!
                              ? Container(
                                  padding: EdgeInsets.only(
                                      left: width * .018,
                                      right: width * .018,
                                      top: width * .01,
                                      bottom: width * .01),
                                  decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(
                                        width * .03,
                                      ))),
                                  child: Text(
                                    "Enabled",
                                    style: GoogleFonts.poppins().copyWith(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: width * .024,
                                    ),
                                  ),
                                )
                              : Container())
                          : Container()
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    idDesc!,
                    style: GoogleFonts.poppins().copyWith(
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
