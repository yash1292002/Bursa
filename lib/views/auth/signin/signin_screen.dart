import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/auth/forgot_passcode/forgot_passcode_screen.dart';
import 'package:bursa_flutter/views/auth/signin/verification_secound_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../Services/api_services.dart';
import '../../../consts/strings.dart';
import '../../../widgets/dialogs/status_faild_dialog.dart';
import '../../../widgets/dialogs/status_success_new.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);

    _authController.resetLoginInfo();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: transparentColor,
            resizeToAvoidBottomInset: false,

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
            body: SafeArea(
              child: Column(
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

                  /// email or mobile number field
                  Container(
                    margin: EdgeInsets.only(
                      top: height * .1,
                      left: width * .08,
                      right: width * .08,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          width * .015,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: height * .02,
                      bottom: height * .015,
                      left: width * .03,
                      right: width * .03,
                    ),
                    child: TextFormField(
                      controller: _authController.emialOrPhoneController,
                      style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                      decoration: InputDecoration(
                        label: Text(
                          "Email Address or Mobile number",
                          style: poppinsRegular.copyWith(
                            color: lightBlueColorWithopacity40,
                            fontSize: width * .035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: width * .01,
                          right: width * .01,
                        ),
                      ),
                    ),
                  ),

                  /// login button
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            if (_authController
                                .emialOrPhoneController.text.isNotEmpty) {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => const VerificationScreen(),
                              // ));

                              isLoading = true;
                              setState(() {});
                              bool status = await ApiServices()
                                  .verifyEmailOrPhone(_authController
                                      .emialOrPhoneController.text);
                              setState(() {});
                              isLoading = false;

                              if (status) {
                                /*Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    type: PageTransitionType.rightToLeft,
                                    child: VerificationSecoundScreen(),
                                  ),
                                );*/
                                Get.dialog(
                                  StatusSuccessNewDialog(
                                    text: AppStrings.detailsOrCorrect,
                                    onTap: () {
                                      Navigator.of(context).pop();

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          reverseDuration:
                                              const Duration(milliseconds: 300),
                                          type: PageTransitionType.rightToLeft,
                                          child:
                                              const VerificationSecoundScreen(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                Get.dialog(
                                    const StatusFailedDialog(
                                      text: AppStrings.unableToIdentify,
                                    ),
                                    barrierDismissible: false);
                              }
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please enter mobile number or email",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: whiteColor,
                                textColor: greenColor,
                                fontSize: width * .035,
                              );
                            }
                          },
                    child: Container(
                      height: width * .11,
                      margin: EdgeInsets.only(
                        top: width * .03,
                        left: width * .08,
                        right: width * .08,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(width * .015),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        isLoading ? "please wait..." : "Login",
                        style: poppinsRegular.copyWith(
                          color: whiteColor,
                          fontSize: width * .036,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              //child: SignInScreen(),
                              child: const ForgotPasscodeScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Forgot passcode?',
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .036,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// terms and condition and privacy policy texts
                  SizedBox(height: height * 0.16),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: height * .03,
                    ),
                    child: Column(
                      children: [
                        // this code is term and condition and privacy policy
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .008,
                            left: width * .065,
                            right: width * .065,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    "By login, you agree to the Terms & Conditions set by Bursa.",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .032,
                                  color: whiteColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    termCondition();
                                  }),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .008,
                            left: width * .065,
                            right: width * .065,
                          ),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text:
                                    "For more information on how we handle your personal data, please refer to our Privacy Policy.",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .032,
                                  color: whiteColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    privacypolicy();
                                  }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  /// privacy Policy sheet

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
}
