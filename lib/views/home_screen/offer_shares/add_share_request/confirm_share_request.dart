import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../consts/color_const.dart';

class ConfirmShareRequest extends StatefulWidget {
  const ConfirmShareRequest({Key? key}) : super(key: key);

  @override
  State<ConfirmShareRequest> createState() => _ConfirmShareRequestState();
}

class _ConfirmShareRequestState extends State<ConfirmShareRequest> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blueColor,
            AppColors.greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Image.asset(AppImages.logoImage, height: height * 0.1),
              ),
              SizedBox(height: height * 0.06),
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 40.0),
                decoration: BoxDecoration(
                  color: AppColors.white1,
                  borderRadius: BorderRadius.circular(11.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(AppImages.celebrateImage,
                          height: width * .25),
                    ),
                    SizedBox(height: height * 0.025),

                    /// congrats texts
                    Center(
                      child: Text(
                        'Thank you for submitting your \noffer request.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 16.0,
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.04),

                    Center(
                      child: Text(
                        'Your request EOR-0001 will be reviewed by '
                        '\nour buy-side team and arrange to contact '
                        '\nyou within 48 hours. ',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12.0,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.093),
                    CustomButton(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => HomeScreen(),
                        //   ),
                        // );
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: const HomeScreen(),
                            ),
                            (route) => false);
                      },
                      btnHeight: 55.0,
                      btnText: 'Return to Home',
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      borderRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
