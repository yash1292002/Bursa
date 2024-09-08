import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../controllers/issue_digital_controller.dart';
import 'step_four/step_four_screen.dart';
import 'step_one/step_one_screen.dart';
import 'step_three/step_three_screen.dart';
import 'step_two/step_two_screen.dart';

class RegisterCertificateScreen extends StatefulWidget {
  const RegisterCertificateScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCertificateScreen> createState() =>
      _RegisterCertificateScreenState();
}

class _RegisterCertificateScreenState extends State<RegisterCertificateScreen> {
  int progress = ((1 / 4) * 100).toInt();
  int currentIndex = 0;
  PageController controller = PageController();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    IssueDigitalCertiController _issueDigitalCertiController =
        Provider.of<IssueDigitalCertiController>(context, listen: false);
    _issueDigitalCertiController.reset();
    _issueDigitalCertiController.getRegisterShare().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
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

          /// Appbar
          appBar: AppBar(
            backgroundColor: Colors.transparent,
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
            centerTitle: true,
            title: Text(
              currentIndex == 0 || currentIndex == 2
                  ? "Select Issuer"
                  : currentIndex == 1
                      ? 'Certificate'
                      : 'Signature',
              style: poppinsRegular.copyWith(
                color: AppColors.white1,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),

          body: SafeArea(
            child: Column(
              children: [
                /// step progress bar
                Container(
                  margin: EdgeInsets.only(
                    left: width * .123,
                    right: width * .123,
                    bottom: height * .036,
                    top: height * .01,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: height * .008,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Step " + (currentIndex + 1).toString() + " of 4",
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .04,
                          ),
                        ),
                      ),
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
                    controller: controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: whiteColor,
                            ))
                          : Container(
                              margin: EdgeInsets.only(
                                bottom: height * .01,
                                left: width * .053,
                                right: width * .053,
                              ),
                              child: StepOneScreen(
                                onTap: () {
                                  controller.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                  setState(
                                    () {
                                      progress = ((2 / 4) * 100).toInt();
                                      currentIndex = 1;
                                    },
                                  );
                                },
                              ),
                            ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .01,
                          left: width * .053,
                          right: width * .053,
                        ),
                        child: StepTwoScreen(
                          onTap: () {
                            controller.animateToPage(
                              2,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((3 / 4) * 100).toInt();
                                currentIndex = 2;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .01,
                          left: width * .053,
                          right: width * .053,
                        ),
                        child: StepThreeScreen(
                          onTap: () {
                            controller.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((4 / 4) * 100).toInt();
                                currentIndex = 3;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .01,
                          left: width * .053,
                          right: width * .053,
                        ),
                        child: StepFourScreen(
                          onTap: () {
                            controller.animateToPage(
                              4,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((4 / 4) * 100).toInt();
                                currentIndex = 3;
                              },
                            );
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
