import 'dart:async';

import 'package:bursa_flutter/consts/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/color_const.dart';
import 'face_scan_failed.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({Key? key}) : super(key: key);

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => Get.dialog(
        const FaceScanFailed(),
        barrierDismissible: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.personImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.blueColor.withOpacity(0.21),
              AppColors.greenColor.withOpacity(0.21),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 50.0, right: 50.0, top: 60.0),
                  child: SvgPicture.asset(AppImages.scanProcess),
                ),
                const Spacer(),
                Text(
                  '100%',
                  style: GoogleFonts.montserrat().copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 32.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.036),
                Text(
                  'Verifying your face',
                  style: GoogleFonts.montserrat().copyWith(
                    color: AppColors.whiteColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.09),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
