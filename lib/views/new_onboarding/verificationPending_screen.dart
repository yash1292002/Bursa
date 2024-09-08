import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/new_onboarding/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PendingScreen extends StatefulWidget {
  PendingScreen({Key? key, this.ontap}) : super(key: key);
  VoidCallback? ontap;

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
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
      alignment: Alignment.center,
      // padding: EdgeInsets.only(
      //     left: width * .01, right: width * .01, top: height * .01),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: transparentColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                //Get.offAll(const PersisNavBar());
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     PageTransition(
                //       duration: Duration(milliseconds: 300),
                //       reverseDuration: Duration(milliseconds: 300),
                //       type: PageTransitionType.leftToRight,
                //       child: HomeScreen(),
                //     ),
                //     (route) => false);

                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Image.asset('assets/icons/back_button.png',
                    height: height * .05),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: height * .015,
                    bottom: height * .01,
                    left: width * .04,
                    right: width * .04,
                  ),
                  // height: height * .85,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        width * .03,
                      ),
                    ),
                  ),
                  // padding: EdgeInsets.only(
                  //     top: height * .02,
                  //     bottom: height * .02,
                  //     left: width * .05,
                  //     right: width * .05),
                  // alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: height * .005,
                          left: width * .04,
                          right: width * .04),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right: width * .05, top: height * .005),
                            child: Image.asset(
                              "assets/images/celebrationimage.png",
                              width: width * .25,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: height * .015,
                              // bottom: height * .01,
                            ),
                            child: Text(
                              "Congrats, ${_controller.userDetail!.firstName!} !",
                              style: poppinsRegular.copyWith(
                                fontSize: width * .055,
                                color: lightBlueColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: height * .01,
                              // bottom: height * .01,
                            ),
                            child: Text(
                              "You are identified as",
                              style: poppinsRegular.copyWith(
                                fontSize: width * .035,
                                color: lightBlueColor,
                                fontWeight: FontWeight.w200,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: width * .4,
                                height: height * .04,
                                margin: EdgeInsets.only(
                                  top: height * .010,
                                  bottom: height * .015,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.darkblue1,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(width * .05),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _controller.userDetail!.investorType
                                          .toString() +
                                      " " +
                                      _controller.userDetail!.role.toString(),
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .035,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: width * .35,
                                height: height * .04,
                                margin: EdgeInsets.only(
                                  top: height * .010,
                                  bottom: height * .015,
                                ),
                                decoration: BoxDecoration(
                                  color: _controller
                                              .userDetail!.verificationState ==
                                          "Pending"
                                      ? AppColors.yellowAccentColor
                                      : const Color(0xff01A295),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(width * .05),
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  _controller.userDetail!.verificationState
                                      .toString(),
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .035,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          _controller.userDetail!.verificationState == "Pending"
                              ? Container(
                                  margin: EdgeInsets.only(top: height * .025),
                                  child: Text(
                                    "Your account verification is under process. We will update your profile status via email which typically takes a maximum of two working days to complete. You may also receive a call from us if additional information is required , so please sit back & relax.",
                                    style: poppinsRegular.copyWith(
                                      fontSize: width * .035,
                                      color: greyColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Text(
                                  "Congratulations! Your request to register an investor account on Bursa platform has been approved.",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .033,
                                    color: greyColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                          _controller.userDetail!.verificationState == "Pending"
                              ? Container(
                                  height: height * .22,
                                )
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: height * .02,
                                        left: width * .03,
                                        right: width * .03,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/images/debitcard.png",
                                            width: width * .35,
                                          ),
                                          Image.asset(
                                            "assets/images/vaultcard.png",
                                            width: width * .35,
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        // top: height * .02,
                                        left: width * .03,
                                        right: width * .03,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: height * .01,
                                            ),
                                            width: width * .35,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Your IBAN",
                                              style: poppinsRegular.copyWith(
                                                fontSize: width * .033,
                                                color: lightBlueColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: height * .01,
                                            ),
                                            width: width * .3,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Your Vault ID",
                                              style: poppinsRegular.copyWith(
                                                fontSize: width * .033,
                                                color: lightBlueColor,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        // top: height * .02,
                                        left: width * .03,
                                        right: width * .03,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width * .35,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: lightBlueColor,
                                                width: width * .001,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  width * .008,
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: width * .02,
                                              right: width * .02,
                                              top: height * .005,
                                              bottom: height * .005,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: height * .005,
                                            ),
                                            child: Text(
                                              _controller.userDetail!.ibanNumber
                                                  .toString(),
                                              style: poppinsRegular.copyWith(
                                                fontSize: width * .028,
                                                color: greyColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: width * .3,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: lightBlueColor,
                                                width: width * .001,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(
                                                  width * .008,
                                                ),
                                              ),
                                            ),
                                            padding: EdgeInsets.only(
                                              left: width * .02,
                                              right: width * .02,
                                              top: height * .005,
                                              bottom: height * .005,
                                            ),
                                            margin: EdgeInsets.only(
                                              top: height * .005,
                                            ),
                                            child: Text(
                                              _controller
                                                  .userDetail!.vaultNumber
                                                  .toString(),
                                              style: poppinsRegular.copyWith(
                                                fontSize: width * .028,
                                                color: greyColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      //onTap: widget.ontap,
                                      onTap: () async {
                                        await Share.share(
                                            'Your IBAN number is : \n${_controller.userDetail!.ibanNumber} \n\n'
                                            'Your Vault ID is : \n${_controller.userDetail!.vaultNumber}');
                                      },

                                      child: Container(
                                        height: width * .11,
                                        margin: EdgeInsets.only(
                                          top: height * .026,
                                          bottom: height * .02,
                                        ),
                                        decoration: BoxDecoration(
                                          color: blueColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(width * .02)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Share your IBAN & Vault ID",
                                          style: poppinsRegular.copyWith(
                                            color: whiteColor,
                                            fontSize: width * .036,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          GestureDetector(
                            //onTap: widget.ontap,
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  duration: const Duration(milliseconds: 300),
                                  reverseDuration:
                                      const Duration(milliseconds: 300),
                                  type: PageTransitionType.rightToLeft,
                                  child: const ProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: width * .11,
                              margin: EdgeInsets.only(bottom: height * .02),
                              decoration: BoxDecoration(
                                color: greenColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(width * .02)),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "VIEW PROFILE DATA",
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
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
