import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/views/auth/registration/registration_pin.dart';
import 'package:bursa_flutter/views/auth/registration/registration_success.dart';
import 'package:bursa_flutter/views/auth/registration/registration_verify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_progress_widget.dart';
import '../home_screen/home_screen.dart';
import 'ragester_shar_date.dart';
import 'registerUploadDoc.dart';
import 'registerUploadScreen.dart';
import 'register_grant_Equity.dart';
import 'register_grant_first.dart';
import 'register_grant_restrication.dart';
import 'register_grant_type.dart';
import 'register_person_info.dart';

class RagisterShar extends StatefulWidget {
  const RagisterShar({Key? key}) : super(key: key);

  @override
  State<RagisterShar> createState() => _RagisterSharState();
}

class _RagisterSharState extends State<RagisterShar>
    with TickerProviderStateMixin {
  int progress = 0;
  int currentIndex = 0;
  PageController _controller = PageController();
  int? shareValue;
  TabController? _controller1;
  int bottomNavBarIndex = 0;
  List<String> selectedEquityRounds = [];
  String selectedDebtRounds = "Mezanine";
  bool isConsent = false;

  @override
  void initState() {
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: false);

    super.initState();
    _controller1 = TabController(length: 2, vsync: this);
    _registerShareController.resetData();
    _registerShareController.getCompanyList().then((value) {
      setState(() {
        isLoading = true;
      });
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            if (_controller.page == 0) {
              return true;
            } else {
              setState(
                () {
                  progress = (((currentIndex - 1) / 7) * 100).toInt();
                  currentIndex = currentIndex - 1;
                },
              );
              _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);

              return false;
            }
          },
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            backgroundColor: transparentColor,

            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * .05, left: width * .04),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (_controller.page == 0) {
                              Navigator.pop(context);
                            } else {
                              setState(
                                () {
                                  progress =
                                      (((currentIndex - 1) / 7) * 100).toInt();
                                  currentIndex = currentIndex - 1;
                                },
                              );
                              _controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            }
                          },
                          child: Image.asset(
                            "assets/icons/back_button.png",
                            height: height * .06,
                            width: width * .1,
                          )),
                      currentIndex == 7
                          ? Container(
                              margin: EdgeInsets.only(left: width * .18),
                              child: Text(
                                "Upload Share",
                                style: poppinsRegular.copyWith(
                                    color: white1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * .048,
                                    letterSpacing: .05),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(left: width * .18),
                              child: Text(
                                "Register Shares",
                                style: poppinsRegular.copyWith(
                                    color: white1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width * .048,
                                    letterSpacing: .05),
                              ),
                            ),
                    ],
                  ),
                ),
                Visibility(
                  visible: false,
                  child: TabBar(
                    padding: EdgeInsets.only(
                        left: width * .04,
                        right: width * .04,
                        top: height * .01),
                    indicator: const BoxDecoration(),
                    controller: _controller1,
                    onTap: (index) {
                      setState(() {});
                    },
                    labelPadding: EdgeInsets.symmetric(
                      horizontal: width * .0,
                      vertical: 0,
                    ),
                    tabs: [
                      Tab(
                        height: height * .075,
                        child: Container(
                          decoration: _controller1!.index == 0
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width * .02),
                                      bottomLeft: Radius.circular(width * .02)),
                                  color: cyanColorwithopticity10,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width * .02),
                                      bottomLeft: Radius.circular(width * .02)),
                                  border: Border.all(
                                    color: whiteColorWithopticity20,
                                  ),
                                ),
                          padding: EdgeInsets.only(
                            top: height * .015,
                            bottom: height * .01,
                            left: width * .03,
                            right: width * .03,
                          ),
                          child: Row(children: [
                            Container(
                              width: width * .11,
                              decoration: BoxDecoration(
                                color: _controller1!.index == 0
                                    ? greenColorwithopticity40
                                    : AppColors.darkgrey,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(
                                width * .01,
                              ),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/icons/personicon.png",
                                color: _controller1!.index == 0
                                    ? whiteColor
                                    : whiteColor,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                    left: width * .016,
                                  ),
                                  child: Text(
                                    "Grant Information",
                                    style: poppinsRegular.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .033,
                                      color: _controller1!.index == 0
                                          ? whiteColor
                                          : AppColors.darkgrey,
                                    ),
                                  )),
                            ),
                          ]),
                        ),
                      ),
                      Tab(
                        height: height * .075,
                        child: Container(
                          decoration: _controller1!.index == 1
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * .02),
                                    bottomRight: Radius.circular(width * .02),
                                  ),
                                  color: cyanColorwithopticity10,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(width * .02),
                                    bottomRight: Radius.circular(width * .02),
                                  ),
                                  border: Border.all(
                                    color: whiteColorWithopticity20,
                                  ),
                                ),
                          padding: EdgeInsets.only(
                            top: width * .025,
                            bottom: width * .025,
                            left: width * .03,
                            right: width * .03,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: width * .11,
                                decoration: BoxDecoration(
                                  color: _controller1!.index == 1
                                      ? greenColorwithopticity40
                                      : AppColors.darkgrey,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(
                                  width * .01,
                                ),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  "assets/icons/documenticon.png",
                                  color: _controller1!.index == 1
                                      ? whiteColor
                                      : whiteColor,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: width * .025,
                                  ),
                                  child: Text(
                                    "Ownership Documents",
                                    style: poppinsRegular.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .033,
                                      color: _controller1!.index == 1
                                          ? whiteColor
                                          : AppColors.darkgrey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// step progress bar
                Container(
                  margin: EdgeInsets.only(
                    left: width * .123,
                    right: width * .123,
                    bottom: height * .014,
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
                          "Step " + currentIndex.toString() + " of 7",
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

                /// steps screen
                Expanded(
                  child: PageView(
                    allowImplicitScrolling: false,
                    controller: _controller,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      isLoading
                          ? Container(
                              margin: EdgeInsets.only(
                                // top: height * .02,
                                bottom: height * .01,
                                left: width * .053,
                                right: width * .053,
                              ),
                              child: RegisterGrantFirst(
                                onTap: () {
                                  _controller.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                  setState(
                                    () {
                                      progress = ((1 / 7) * 100).toInt();
                                      currentIndex = 1;
                                    },
                                  );
                                },
                              ),
                            )
                          : const LoadingProgressWidget(),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .01,
                          left: width * .053,
                          right: width * .053,
                        ),
                        child: RegisterGrantType(onTap: () {
                          _controller.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            progress = ((2 / 7) * 100).toInt();
                            currentIndex = 2;
                          });
                        }),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .01,
                          left: width * .053,
                          right: width * .053,
                        ),
                        child: RegisterGrantEqutity(
                          onTap: () {
                            _controller.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((3 / 7) * 100).toInt();
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
                        child: RegisterShareDate(
                          onTap: () {
                            _controller.animateToPage(
                              4,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((4 / 7) * 100).toInt();
                                currentIndex = 4;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          left: width * .053,
                          bottom: height * .01,
                          right: width * .053,
                        ),
                        child: RegisterGrantRestrication(
                          onTap: () {
                            _controller.animateToPage(
                              5,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((5 / 7) * 100).toInt();
                                currentIndex = 5;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          // top: height * .02,
                          left: width * .053,
                          bottom: height * .01,
                          right: width * .053,
                        ),
                        child: RegisterPersonInfo(
                          onTap: () {
                            _controller.animateToPage(
                              6,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((6 / 7) * 100).toInt();
                                currentIndex = 6;
                                //_controller1!.animateTo(1);
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        child: RegisterUploadDoc(
                          onTap: () {
                            _controller.animateToPage(
                              7,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((7 / 7) * 100).toInt();
                                currentIndex = 7;
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            // top: height * .02,
                            left: width * .053,
                            bottom: height * .01,
                            right: width * .053),
                        child: RegisterUploadScreen(
                          onTap: () {
                            _controller.animateToPage(
                              8,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(
                              () {
                                progress = ((8 / 8) * 100).toInt();
                                currentIndex = 8;
                              },
                            );
                          },
                        ),
                      ),
                      PinSelectionScreen(
                        ontap: () {
                          _controller.animateToPage(
                            9,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            progress = ((8 / 10) * 100).toInt();
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
                            _controller.animateToPage(
                              10,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            setState(() {
                              progress = ((9 / 10) * 100).toInt();
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
                        child: SuccessScreen(
                          ontap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                                (route) => false);
                            setState(() {
                              progress = ((10 / 10) * 100).toInt();
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
