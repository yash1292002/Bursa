import 'package:flutter/material.dart';

import '../../consts/app_const.dart';
import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import '../../custom_swiper/card_swiper.dart';

class BurshaPricing extends StatefulWidget {
  const BurshaPricing({Key? key}) : super(key: key);

  @override
  State<BurshaPricing> createState() => _BurshaPricingState();
}

class _BurshaPricingState extends State<BurshaPricing> {
  bool _brushaPricing = false;

  int selectedIndex = 0;
  bool isSkipped = false;
  final SwiperController _swiperController = SwiperController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
                Container(
                    margin:
                        EdgeInsets.only(top: height * .015, left: width * .04),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                          margin: EdgeInsets.only(left: width * .11),
                          child: Text(
                            "Transparant pricing",
                            style: poppinsRegular.copyWith(
                                color: white1,
                                fontWeight: FontWeight.w500,
                                fontSize: width * .048,
                                letterSpacing: .05),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.only(left: width * .03),
                  child: Text(
                    "Built based on your needs and feedback.",
                    style: poppinsRegular.copyWith(
                      color: white1,
                      fontWeight: FontWeight.w500,
                      fontSize: width * .029,
                    ),
                  ),
                ),
                Container(
                  height: height * .7,
                  margin: EdgeInsets.only(
                    top: height * .05,
                    left: width * .00,
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
                        height: height * .7,
                        width: width,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .02,
                            ),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          // top: height * .02,
                          bottom: height * .02,
                          // left: width * .04,
                          // right: width * .04,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: height * .09,
                                  decoration: BoxDecoration(
                                    color: index == 0
                                        ? greenColor
                                        : index == 1
                                            ? darkblue
                                            : lightBlueColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(width * .02),
                                      topRight: Radius.circular(
                                        width * .02,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: width * .04),
                                        height: height * .06,
                                        width: width * .12,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              width * .09),
                                          color: index == 0
                                              ? whiteColor.withOpacity(.25)
                                              : index == 1
                                                  ? lightBluewithOpticity34
                                                  : greyColor,
                                        ),
                                        child: Image.asset(
                                          register_header[index]["image"],
                                          height: height * .2,
                                          width: width * .04,
                                          color: whiteColor,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  top: width * .03,
                                                  left: width * .022),
                                              child: Text(
                                                register_header[index]["title"],
                                                style: poppinsRegular.copyWith(
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1,
                                                    fontSize: width * .042),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: width * .02),
                                            child: Text(
                                              register_header[index]
                                                  ["sub_title"],
                                              style: poppinsRegular.copyWith(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: width * .032),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: width * .18),
                                        child: Row(
                                          children: [
                                            Text(
                                              register_header[index]["price"],
                                              style: poppinsRegular.copyWith(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: width * .06),
                                            ),
                                            Text(
                                              " /mo",
                                              style: poppinsRegular.copyWith(
                                                  color: white1,
                                                  fontSize: width * .04,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: width * .03, left: width * .06),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Application Fees",
                                        style: poppinsRegular.copyWith(
                                            color: darkBlueColor,
                                            fontWeight: FontWeight.w900,
                                            fontSize: width * .035),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: width * .03),
                                        child: Row(
                                          children: [
                                            Text(
                                              "●",
                                              style: poppinsRegular.copyWith(
                                                  color: darkBlueColor,
                                                  fontSize: width * .025),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: width * .02),
                                                child: Text(
                                                  register_header[index]
                                                      ["sub_fees"],
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: greyColor,
                                                          fontSize:
                                                              width * .032,
                                                          letterSpacing: .35,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                          ],
                                        ),
                                      ),
                                      //Secound row
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: width * .01),
                                        child: Row(
                                          children: [
                                            Text(
                                              "●",
                                              style: poppinsRegular.copyWith(
                                                  color: darkBlueColor,
                                                  fontSize: width * .025),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: width * .02),
                                                child: Text(
                                                  register_header[index]
                                                      ["sub_fees1"],
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: greyColor,
                                                          fontSize:
                                                              width * .032,
                                                          letterSpacing: .35,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                          ],
                                        ),
                                      ),
                                      //thired row
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: width * .01,
                                            bottom: width * .025),
                                        child: Row(
                                          children: [
                                            Text(
                                              "●",
                                              style: poppinsRegular.copyWith(
                                                  color: darkBlueColor,
                                                  fontSize: width * .025),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    left: width * .02),
                                                child: Text(
                                                  register_header[index]
                                                      ["sub_fees2"],
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: greyColor,
                                                          fontSize:
                                                              width * .032,
                                                          letterSpacing: .35,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                )),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: greyColor,
                                        endIndent: width * .06,
                                        thickness: 1,
                                        indent: width * .01,
                                      ),

                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Text(
                                          "Features",
                                          style: poppinsRegular.copyWith(
                                              color: darkBlueColor,
                                              fontWeight: FontWeight.w900,
                                              fontSize: width * .035),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greenColor
                                                  : index == 1
                                                      ? greenColor
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greenColor
                                                  : index == 1
                                                      ? greenColor
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features1"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greenColor
                                                  : index == 1
                                                      ? greenColor
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features2"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greyColor.withOpacity(.2)
                                                  : index == 1
                                                      ? greenColor
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  left: width * .01,
                                                ),
                                                child: Text(
                                                  register_header[index]
                                                      ["features3"],
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: greyColor,
                                                          fontSize:
                                                              width * .032,
                                                          // letterSpacing: .35,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greyColor.withOpacity(.2)
                                                  : index == 1
                                                      ? greyColor
                                                          .withOpacity(.2)
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features4"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greyColor.withOpacity(.2)
                                                  : index == 1
                                                      ? greyColor
                                                          .withOpacity(.2)
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features5"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: width * .02),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              color: index == 0
                                                  ? greyColor.withOpacity(.2)
                                                  : index == 1
                                                      ? greyColor
                                                          .withOpacity(.2)
                                                      : greenColor,
                                              size: width * .05,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                left: width * .01,
                                              ),
                                              child: Text(
                                                register_header[index]
                                                    ["features6"],
                                                style: poppinsRegular.copyWith(
                                                    color: greyColor,
                                                    fontSize: width * .032,
                                                    letterSpacing: .35,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: height * .05,
                              width: width * .8,
                              margin: EdgeInsets.only(
                                  top: width * .045,
                                  left: width * .06,
                                  right: width * .06),
                              decoration: BoxDecoration(
                                  color: greenColor,
                                  borderRadius:
                                      BorderRadius.circular(width * .02)),
                              child: Center(
                                child: Text(
                                  "Choose Plan",
                                  style: poppinsRegular.copyWith(
                                      color: whiteColor,
                                      fontSize: width * .04,
                                      letterSpacing: 1),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    // loop: false,
                    itemCount: register_header.length,
                    layout: SwiperLayout.STACK,
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
