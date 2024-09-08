import 'package:bursa_flutter/Services/shared_pref_services.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/market/market_screen.dart';
import 'package:bursa_flutter/views/new_onboarding/verificationPending_screen.dart';
import 'package:bursa_flutter/views/portfolio/portfolio_screen.dart';
import 'package:bursa_flutter/views/welcome_screen.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../consts/app_const.dart';
import '../../consts/app_images.dart';
import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import '../../widgets/small_chip_widget.dart';
import '../market/equity/seconday_offer/components/request_code_dialog.dart';
import '../pricing/bursa_priceing.dart';
import '../register_shares/register_next.dart';
import '../register_shares/register_shar_cupon.dart';
import 'issue_digital_certificate/issue_digital_certificate_screen.dart';
import 'offer_shares/add_share_request/add_share_request_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _register = false;

  void setRegister(bool value) {
    _register = value;
    setState(() {});
  }

  bool _brushaPricing = false;
  int bottomNavBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _controller =
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
        body: bottomNavBarIndex == 0
            ? (_register
                ? RegisterNext()
                : Container(
                    margin: EdgeInsets.only(top: height * .02),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: height * .02,
                                left: width * .19,
                              ),
                              child: Image.asset(
                                "assets/images/logo.png",
                                height: height * .07,
                                width: width * .6,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                SharedPrefService().clearToken();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomeScreen(),
                                    ),
                                    (route) => false);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: height * .055,
                                  right: width * .02,
                                ),
                                child:
                                    // Image.asset(
                                    //   "assets/icons/notification.png",
                                    //   height: height * .064,
                                    //   width: width * .064,
                                    // ),
                                    Icon(
                                  Icons.logout,
                                  size: width * .064,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    type: PageTransitionType.rightToLeft,
                                    child: PendingScreen(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: height * .04),
                                child: Image.asset(
                                  "assets/icons/profile.png",
                                  height: height * .064,
                                  width: width * .064,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: width * .04,
                                    right: width * .04,
                                    top: height * .015,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome ${_controller.userDetail?.firstName?.toString()}',
                                          style: poppinsRegular.copyWith(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                /// on boarding step
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: height * .070,
                                                  ),
                                                  height: height * .05,
                                                  width: width * .1,
                                                  decoration: BoxDecoration(
                                                    color: white1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      width * .09,
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                      "assets/icons/onboarding1.png"),
                                                ),

                                                /// dotted line
                                                DottedLine(
                                                  dashColor: white1,
                                                  direction: Axis.vertical,
                                                  lineLength: width * 0.3,
                                                  dashLength: width * .018,
                                                  lineThickness: width * .006,
                                                  dashGapRadius: 0.0,
                                                ),

                                                /// register step
                                                Container(
                                                  height: height * .05,
                                                  width: width * .1,
                                                  decoration: BoxDecoration(
                                                    color: white1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      width * .09,
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                      "assets/icons/register_shar.png"),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 14.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  /// onBaoding Box
                                                  GestureDetector(
                                                    onTap: () {
                                                      _controller.userDetail!
                                                                  .verificationState ==
                                                              "Pending"
                                                          ? showDialog(
                                                              context: context,
                                                              barrierColor:
                                                                  darkGreyColorWithOpacity80,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(width *
                                                                              .02))),
                                                                  content: StatefulBuilder(
                                                                      builder:
                                                                          (context,
                                                                              setState) {
                                                                    return Container(
                                                                      height:
                                                                          height *
                                                                              .5,
                                                                      width:
                                                                          width *
                                                                              .7,
                                                                      margin: EdgeInsets
                                                                          .only(
                                                                        top: width *
                                                                            .01,
                                                                        bottom: width *
                                                                            .03,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            "assets/icons/failed.png",
                                                                            height:
                                                                                height * .14,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: height * .02),
                                                                            child:
                                                                                Text(
                                                                              "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                                              textAlign: TextAlign.center,
                                                                              style: poppinsRegular.copyWith(color: lightBlueColor, fontWeight: FontWeight.bold, fontSize: width * .037),
                                                                            ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: EdgeInsets.only(top: height * .04),
                                                                              height: height * .055,
                                                                              width: width * .7,
                                                                              decoration: BoxDecoration(color: greenColor1, borderRadius: BorderRadius.circular(8)),
                                                                              child: Column(
                                                                                children: [
                                                                                  Container(
                                                                                    margin: EdgeInsets.only(top: width * .02),
                                                                                    child: Text(
                                                                                      "Back",
                                                                                      textAlign: TextAlign.center,
                                                                                      style: poppinsRegular.copyWith(color: whiteColor, fontSize: width * .045, fontWeight: FontWeight.w600),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }),
                                                                );
                                                              })
                                                          : null;
                                                    },
                                                    child: Container(
                                                      width: width,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 16.0,
                                                        vertical: 20.0,
                                                      ),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 16.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color: AppColors
                                                            .whiteColor,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Onboarding',
                                                                style:
                                                                    poppinsRegular
                                                                        .copyWith(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: AppColors
                                                                      .lightBlueColor,
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              SmallChip(
                                                                onTap: () {},
                                                                chipText: _controller
                                                                        .userDetail!
                                                                        .investorType
                                                                        .toString() +
                                                                    " " +
                                                                    _controller
                                                                        .userDetail!
                                                                        .role
                                                                        .toString(),
                                                                chipColor:
                                                                    AppColors
                                                                        .darkblue1,
                                                              ),
                                                              const SizedBox(
                                                                  width: 3.0),
                                                              SmallChip(
                                                                  onTap: () {},
                                                                  chipText: _controller
                                                                      .userDetail!
                                                                      .verificationState
                                                                      .toString(),
                                                                  chipColor: _controller
                                                                              .userDetail!
                                                                              .verificationState ==
                                                                          "Pending"
                                                                      ? AppColors
                                                                          .yellowAccentColor
                                                                      : AppColors
                                                                          .greenColor),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height: height *
                                                                  0.02),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right:
                                                                        20.0),
                                                            child: Text(
                                                              'Thank you for joining the MENA’s first '
                                                              'regulated private markets investment '
                                                              'marketplace !',
                                                              style:
                                                                  poppinsRegular
                                                                      .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 12.0,
                                                                color: AppColors
                                                                    .greyColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.026),

                                                  /// minimum investment and free Box
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _controller.userDetail!
                                                                        .verificationState ==
                                                                    "Pending"
                                                                ? showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierColor:
                                                                        darkGreyColorWithOpacity80,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(width * .02))),
                                                                        content:
                                                                            StatefulBuilder(builder:
                                                                                (context, setState) {
                                                                          return Container(
                                                                            height:
                                                                                height * .5,
                                                                            width:
                                                                                width * .7,
                                                                            margin:
                                                                                EdgeInsets.only(
                                                                              top: width * .01,
                                                                              bottom: width * .03,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Image.asset(
                                                                                  "assets/icons/failed.png",
                                                                                  height: height * .14,
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: height * .02),
                                                                                  child: Text(
                                                                                    "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: poppinsRegular.copyWith(color: lightBlueColor, fontWeight: FontWeight.bold, fontSize: width * .037),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(top: height * .04),
                                                                                    height: height * .055,
                                                                                    width: width * .7,
                                                                                    decoration: BoxDecoration(color: greenColor1, borderRadius: BorderRadius.circular(8)),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: EdgeInsets.only(top: width * .02),
                                                                                          child: Text(
                                                                                            "Back",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: poppinsRegular.copyWith(color: whiteColor, fontSize: width * .045, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                                      );
                                                                    })
                                                                : Navigator.push(
                                                                    context,
                                                                    PageTransition(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                      reverseDuration:
                                                                          const Duration(
                                                                              milliseconds: 300),
                                                                      type: PageTransitionType
                                                                          .rightToLeft,
                                                                      child:
                                                                          const MarketScreen(),
                                                                    ));
                                                          },
                                                          child: Container(
                                                            height:
                                                                height * 0.25,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0,
                                                                    bottom:
                                                                        10.0,
                                                                    right: 5.0,
                                                                    left: 12.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    AppImages
                                                                        .minimumInvestIcon),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.005),
                                                                Text(
                                                                  'Minimum Investment starting from \$ 5,000',
                                                                  style: poppinsRegular
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .greenColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.005),
                                                                Expanded(
                                                                  child: Text(
                                                                    'Invest in funds or direct deals',
                                                                    style: poppinsRegular
                                                                        .copyWith(
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: AppColors
                                                                          .darkBlueColor2,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 12.0),
                                                      Expanded(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _controller.userDetail!
                                                                        .verificationState ==
                                                                    "Pending"
                                                                ? showDialog(
                                                                    context:
                                                                        context,
                                                                    barrierColor:
                                                                        darkGreyColorWithOpacity80,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return AlertDialog(
                                                                        shape: RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(width * .02))),
                                                                        content:
                                                                            StatefulBuilder(builder:
                                                                                (context, setState) {
                                                                          return Container(
                                                                            height:
                                                                                height * .5,
                                                                            width:
                                                                                width * .7,
                                                                            margin:
                                                                                EdgeInsets.only(
                                                                              top: width * .01,
                                                                              bottom: width * .03,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Image.asset(
                                                                                  "assets/icons/failed.png",
                                                                                  height: height * .14,
                                                                                ),
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: height * .02),
                                                                                  child: Text(
                                                                                    "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: poppinsRegular.copyWith(color: lightBlueColor, fontWeight: FontWeight.bold, fontSize: width * .037),
                                                                                  ),
                                                                                ),
                                                                                GestureDetector(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Container(
                                                                                    margin: EdgeInsets.only(top: height * .04),
                                                                                    height: height * .055,
                                                                                    width: width * .7,
                                                                                    decoration: BoxDecoration(color: greenColor1, borderRadius: BorderRadius.circular(8)),
                                                                                    child: Column(
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: EdgeInsets.only(top: width * .02),
                                                                                          child: Text(
                                                                                            "Back",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: poppinsRegular.copyWith(color: whiteColor, fontSize: width * .045, fontWeight: FontWeight.w600),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        }),
                                                                      );
                                                                    })
                                                                : Navigator
                                                                    .push(
                                                                    context,
                                                                    PageTransition(
                                                                      duration: const Duration(
                                                                          milliseconds:
                                                                              300),
                                                                      reverseDuration:
                                                                          const Duration(
                                                                              milliseconds: 300),
                                                                      type: PageTransitionType
                                                                          .rightToLeft,
                                                                      child:
                                                                          const RegisterSharInfo(),
                                                                    ),
                                                                  );
                                                          },
                                                          child: Container(
                                                            height:
                                                                height * 0.25,
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0,
                                                                    bottom:
                                                                        10.0,
                                                                    right: 5.0,
                                                                    left: 12.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: AppColors
                                                                  .whiteColor,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    AppImages
                                                                        .registerCompanyIcon),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.02),
                                                                Text(
                                                                  'Free',
                                                                  style: poppinsRegular
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .greenColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        height *
                                                                            0.01),
                                                                Text(
                                                                  'Register your private company shares',
                                                                  style: poppinsRegular
                                                                      .copyWith(
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: AppColors
                                                                        .darkBlueColor2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * .02),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: width * .04),
                                    child: Text(
                                      "Other Services",
                                      style: poppinsRegular.copyWith(
                                        color: white1,
                                        fontSize: width * .043,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * .18,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.only(
                                        left: width * .04, top: height * .016),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: index == 0
                                            ? () {
                                                _controller.userDetail!
                                                            .verificationState ==
                                                        "Pending"
                                                    ? showDialog(
                                                        context: context,
                                                        barrierColor:
                                                            darkGreyColorWithOpacity80,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.all(
                                                                    Radius.circular(
                                                                        width *
                                                                            .02))),
                                                            content: StatefulBuilder(
                                                                builder: (context,
                                                                    setState) {
                                                              return Container(
                                                                height:
                                                                    height * .5,
                                                                width:
                                                                    width * .7,
                                                                margin:
                                                                    EdgeInsets
                                                                        .only(
                                                                  top: width *
                                                                      .01,
                                                                  bottom:
                                                                      width *
                                                                          .03,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Image.asset(
                                                                      "assets/icons/failed.png",
                                                                      height:
                                                                          height *
                                                                              .14,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          top: height *
                                                                              .02),
                                                                      child:
                                                                          Text(
                                                                        "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: poppinsRegular.copyWith(
                                                                            color:
                                                                                lightBlueColor,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: width * .037),
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                height * .04),
                                                                        height: height *
                                                                            .055,
                                                                        width: width *
                                                                            .7,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                greenColor1,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8)),
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.only(top: width * .02),
                                                                              child: Text(
                                                                                "Back",
                                                                                textAlign: TextAlign.center,
                                                                                style: poppinsRegular.copyWith(color: whiteColor, fontSize: width * .045, fontWeight: FontWeight.w600),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          );
                                                        })
                                                    : Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          reverseDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft,
                                                          child:
                                                              const IssueDigitalCertificateScreen(),
                                                        ),
                                                      );
                                              }
                                            : () {
                                                index == 1
                                                    ? _controller.userDetail!
                                                                .verificationState ==
                                                            "Pending"
                                                        ? showDialog(
                                                            context: context,
                                                            barrierColor:
                                                                darkGreyColorWithOpacity80,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(Radius.circular(width *
                                                                            .02))),
                                                                content: StatefulBuilder(
                                                                    builder:
                                                                        (context,
                                                                            setState) {
                                                                  return Container(
                                                                    height:
                                                                        height *
                                                                            .5,
                                                                    width:
                                                                        width *
                                                                            .7,
                                                                    margin:
                                                                        EdgeInsets
                                                                            .only(
                                                                      top: width *
                                                                          .01,
                                                                      bottom:
                                                                          width *
                                                                              .03,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          "assets/icons/failed.png",
                                                                          height:
                                                                              height * .14,
                                                                        ),
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.only(top: height * .02),
                                                                          child:
                                                                              Text(
                                                                            "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: poppinsRegular.copyWith(
                                                                                color: lightBlueColor,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: width * .037),
                                                                          ),
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: height * .04),
                                                                            height:
                                                                                height * .055,
                                                                            width:
                                                                                width * .7,
                                                                            decoration:
                                                                                BoxDecoration(color: greenColor1, borderRadius: BorderRadius.circular(8)),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  margin: EdgeInsets.only(top: width * .02),
                                                                                  child: Text(
                                                                                    "Back",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: poppinsRegular.copyWith(color: whiteColor, fontSize: width * .045, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                }),
                                                              );
                                                            })
                                                        : Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              duration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              reverseDuration:
                                                                  const Duration(
                                                                      milliseconds:
                                                                          300),
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              child:
                                                                  const AddShareRequestScreen(),
                                                            ),
                                                          )
                                                    : Navigator.push(
                                                        context,
                                                        PageTransition(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          reverseDuration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      300),
                                                          type:
                                                              PageTransitionType
                                                                  .rightToLeft,
                                                          child:
                                                              const BurshaPricing(),
                                                        ),
                                                      );
                                              },
                                        child: Container(
                                          width: width * .32,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      width * .03),
                                              color: whiteColor),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: height * .015,
                                                    left: width * .04),
                                                child: Image.asset(
                                                  otherService[index]['image'],
                                                  color: index == 4
                                                      ? greenColor
                                                      : null,
                                                  height: height * .075,
                                                  width: width * .12,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: width * .04,
                                                    top: height * .01),
                                                child: Text(
                                                  otherService[index]['title'],
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: blackColor,
                                                          fontSize:
                                                              width * .035,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return Container(
                                        width: width * .024,
                                      );
                                    },
                                    itemCount: otherService.length,
                                  ),
                                ),
                                SizedBox(height: height * 0.024),
                                GestureDetector(
                                  onTap: () {
                                    _controller.userDetail!.verificationState ==
                                            "Pending"
                                        ? showDialog(
                                            context: context,
                                            barrierColor:
                                                darkGreyColorWithOpacity80,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                width * .02))),
                                                content: StatefulBuilder(
                                                    builder:
                                                        (context, setState) {
                                                  return Container(
                                                    height: height * .5,
                                                    width: width * .7,
                                                    margin: EdgeInsets.only(
                                                      top: width * .01,
                                                      bottom: width * .03,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Image.asset(
                                                          "assets/icons/failed.png",
                                                          height: height * .14,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: height *
                                                                      .02),
                                                          child: Text(
                                                            "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: poppinsRegular.copyWith(
                                                                color:
                                                                    lightBlueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    width *
                                                                        .037),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: height *
                                                                        .04),
                                                            height:
                                                                height * .055,
                                                            width: width * .7,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    greenColor1,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: width *
                                                                          .02),
                                                                  child: Text(
                                                                    "Back",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: poppinsRegular.copyWith(
                                                                        color:
                                                                            whiteColor,
                                                                        fontSize:
                                                                            width *
                                                                                .045,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              );
                                            })
                                        : Get.dialog(
                                            const RequestCodeDialog(),
                                          );
                                  },
                                  child: Container(
                                    width: width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(10.0),
                                      color: AppColors.blackOneColor
                                          .withOpacity(0.4),
                                    ),
                                    child: Text(
                                      'Got the invitation code ? '
                                      '\nEnter your  invitation  code to invest in specific opportunity',
                                      textAlign: TextAlign.center,
                                      style: poppinsRegular.copyWith(
                                        color: AppColors.whiteColor,
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height * 0.04),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            : bottomNavBarIndex == 1
                ? const MarketScreen()
                : bottomNavBarIndex == 2
                    ? const Center(
                        child: Text(
                          "Insight",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const PortfolioScreen(),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(width * .04),
                topLeft: Radius.circular(width * .04)),
          ),
          padding: EdgeInsets.only(
            top: width * .02,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(width * .04),
              topRight: Radius.circular(width * .04),
            ),
            child: BottomNavigationBar(
              elevation: 0,
              currentIndex: bottomNavBarIndex,
              onTap: (index) {
                if (index == 0) {
                  _brushaPricing = false;
                  _register = false;
                  setState(() {
                    bottomNavBarIndex = index;
                  });
                } else {
                  _controller.userDetail!.verificationState == "Pending"
                      ? showDialog(
                          context: context,
                          barrierColor: darkGreyColorWithOpacity80,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(width * .02))),
                              content:
                                  StatefulBuilder(builder: (context, setState) {
                                return Container(
                                  height: height * .5,
                                  width: width * .7,
                                  margin: EdgeInsets.only(
                                    top: width * .01,
                                    bottom: width * .03,
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        "assets/icons/failed.png",
                                        height: height * .14,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: height * .02),
                                        child: Text(
                                          "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                          textAlign: TextAlign.center,
                                          style: poppinsRegular.copyWith(
                                              color: lightBlueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: width * .037),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: height * .04),
                                          height: height * .055,
                                          width: width * .7,
                                          decoration: BoxDecoration(
                                              color: greenColor1,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: width * .02),
                                                child: Text(
                                                  "Back",
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: whiteColor,
                                                          fontSize:
                                                              width * .045,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            );
                          })
                      : setState(() {
                          bottomNavBarIndex = index;
                        });
                }
              },
              selectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              items: List.generate(navItems.length, (index) {
                return BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(
                      top: width * .03,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          navItems[index]["icon"],
                          width: width * .06,
                          height: width * .06,
                          color: bottomNavBarIndex == index
                              ? greenColor
                              : greyColor,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: width * .02,
                          ),
                          child: Text(
                            navItems[index]["title"],
                            style: poppinsRegular.copyWith(
                              fontSize: width * .03,
                              fontWeight: FontWeight.bold,
                              color: bottomNavBarIndex == index
                                  ? greenColor
                                  : greyColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  label: "",
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
