import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/views/auth/face_finger/face_figner_welcome.dart';
import 'package:bursa_flutter/views/auth/registration/regula_initialization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class AuthenticationDashBoardScreen extends StatefulWidget {
  const AuthenticationDashBoardScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationDashBoardScreen> createState() =>
      _AuthenticationDashBoardScreenState();
}

class _AuthenticationDashBoardScreenState
    extends State<AuthenticationDashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            blueColor,
            greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(left: width * .04, right: width * .04),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: width * .05,
                    ),
                    child: Image.asset("assets/images/logo.png",
                        width: width * 0.53),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .02,
                          ),
                          child: Text(
                            "MENA’s 1st regulated private market investment marketplace",
                            style: poppinsRegular.copyWith(
                              color: whiteColor,
                              fontSize: width * .045,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .03,
                            bottom: height * .025,
                          ),
                          child: Text(
                            "Regulated by",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .028,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        Image.asset("assets/images/organization_logo.png",
                            width: width * 0.53),
                        Container(
                          height: height * .056,
                          margin: EdgeInsets.only(
                            top: height * .05,
                            left: width * .065,
                            right: width * .065,
                          ),
                          decoration: BoxDecoration(
                            color: darkBlueColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                width * .012,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_circle,
                                size: width * .068,
                                color: whiteColor,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: width * .02,
                                ),
                                child: Text(
                                  "Watch our video",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .037,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .03,
                            left: width * .065,
                            right: width * .065,
                            bottom: height * .03,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: height * .001,
                                  color: whiteColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * .04, right: width * .04),
                                child: Text(
                                  "Registration",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .035,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * .001,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            registerasinvestor();
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => const RegistrationScreen(),
                            // ));
                          },
                          child: Container(
                            height: height * .056,
                            margin: EdgeInsets.only(
                              bottom: height * .01,
                              left: width * .065,
                              right: width * .065,
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
                                Container(),
                                Text(
                                  "Register as Investor",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .038,
                                    color: lightBlueColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showInfo(0);
                                  },
                                  child: Icon(
                                    Icons.help_outline,
                                    size: width * .06,
                                    color: lightBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "Coming Soon!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: whiteColor,
                              textColor: greenColor,
                              fontSize: width * .035,
                            );
                          },
                          child: Container(
                            height: height * .056,
                            margin: EdgeInsets.only(
                              bottom: height * .01,
                              left: width * .065,
                              right: width * .065,
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
                                Container(),
                                Text(
                                  "Register as Issuer",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .038,
                                    color: lightBlueColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showInfo(1);
                                  },
                                  child: Icon(
                                    Icons.help_outline,
                                    size: width * .06,
                                    color: lightBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "Coming Soon!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: whiteColor,
                              textColor: greenColor,
                              fontSize: width * .035,
                            );
                          },
                          child: Container(
                            height: height * .056,
                            margin: EdgeInsets.only(
                              bottom: height * .01,
                              left: width * .065,
                              right: width * .065,
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
                                Container(),
                                Text(
                                  "Register as Fund Managers",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .038,
                                    color: lightBlueColor,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showInfo(2);
                                  },
                                  child: Icon(
                                    Icons.help_outline,
                                    size: width * .06,
                                    color: lightBlueColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => const SignInScreen(),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 300),
                                reverseDuration:
                                    const Duration(milliseconds: 300),
                                type: PageTransitionType.rightToLeft,
                                //child: SignInScreen(),
                                child: const FaceFingerWelcomeScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: height * .056,
                            margin: EdgeInsets.only(
                              bottom: height * .01,
                              left: width * .065,
                              right: width * .065,
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
                              "Login",
                              style: poppinsRegular.copyWith(
                                fontSize: width * .038,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        // this code is term and condition and privacy policy
                        // Container(
                        //   margin: EdgeInsets.only(
                        //     top: height * .006,
                        //     left: width * .065,
                        //     right: width * .065,
                        //   ),
                        //   child: RichText(
                        //     textAlign: TextAlign.center,
                        //     text: TextSpan(
                        //         text:
                        //             "By completing your registration, you agree to the Terms & Conditions set by Bursa.",
                        //         style: poppinsRegular.copyWith(
                        //           fontSize: width * .032,
                        //           color: whiteColor,
                        //         ),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             termcondition();
                        //           }),
                        //   ),
                        // ),
                        // Container(
                        //   margin: EdgeInsets.only(
                        //     top: height * .008,
                        //     left: width * .065,
                        //     right: width * .065,
                        //   ),
                        //   child: RichText(
                        //     textAlign: TextAlign.center,
                        //     text: TextSpan(
                        //         text:
                        //             "For more information on how we handle your personal data, please refer to our Privacy Policy.",
                        //         style: poppinsRegular.copyWith(
                        //           fontSize: width * .032,
                        //           color: whiteColor,
                        //         ),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             privacypolicy();
                        //           }),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void privacypolicy() {
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
              /*left: width * .06,
              right: width * .06,*/
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
                      Container(),
                      Text(
                        "Privacy Policy",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      /*  GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),*/
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * .06, right: width * .06),
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
                  ),
                )
              ],
            ),
          );
        });
  }

  /// this is use for term and condition
  void termcondition() {
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
              /*left: width * .06,
              right: width * .06,*/
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
                      Container(),
                      Text(
                        "Terms & Conditions",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      /*GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),*/
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Image.asset(
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: width * .06, right: width * .06),
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
                  ),
                )
              ],
            ),
          );
        });
  }

  void showInfo(int i) {
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
                        registerGuideInfo[i]["title"],
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
                      children: List.generate(
                          registerGuideInfo[i]["description"].length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
                          child: Container(
                            // color: Colors.black,
                            margin: EdgeInsets.only(top: width * .048),
                            child: Text(
                              registerGuideInfo[i]["description"][index],
                              style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .035,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  void registerasinvestor() {
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
            height: height * .62,
            margin: EdgeInsets.only(
              top: height * .01,
              /* left: width * .05,
              right: width * .05,*/
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    width: width * .3,
                    height: height * .003,
                    color: lightGreyColor,
                  ),
                ),
                /*Container(
                  // color: Colors.black,
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                ),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "assets/icons/closeicon.png",
                        height: width * .04,
                        width: width * .04,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Register as investor',
                  style: poppinsRegular.copyWith(
                    fontSize: width * .058,
                    fontWeight: FontWeight.w600,
                    color: greenColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 30, left: width * .05, right: width * .05),
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    elevation: 0,
                    minWidth: 200.0,
                    height: 55,
                    color: const Color(0xFFF2F3F6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/finger_icon.png",
                          height: width * .09,
                          // width: width * .04,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Signup with  UAE PASS",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .040,
                            color: const Color(0xff3E3C3D),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "Coming Soon!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: greenColor,
                        textColor: whiteColor,
                        fontSize: width * .035,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 30, left: width * .05, right: width * .05),
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                    elevation: 0,
                    minWidth: 200.0,
                    height: 55,
                    color: const Color(0xff01A295),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/emiratesid.png",
                          height: width * .09,
                          color: Colors.white,
                          // width: width * .04,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Signup with Emirates ID",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .040,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => const RegistrationScreen(),
                      // ));
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeft,
                          child: const RegulaInitializationScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25, left: width * .05, right: width * .05),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text:
                          "By completing your registration, you agree to the\n",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .035,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff617996),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          termcondition();
                        },
                      children: [
                        TextSpan(
                          text: "Terms & Conditions ",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .035,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xff01A295),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              termcondition();
                            },
                        ),
                        TextSpan(
                          text: "set by Bursa.",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .035,
                            fontWeight: FontWeight.normal,
                            color: const Color(0xff617996),
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              termcondition();
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 25, left: width * .05, right: width * .05),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "For more information on how we handle your\n",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .035,
                        fontWeight: FontWeight.normal,
                        color: const Color(0xff617996),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          privacypolicy();
                        },
                      children: [
                        TextSpan(
                            text: "personal data, please refer to our ",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff617996),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                privacypolicy();
                              }),
                        TextSpan(
                            text: "Privacy Policy.",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                              color: const Color(0xff01A295),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                privacypolicy();
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

/////////////

}
