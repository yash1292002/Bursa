import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/custom_swiper/card_swiper.dart';
import 'package:bursa_flutter/views/auth/authenticaion_dashboard.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectedIndex = 0;
  bool isSkipped = false;
  final SwiperController _swiperController = SwiperController();
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
          child: Center(
            child: Column(
              children: [
                Image.asset("assets/images/logo.png", width: width * 0.5),
                Container(
                  height: height * .7,
                  margin: EdgeInsets.only(
                    top: height * .04,
                    left: width * .02,
                    right: width * .02,
                  ),
                  child: Swiper(
                    controller: _swiperController,
                    itemWidth: width * .8,
                    axisDirection: AxisDirection.right,
                    onIndexChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    index: selectedIndex,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: height * .6,
                        width: width,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .04,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: height * .02,
                          bottom: height * .02,
                          left: width * .04,
                          right: width * .04,
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              onboardingData[index]["image"],
                              height: height * .3,
                              width: width,
                            ),
                            Container(
                              // color: Colors.black,
                              margin: EdgeInsets.only(
                                top: height * .08,
                                bottom: height * .02,
                              ),
                              child: Text(
                                onboardingData[index]["title"],
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .038,
                                  color: lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              onboardingData[index]["description"],
                              style: poppinsRegular.copyWith(
                                fontSize: width * .035,
                                color: greyColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    loop: false,
                    itemCount: onboardingData.length,
                    layout: SwiperLayout.STACK,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .04,
                    left: width * .08,
                    right: width * .08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: selectedIndex == onboardingData.length - 1
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthenticationDashBoardScreen(),
                                ));
                              }
                            : () {
                                setState(() {
                                  selectedIndex = onboardingData.length - 1;
                                });
                                _swiperController
                                    .move(onboardingData.length - 1);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthenticationDashBoardScreen(),
                                ));
                              },
                        child: Text("Skip",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .037,
                              color: whiteColor,
                              letterSpacing: 0.1,
                            )),
                      ),
                      Row(
                        children: List.generate(onboardingData.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index <= selectedIndex
                                  ? whiteColor
                                  : lightGreyColorWithOpacity50,
                            ),
                            margin: EdgeInsets.only(
                                left: width * .02, right: width * .02),
                            height: width * .013,
                            width: width * .013,
                          );
                        }),
                      ),
                      GestureDetector(
                        onTap: selectedIndex == onboardingData.length - 1
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AuthenticationDashBoardScreen(),
                                ));
                              }
                            : () {
                                // setState(() {
                                //   selectedIndex = selectedIndex + 1;
                                // });
                                _swiperController.previous();
                              },
                        child: Text("Next",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .037,
                              color: whiteColor,
                              letterSpacing: 0.1,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
