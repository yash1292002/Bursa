import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/views/auth/signin/verification_secound_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: width * .15,
      height: height * .07,
      textStyle: poppinsRegular.copyWith(
        fontSize: width * .04,
        color: lightBlueColor1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          width * .025,
        ),
        color: lightGreyColor1,
        border: Border.all(color: transparentColor),
      ),
    );
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
        appBar: AppBar(
          backgroundColor: transparentColor,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              padding: EdgeInsets.all(
                width * .02,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: lightBlueColor,
                size: width * .045,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Complete Verification",
            style: poppinsRegular.copyWith(
              color: whiteColor,
              fontSize: width * .046,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                bottom: height * .01,
                left: width * .053,
                right: width * .053,
                top: height * .06),
            child: Column(
              children: [
                Container(
                  // height: height * .73,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        width * .03,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                      top: height * .03,
                      bottom: height * .03,
                      left: width * .05,
                      right: width * .05),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "Please enter the verification code sent to your phone ",
                          style: poppinsRegular.copyWith(
                            color: greyColor,
                            fontSize: width * .035,
                          ),
                          children: [
                            TextSpan(
                                text: "00971506198356",
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .035,
                                )),
                            const TextSpan(
                              text: " or email ",
                            ),
                            TextSpan(
                              text: "Amroalqubaisi@gmail.com",
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .035,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * .06, bottom: height * .06),
                        child: Pinput(
                          controller: pinController,
                          focusNode: focusNode,
                          separator: Container(
                            width: width * .06,
                          ),
                          defaultPinTheme: defaultPinTheme,
                          // toolbarEnabled: false,
                          onClipboardFound: (value) {
                            debugPrint('onClipboardFound: $value');
                            pinController.setText(value);
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: debugPrint,
                          cursor: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: height * .01),
                                width: width * .05,
                                height: height * .001,
                                color: lightBlueColor1,
                              ),
                            ],
                          ),
                          focusedPinTheme: defaultPinTheme,
                          submittedPinTheme: defaultPinTheme,
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                        ),
                      ),
                      Text(
                        "Didn't receive the verification code?",
                        style: poppinsRegular.copyWith(
                          color: greyColor,
                          fontSize: width * .035,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width * .4,
                          height: height * .06,
                          margin: EdgeInsets.only(
                            top: height * .025,
                            bottom: height * .025,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffE6F6F4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(width * .06),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Resend",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .035,
                              color: greenColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Review Contact Details",
                        style: poppinsRegular.copyWith(
                          color: greenColor,
                          fontSize: width * .035,
                        ),
                      ),
                      GestureDetector(
                        // onTap: widget.ontap,
                        onTap: () {
                          if (pinController.text.isNotEmpty) {
                            if (pinController.text.length < 4) {
                              Fluttertoast.showToast(
                                msg: "Please enter the valid verification code",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: whiteColor,
                                textColor: greenColor,
                                fontSize: width * .035,
                              );
                            } else {
                              // Navigator.of(context).pushAndRemoveUntil(
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const VerificationSecoundScreen(),
                              //     ),
                              //     (route) => false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    type: PageTransitionType.rightToLeft,
                                    child: const VerificationSecoundScreen(),
                                  ),
                                  (route) => false);
                            }
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please enter the verification code",
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
                            top: height * .065,
                          ),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * .02)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Next",
                            style: poppinsRegular.copyWith(
                              color: whiteColor,
                              fontSize: width * .036,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // Container(
                //   margin: EdgeInsets.only(
                //     top: height * .07,
                //     left: width * .065,
                //     right: width * .065,
                //   ),
                //   child: Text(
                //     "By registering, you agree to the Terms & Conditions set by Bursa.",
                //     style: poppinsRegular.copyWith(
                //       fontSize: width * .030,
                //       color: whiteColor,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.only(
                //     top: height * .01,
                //     left: width * .065,
                //     right: width * .065,
                //   ),
                //   child: Text(
                //     "For more information on how we handle your personal data, please refer to our Privacy Policy.",
                //     style: poppinsRegular.copyWith(
                //       fontSize: width * .030,
                //       color: whiteColor,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
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
                            "By completing your registration, you agree to the Terms & Conditions set by Bursa.",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .032,
                          color: whiteColor,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            termcondition();
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
