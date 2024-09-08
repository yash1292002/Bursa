import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:share_plus/share_plus.dart';

class ConfirmationPageFive extends StatefulWidget {
  const ConfirmationPageFive({
    Key? key,
    this.privateKey,
  }) : super(key: key);
  final String? privateKey;

  @override
  State<ConfirmationPageFive> createState() => _ConfirmationPageFiveState();
}

class _ConfirmationPageFiveState extends State<ConfirmationPageFive> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              type: PageTransitionType.rightToLeft,
              child: const HomeScreen(),
            ),
            (route) => false);
        return false;
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
        child: SafeArea(
          child: Scaffold(
            backgroundColor: transparentColor,
            body: Container(
              margin: EdgeInsets.only(
                top: width * .008,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: width * .04,
                      ),
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: width * .18,
                      ),
                    ),
                  ),
                  Container(
                    // height: height*.65,
                    width: width,
                    margin: EdgeInsets.only(
                      top: height * .025,
                      left: width * .06,
                      right: width * .06,
                    ),
                    padding: EdgeInsets.only(
                      top: width * .1,
                      bottom: width * .08,
                      left: width * .05,
                      right: width * .05,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          width * .025,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: width * .06,
                          ),
                          child: Image.asset(
                            "assets/images/celebrationimage.png",
                            height: width * .25,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: width * .04,
                          ),
                          child: Text(
                            "Well Done !",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .045,
                              color: darkBlueColor2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: width * .04,
                            left: width * .02,
                            right: width * .02,
                          ),
                          child: Text(
                            "Your request was submitted successfully",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .04,
                              color: darkBlueColor2,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: width * .08,
                            left: width * .02,
                            right: width * .02,
                          ),
                          child: Text(
                            "Your request will be reviewed by our team and you will be notified "
                            "within 48 hours about the status of your request.",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .03,
                              color: greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: width * .08,
                            left: width * .02,
                            right: width * .02,
                          ),
                          child: Text(
                            "Until then, you will be able to view your shares in the dashboard or "
                            "explore investment opportunities.",
                            style: poppinsRegular.copyWith(
                              fontSize: width * .03,
                              color: greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        //private key
                        // const SizedBox(height: 16.0),
                        /* if (widget.privateKey != null) Text(widget.privateKey!),*/

                        SizedBox(height: height * 0.022),
                        if (widget.privateKey != '1')
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: height * 0.045,
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: AppColors.greenLightOneColor,
                                  ),
                                  child: Center(
                                    child: widget.privateKey != null
                                        ? Text(
                                            widget.privateKey!,
                                            style: poppinsRegular.copyWith(
                                              fontSize: height * 0.016,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.greenColor,
                                            ),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              CustomButton(
                                onTap: () async {
                                  await Share.share(
                                      'The Invitation Code is: ${widget.privateKey!}');
                                },
                                btnText: 'Share',
                                btnWidth: height * 0.08,
                                btnHeight: height * 0.045,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  /// register new offer shares button
                  SizedBox(height: height * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: const HomeScreen(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      height: width * .11,
                      margin: EdgeInsets.only(
                        left: width * .055,
                        right: width * .055,
                        top: width * .04,
                      ),
                      decoration: BoxDecoration(
                        color: whiteColor.withOpacity(.1),
                        borderRadius:
                            BorderRadius.all(Radius.circular(width * .02)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Back  to Home",
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
            ),
          ),
        ),
      ),
    );
  }
}
