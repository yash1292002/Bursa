import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/auth/registration/face_touch_register.dart';
import 'package:bursa_flutter/views/auth/registration/registration_acknowledgement.dart';
import 'package:bursa_flutter/views/auth/registration/registration_address.dart';
import 'package:bursa_flutter/views/auth/registration/registration_document.dart';
import 'package:bursa_flutter/views/auth/registration/registration_education.dart';
import 'package:bursa_flutter/views/auth/registration/registration_id_proof.dart';
import 'package:bursa_flutter/views/auth/registration/registration_income.dart';
import 'package:bursa_flutter/views/auth/registration/registration_kyc.dart';
import 'package:bursa_flutter/views/auth/registration/registration_personal_detail.dart';
import 'package:bursa_flutter/views/auth/registration/registration_pin.dart';
import 'package:bursa_flutter/views/auth/registration/registration_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int progress = 0;
  int currentIndex = 0;
  bool back = true;

  int? shareValue;

  @override
  void initState() {
    super.initState();
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);

    _controller.reset();
    _controller.initPageController();
    _controller.getCountryId().then((value) {
      _controller.getNationalities().then((value1) {
        // setState(() {
        //   isLoading = false;
        // });
      });
    });
    _controller.getEmployementData().then((value) {
      setState(() {
        // isLoading = false;
      });
    });
    _controller.initEducation(
        List.generate(educationQuestion.length, (index) => null));

    _controller
        .initKycAnswer(List.generate(kycQuestions.length, (index) => null));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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
        child: WillPopScope(
          onWillPop: () async {
            if (_authController.controller!.page! > 2 ||
                _authController.controller!.page! != 10) {
              setState(
                () {
                  progress = (((currentIndex - 1) / 7) * 100).toInt();
                  if (currentIndex <= 0) {
                    currentIndex = 0;
                    Navigator.of(context).pop();
                  } else {
                    currentIndex = currentIndex - 1;
                  }
                },
              );
              _authController.controller!.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
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
                  // Navigator.pop(context);
                  if (_authController.controller!.page! > 2) {
                    setState(
                      () {
                        progress = (((currentIndex - 1) / 7) * 100).toInt();
                        currentIndex = currentIndex - 1;
                      },
                    );
                    _authController.controller!.previousPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    // return false;
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              title: Text(
                "Complete your profile",
                style: poppinsRegular.copyWith(
                  color: whiteColor,
                  fontSize: width * .046,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: width * .123,
                    right: width * .123,
                    bottom: height * .04,
                    top: height * .02,
                  ),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            bottom: height * .008,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Step " + currentIndex.toString() + " of 11",
                            style: poppinsRegular.copyWith(
                              color: whiteColor,
                              fontSize: width * .04,
                            ),
                          )),
                      FAProgressBar(
                        currentValue: progress,
                        size: height * .007,
                        progressColor: whiteColor,
                        backgroundColor: lightBlueColor2,
                        displayTextStyle: poppinsRegular.copyWith(
                          color: transparentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    allowImplicitScrolling: false,
                    controller: _authController.controller!,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        // DocumentScreen
                        child: DocumentScreen(ontap: () {
                          // _authController.controller!.animateToPage(
                          //   1,
                          //   duration: const Duration(milliseconds: 500),
                          //   curve: Curves.easeInOut,

                          // );
                          _authController.controller!.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            progress = ((1 / 11) * 100).toInt();
                            currentIndex = 1;
                          });
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        // IdProofScanScreen
                        child: IdProofScanScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((2 / 11) * 100).toInt();
                              currentIndex = 2;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            bottom: height * .01,
                            left: width * .053,
                            right: width * .053),
                        // PersonalDetailScreen
                        child: PersonalDetailScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((3 / 11) * 100).toInt();
                              currentIndex = 3;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            bottom: height * .01,
                            left: width * .053,
                            right: width * .053),
                        // AddressScreen
                        child: AddressScreen(ontap: () {
                          _authController.controller!.animateToPage(
                            4,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );

                          setState(() {
                            progress = ((4 / 11) * 100).toInt();
                            currentIndex = 4;
                          });
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            bottom: height * .01,
                            left: width * .053,
                            right: width * .053),
                        // EmployementAndIncomeDetailScreen
                        child: EmployementAndIncomeDetailScreen(
                          onTap: () {
                            _authController.controller!.animateToPage(
                              5,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((5 / 11) * 100).toInt();
                              currentIndex = 5;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            bottom: height * .01,
                            left: width * .053,
                            right: width * .053),
                        // EducationDetailScreen
                        child: EducationDetailScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              6,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((6 / 11) * 100).toInt();
                              currentIndex = 6;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        // KycDetailScreen
                        child: KycDetailScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              7,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((7 / 11) * 100).toInt();
                              currentIndex = 7;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        // AcknowledgementScreen
                        child: AcknowledgementScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              8,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((8 / 11) * 100).toInt();
                              currentIndex = 8;
                            });
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        child: FaceTouchRegister(
                          onTap: () {
                            _authController.controller!.animateToPage(
                              9,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((9 / 11) * 100).toInt();
                              currentIndex = 9;
                            });
                          },
                        ),
                      ),
                      PinSelectionScreen(
                        ontap: () {
                          _authController.controller!.animateToPage(
                            10,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            progress = ((10 / 11) * 100).toInt();
                            currentIndex = 10;
                          });
                        },
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        child: VerifyScreen(
                          ontap: () {
                            _authController.controller!.animateToPage(
                              11,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((11 / 11) * 100).toInt();
                              currentIndex = 11;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
