import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/views/auth/signin/signin_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../consts/textstyle_const.dart';
import '../authenticaion_dashboard.dart';
import 'face/face_bottom_sheet.dart';
import 'finger/touch_bottom_sheet.dart';

class FaceFingerWelcomeScreen extends StatefulWidget {
  const FaceFingerWelcomeScreen({Key? key}) : super(key: key);

  @override
  State<FaceFingerWelcomeScreen> createState() =>
      _FaceFingerWelcomeScreenState();
}

class _FaceFingerWelcomeScreenState extends State<FaceFingerWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: transparentColor,

            /// Appbar
            appBar: AppBar(
              backgroundColor: transparentColor,
              elevation: 0.0,
              leadingWidth: 60.0,
              leading: IconButton(
                onPressed: () {
                  //Get.offAll(const PersisNavBar());
                  Navigator.pop(context);
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Image.asset('assets/icons/back_button.png'),
                ),
              ),
            ),

            /// body
            body: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.12),

                    /// welcome text
                    Text(
                      'Welcome back',
                      style: poppinsRegular.copyWith(
                        color: whiteColor,
                        fontSize: width * .05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 8.0),

                    /// signin continue text
                    Text(
                      'Please Sign in to continue',
                      style: poppinsRegular.copyWith(
                        color: whiteColor,
                        fontSize: width * .045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * 0.1),

                    /// face id button
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          const FaceBottomSheet(),
                          enableDrag: false,
                          backgroundColor: AppColors.whiteColor,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * .056,
                        margin: EdgeInsets.only(
                          bottom: height * .01,
                          left: width * .08,
                          right: width * .08,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .012,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: width * .04, right: width * .04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 36.0,
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImages.faceIdIcon,
                                  height: 20.0,
                                  width: 20.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Text(
                                "Login with Face ID",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .038,
                                  color: lightBlueColor,
                                ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          const TouchBottomSheet(),
                          enableDrag: false,
                          backgroundColor: AppColors.whiteColor,
                          isDismissible: false,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height * .056,
                        margin: EdgeInsets.only(
                          bottom: height * .01,
                          left: width * .08,
                          right: width * .08,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .012,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: width * .04, right: width * .04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 36.0,
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImages.fingerIdIcon,
                                  height: 20.0,
                                  width: 20.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Text(
                                "Login with Touch ID",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .038,
                                  color: lightBlueColor,
                                ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            //child: SignInScreen(),
                            child: const SignInScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: height * .056,
                        margin: EdgeInsets.only(
                          bottom: height * .01,
                          left: width * .08,
                          right: width * .08,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .012,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: width * .04, right: width * .04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 36.0,
                              width: 36.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.greenColor.withOpacity(0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppImages.fingerIdIcon,
                                  height: 20.0,
                                  width: 20.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 32.0),
                              child: Text(
                                "Login with Email or Number",
                                textAlign: TextAlign.center,
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .038,
                                  color: lightBlueColor,
                                ),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 32.0, right: 32.0, bottom: height * .01),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(AppImages.rowDotLine),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'OR',
                              style: GoogleFonts.poppins().copyWith(
                                color: AppColors.whiteColor,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Image.asset(AppImages.rowDotLine),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        /* Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            //child: SignInScreen(),
                            child: const FaceFingerWelcomeScreen(),
                          ),
                        );*/
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: const AuthenticationDashBoardScreen(),
                          ),
                        );
                      },
                      child: Container(
                        height: height * .056,
                        margin: EdgeInsets.only(
                          bottom: height * .01,
                          left: width * .08,
                          right: width * .08,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor1,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .012,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            left: width * .04, right: width * .04),
                        child: Text(
                          "Register now",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .038,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),

                    /// Terms and conditions and privacy policy text
                    SizedBox(height: height * 0.2),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36.0),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "By completing your registration, you agree to the ",
                          style: poppinsRegular.copyWith(
                              fontSize: width * .032,
                              fontWeight: FontWeight.normal,
                              color: AppColors.whiteColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              termCondition();
                            },
                          children: [
                            TextSpan(
                              text: "Terms & Conditions ",
                              style: poppinsRegular.copyWith(
                                  fontSize: width * .032,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  termCondition();
                                },
                            ),
                            TextSpan(
                                text: " And ",
                                style: poppinsRegular.copyWith(
                                    fontSize: width * .032,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.whiteColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    privacyPolicy();
                                  }),
                            TextSpan(
                                text: " Privacy Policy ",
                                style: poppinsRegular.copyWith(
                                    fontSize: width * .035,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    privacyPolicy();
                                  }),
                            TextSpan(
                              text: "set by Bursa.",
                              style: poppinsRegular.copyWith(
                                  fontSize: width * .032,
                                  fontWeight: FontWeight.normal,
                                  color: AppColors.whiteColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  termCondition();
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: width * .05,
                  ),
                  child: Image.asset("assets/images/logo.png",
                      width: width * 0.53),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void termCondition() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .02),
            topRight: Radius.circular(width * .02),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: height * .8,
            margin: EdgeInsets.only(
              top: height * .01,
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              children: [
                Container(
                  width: width * .3,
                  height: height * .002,
                  color: lightGreyColor,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Terms & Conditions",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. INTRODUCTION",
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04),
                          ),
                          Text(
                            terms1Condition[0]["text1"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "2. GENERAL SECURITIES LAW",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text2"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "3. USER OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text3"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "4. PRIVACY AND PROTECTION POLICY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text4"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "5. OWNERSHIP OF PLATFORM, SERVICES & CONTENT, INVESTOR QUESTIONNAIRE, SUBSCRIBTION AGREEMENTS AND ALLOCATION FORMS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text5"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "6. RESERVATION OF COMPANY RIGHTS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text6"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "7. SCOPE OF BURSA’S OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text7"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "8. TERM & TERMINATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text8"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "9. DISCLAIMERS, LIMITATIONS, WAIVERS OF LIABILITY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text9"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "10. INDEMNIFICATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text10"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "11. MICELLENOUS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text11"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "12. DEFINITIONS, LISCENSE GRANT",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text12"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }

  void privacyPolicy() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .02),
            topRight: Radius.circular(width * .02),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: height * .8,
            margin: EdgeInsets.only(
              top: height * .01,
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              children: [
                Container(
                  width: width * .3,
                  height: height * .002,
                  color: lightGreyColor,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Privacy Policy",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. FOREWORD",
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04),
                          ),
                          Text(
                            privacy1Policy[0]["text1"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "2. SCOPE AND PURPOSE OF THIS PRIVACY POLICY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text2"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "3. CATEGORIES OF PERSONAL DATA PROCESSED AND PURPOSES OF PROCESSING",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text3"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "4. DATA RECIPIENTS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text4"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "5. TRANSFERS OUTSIDE THE EUROPEAN ECONOMIC AREA",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text5"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "6. DATA RETENTION PERIODS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text6"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "7. YOUR RIGHTS AND OBLIGATIONS AS DATA SUBJECT",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text7"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "8. CONTACT DETAILS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text8"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }
}
