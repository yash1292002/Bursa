import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/views/auth/authenticaion_dashboard.dart';
import 'package:bursa_flutter/views/auth/face_finger/face_figner_welcome.dart';
import 'package:bursa_flutter/views/onboarding_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/splash_img.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              const Color(0xff2036CF).withOpacity(.28),
              const Color(0xff1B30B6).withOpacity(.42),
              const Color(0xff031645)
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: transparentColor,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [darkBlueColorWithOpacity7, darkBlueColor],
              ),
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                left: width * .1, right: width * .1, top: height * .1),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: width * .054,
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      width: width * 0.62,
                    ),
                  ),
                  Container(
                    // color: Colors.black,
                    margin: EdgeInsets.only(
                      top: height * .05,
                      bottom: height * .035,
                    ),
                    child: Text(
                      "Unlock the\nvalue of equity\nownership",
                      style: poppinsRegular.copyWith(
                        fontWeight: FontWeight.bold,
                        color: whiteColor,
                        fontSize: width * .092,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: height * .038,
                    ),
                    child: Text(
                      "We help companies stay private for\nlonger, and allow shareholders to access liquidity with the support of motivated and\nqualified investors.",
                      style: poppinsRegular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xffDBE1E9),
                        fontSize: width * .035,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => OnBoardingScreen()));
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeft,
                          child: const OnBoardingScreen(),
                        ),
                      );
                    },
                    child: Container(
                      width: width * .6,
                      height: height * .058,
                      decoration: BoxDecoration(
                        color: whiteColorWithOpacity23,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            width * .3,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View benefits",
                            style: poppinsRegular.copyWith(
                              color: whiteColor,
                              fontSize: width * .037,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: width * .01,
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: whiteColor,
                              size: width * .04,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //   builder: (context) =>
                      //       const AuthenticationDashBoardScreen(),
                      // ));
                      Navigator.push(
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
                      width: width * .6,
                      height: height * .058,
                      margin: EdgeInsets.only(
                        top: height * .02,
                        bottom: height * .03,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            width * .3,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Get Started",
                        style: poppinsRegular.copyWith(
                          color: whiteColor,
                          fontSize: width * .037,
                        ),
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Already have an account ? ",
                      style: poppinsRegular.copyWith(
                        color: const Color(0xffDBE1E9),
                        fontSize: width * .03,
                      ),
                      children: [
                        TextSpan(
                          text: "Sign in",
                          style: poppinsRegular.copyWith(
                            color: greenColor,
                            fontSize: width * .03,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
