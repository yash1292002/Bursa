import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class VerificationSecoundScreen extends StatefulWidget {
  const VerificationSecoundScreen({Key? key}) : super(key: key);

  @override
  State<VerificationSecoundScreen> createState() =>
      _VerificationSecoundScreenState();
}

class _VerificationSecoundScreenState extends State<VerificationSecoundScreen> {
  // List<TextEditingController> _otpControllers1 =
  //     List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
    _controller.initOtpController1(
        List.generate(4, (index) => TextEditingController()));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Future.delayed(const Duration(milliseconds: 100), () {
      _focusNodes[0].requestFocus();
    });
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
      child: Scaffold(
        backgroundColor: transparentColor,
        body: Container(
          margin: EdgeInsets.only(top: height * .04),
          child: Column(
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: width * .04, bottom: height * .06),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/icons/back_button.png",
                        height: height * .06,
                        width: width * .1,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: width * .1),
                      child: Text(
                        "Complete Verification",
                        style: poppinsRegular.copyWith(
                            color: white1,
                            fontWeight: FontWeight.w600,
                            fontSize: width * .048,
                            letterSpacing: .05),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: height * .02),
                child: Text(
                  "One last step to access our app.",
                  style: poppinsRegular.copyWith(
                    color: whiteColor,
                    fontSize: width * .043,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: height * .005,
                  bottom: height * .05,
                ),
                child: Text(
                  "Please enter your 4 digit passcode",
                  style: poppinsRegular.copyWith(
                    color: lightGrey2,
                    fontSize: width * .035,
                  ),
                ),
              ),
              Container(
                height: height * .08,
                margin:
                    EdgeInsets.only(left: width * .068, right: width * .068),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height * .06,
                        width: width * .15,
                        decoration: BoxDecoration(
                          color: whiteColorWithOpacity23,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .03,
                            ),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: TextField(
                          controller: _authController.otpController1![index],
                          focusNode: _focusNodes[index],
                          showCursor: true,
                          readOnly: true,
                          style: poppinsRegular.copyWith(
                            fontSize: width * .05,
                            color: white1, /////
                          ),
                          cursorColor: whiteColor,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: width * .063,
                              )),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Container(
                        width: width * .085,
                      );
                    },
                    itemCount: 4),
              ),
              Expanded(
                child: Container(
                  width: width,
                  // height: height,
                  margin: EdgeInsets.only(
                    top: height * .07,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        width * .04,
                      ),
                      topRight: Radius.circular(
                        width * .04,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  // maxCrossAxisExtent: 200,
                                  childAspectRatio: 1.8,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: 12,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext ctx, index) {
                            if (index == 9 || index == 11) {
                              if (index == 11) {
                                return GestureDetector(
                                  onTap: () {
                                    if (_authController
                                        .otpController1![3].text.isNotEmpty) {
                                      setState(() {
                                        _authController
                                            .otpController1![3].text = "";
                                        _focusNodes[3].unfocus();
                                        _focusNodes[2].requestFocus();
                                      });
                                    } else if (_authController
                                        .otpController1![2].text.isNotEmpty) {
                                      setState(() {
                                        _authController
                                            .otpController1![2].text = "";
                                        _focusNodes[2].unfocus();
                                        _focusNodes[1].requestFocus();
                                      });
                                    } else if (_authController
                                        .otpController1![1].text.isNotEmpty) {
                                      setState(() {
                                        _authController
                                            .otpController1![1].text = "";
                                        _focusNodes[1].unfocus();
                                        _focusNodes[0].requestFocus();
                                      });
                                    } else if (_authController
                                        .otpController1![0].text.isNotEmpty) {
                                      setState(() {
                                        _authController
                                            .otpController1![0].text = "";
                                        _focusNodes[0].unfocus();
                                      });
                                    }
                                  },
                                  child: Container(
                                      alignment: Alignment.center,
                                      color: Colors.transparent,
                                      child: const Icon(
                                        Icons.backspace_outlined,
                                      )),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              String value =
                                  index == 10 ? "0" : (index + 1).toString();
                              return GestureDetector(
                                onTap: () {
                                  log("Tapped");
                                  if (_authController
                                      .otpController1![0].text.isEmpty) {
                                    setState(() {
                                      _authController.otpController1![0].text =
                                          value;
                                      _focusNodes[0].unfocus();
                                      _focusNodes[1].requestFocus();
                                    });
                                  } else if (_authController
                                      .otpController1![1].text.isEmpty) {
                                    setState(() {
                                      _authController.otpController1![1].text =
                                          value;
                                      _focusNodes[1].unfocus();
                                      _focusNodes[2].requestFocus();
                                    });
                                  } else if (_authController
                                      .otpController1![2].text.isEmpty) {
                                    setState(() {
                                      _authController.otpController1![2].text =
                                          value;
                                      _focusNodes[2].unfocus();
                                      _focusNodes[3].requestFocus();
                                    });
                                  } else if (_authController
                                      .otpController1![3].text.isEmpty) {
                                    setState(() {
                                      _authController.otpController1![3].text =
                                          value;
                                      _focusNodes[3].unfocus();
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  color: transparentColor,
                                  child: Text(
                                    value,
                                    style: poppinsRegular.copyWith(
                                      fontSize: width * .06,
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                      // Text("By creating a passcode you agree to our Privacy Policy"),
                      Container(
                        margin: EdgeInsets.only(
                          top: height * .01,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: "By entering a passcode you agree to our ",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .03,
                              color: greyColor,
                            ),
                            children: [
                              TextSpan(
                                text: "Privacy Policy",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .03,
                                  color: blueColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () async {
                                String otp = _authController.otpController1!
                                    .map((e) => e.text)
                                    .join();
                                String emailOrPhone =
                                    _authController.emialOrPhoneController.text;
                                if (otp.length == 4) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await _authController
                                      .loginNewUser()
                                      .then((value) async {
                                    if (value) {
                                      await _authController
                                          .getUserInfo()
                                          .then((value1) {
                                        if (value1) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          // Navigator.push(
                                          //     context,
                                          //     PageTransition(
                                          //         child: HomeScreen(),
                                          //         type: PageTransitionType
                                          //             .rightToLeft,
                                          //         duration: Duration(
                                          //             microseconds: 300),
                                          //         reverseDuration: Duration(
                                          //             milliseconds: 300)));
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                reverseDuration: const Duration(
                                                    milliseconds: 300),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: const HomeScreen(),
                                              ),
                                              (route) => false);
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  });
                                } else {
                                  log("Invalid OTP");
                                  Fluttertoast.showToast(
                                    msg: "Please enter the Passcode",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: whiteColor,
                                    textColor: greenColor,
                                    fontSize: width * .035,
                                  );
                                }

                                //     if (otp.length == 4) {
                                //       // Navigator.push(
                                //       //   context,
                                //       //   MaterialPageRoute(
                                //       //     ///builder: (context) => HomeScreen(),
                                //       //     builder: (context) => HomeScreen(),
                                //       //   ),
                                //       // );
                                //      _authController.loginNewUser(emailOrPhone.toString(),otp.toString());
                                //     // _authController.loginNewUser();

                                //  Navigator.push(
                                //         context,
                                //         PageTransition(
                                //           duration: Duration(milliseconds: 300),
                                //           reverseDuration: Duration(milliseconds: 300),
                                //           type: PageTransitionType.rightToLeft,
                                //           child: HomeScreen(),
                                //         ),
                                //       );

                                //     } else {
                                //       log("Invalid OTP");
                                //     }
                              },
                        child: Container(
                          height: width * .11,
                          margin: EdgeInsets.only(
                            top: height * .03,
                            left: width * .15,
                            right: width * .15,
                          ),
                          decoration: BoxDecoration(
                            color: greenColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(width * .02)),
                          ),
                          alignment: Alignment.center,
                          child: isLoading
                              ? CircularProgressIndicator(
                                  color: whiteColor,
                                )
                              : Text(
                                  "Submit",
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
