import 'dart:developer';

import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class PinSelectionScreen extends StatefulWidget {
  PinSelectionScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<PinSelectionScreen> createState() => _PinSelectionScreenState();
}

class _PinSelectionScreenState extends State<PinSelectionScreen> {
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();

    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
    _controller.initOtpController(
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
    AuthController _authcontroller =
        Provider.of<AuthController>(context, listen: true);
    return Column(
      children: [
        Text(
          "One last step to access our app.",
          style: poppinsRegular.copyWith(
            color: whiteColor,
            fontSize: width * .04,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: height * .005,
            bottom: height * .05,
          ),
          child: Text(
            "Create a new 4 digit passcode",
            style: poppinsRegular.copyWith(
              color: lightGreyColor,
              fontSize: width * .03,
            ),
          ),
        ),
        Container(
          height: height * .08,
          margin: EdgeInsets.only(left: width * .068, right: width * .068),
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
                    controller: _authcontroller.otpControllers![index],
                    focusNode: _focusNodes[index],
                    showCursor: true,
                    readOnly: true,
                    style: poppinsRegular.copyWith(
                      fontSize: width * .05,
                      color: whiteColor,
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
              top: height * .04,
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
                            childAspectRatio: 1.9,
                            crossAxisSpacing: 0,
                            mainAxisSpacing: 0),
                    itemCount: 12,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext ctx, index) {
                      if (index == 9 || index == 11) {
                        if (index == 11) {
                          return GestureDetector(
                            onTap: () {
                              if (_authcontroller
                                  .otpControllers![3].text.isNotEmpty) {
                                setState(() {
                                  _authcontroller.otpControllers![3].text = "";
                                  _focusNodes[3].unfocus();
                                  _focusNodes[2].requestFocus();
                                });
                              } else if (_authcontroller
                                  .otpControllers![2].text.isNotEmpty) {
                                setState(() {
                                  _authcontroller.otpControllers![2].text = "";
                                  _focusNodes[2].unfocus();
                                  _focusNodes[1].requestFocus();
                                });
                              } else if (_authcontroller
                                  .otpControllers![1].text.isNotEmpty) {
                                setState(() {
                                  _authcontroller.otpControllers![1].text = "";
                                  _focusNodes[1].unfocus();
                                  _focusNodes[0].requestFocus();
                                });
                              } else if (_authcontroller
                                  .otpControllers![0].text.isNotEmpty) {
                                setState(() {
                                  _authcontroller.otpControllers![0].text = "";
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
                            if (_authcontroller
                                .otpControllers![0].text.isEmpty) {
                              setState(() {
                                _authcontroller.otpControllers![0].text = value;
                                _focusNodes[0].unfocus();
                                _focusNodes[1].requestFocus();
                              });
                            } else if (_authcontroller
                                .otpControllers![1].text.isEmpty) {
                              setState(() {
                                _authcontroller.otpControllers![1].text = value;
                                _focusNodes[1].unfocus();
                                _focusNodes[2].requestFocus();
                              });
                            } else if (_authcontroller
                                .otpControllers![2].text.isEmpty) {
                              setState(() {
                                _authcontroller.otpControllers![2].text = value;
                                _focusNodes[2].unfocus();
                                _focusNodes[3].requestFocus();
                              });
                            } else if (_authcontroller
                                .otpControllers![3].text.isEmpty) {
                              setState(() {
                                _authcontroller.otpControllers![3].text = value;
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
                // Container(
                //   margin: EdgeInsets.only(
                //     top: height * .01,
                //   ),
                //   child: RichText(
                //     text: TextSpan(
                //       text: "By creating a passcode you agree to our ",
                //       style: poppinsRegular.copyWith(
                //         fontSize: width * .03,
                //         color: greyColor,
                //       ),
                //       children: [
                //         TextSpan(
                //           text: "Privacy Policy",
                //           style: poppinsRegular.copyWith(
                //             fontSize: width * .03,
                //             color: blueColor,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .01,
                    left: width * .065,
                    right: width * .065,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "By creating a passcode you agree to our ",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .032,
                        color: greyColor,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          privacypolicy();
                        },
                      children: [
                        TextSpan(
                          text: "Privacy Policy",
                          style: poppinsRegular.copyWith(
                            fontSize: width * .03,
                            color: blueColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              privacypolicy();
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          String otp = _authcontroller.otpControllers!
                              .map((e) => e.text)
                              .join();
                          if (otp.length == 4) {
                            setState(() {
                              isLoading = true;
                            });
                            //widget.ontap();
                            //    String passcode = "";

                            // _authcontroller.otpControllers!.forEach((element) {
                            //   passcode += element.text;
                            // });
                            // print({
                            //   _authcontroller.firstNameController.text,
                            //   _authcontroller.lastNameController.text,
                            //   _authcontroller.emailController.text,
                            //   _authcontroller.birthofdateController.text,
                            //   _authcontroller.phoneNumberController.text,
                            //   _authcontroller.selectedCountry!.name.toString(),

                            //   _authcontroller.cityNameController.text,
                            //   _authcontroller.addressNameController.text,
                            //   _authcontroller.selectedNationality!.name.toString(),
                            //   _authcontroller.selectedEmployement!.name.toString(),
                            //   _authcontroller.incomeTextController.text,
                            //   _authcontroller.employeeNameController.text,
                            //   _authcontroller.dateOfEmploymentController.text,
                            //  // _authcontroller.emaployement.toString(),
                            //   _authcontroller.educationAnswers.toList(),
                            //   _authcontroller.kycAnswers.toList(),
                            //   _authcontroller.pinController.text,
                            //   passcode
                            // });
                            // await _authcontroller
                            //     .registerNewUser()
                            //     .then((value) async {
                            //   if (value) {
                            await _authcontroller.sendOtp().then((value) {
                              if (value) {
                                setState(() {
                                  isLoading = false;
                                });
                                //   Navigator.push(
                                //   context,
                                //   PageTransition(
                                //     duration: Duration(milliseconds: 300),
                                //     reverseDuration: Duration(milliseconds: 300),
                                //     type: PageTransitionType.rightToLeft,
                                //     child: SuccessScreen(
                                //       ontap: () {},
                                //     ),
                                //   ),

                                // );
                                widget.ontap();
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Fluttertoast.showToast(
                                  msg: "Something went wrong!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: whiteColor,
                                  textColor: greenColor,
                                  fontSize: width * .035,
                                );
                              }
                            });
                          }
                          // });
                          else {
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
