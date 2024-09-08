import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../consts/app_images.dart';
import '../../../../../consts/color_const.dart';
import '../../../../home_screen/home_screen.dart';

class ThanksSubmitRequestScreen extends StatefulWidget {
  const ThanksSubmitRequestScreen({Key? key}) : super(key: key);

  @override
  State<ThanksSubmitRequestScreen> createState() =>
      _ThanksSubmitRequestScreenState();
}

class _ThanksSubmitRequestScreenState extends State<ThanksSubmitRequestScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
        height: height,
        width: width,
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
        child: SafeArea(
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: transparentColor,

                /// appbar
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      //Get.offAll(const PersisNavBar());
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
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 6.0),
                      child: Image.asset('assets/icons/back_button.png'),
                    ),
                  ),
                ),

                /// body
                body: Column(
                  children: [
                    /// congrats box
                    SizedBox(height: height * 0.1),
                    Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      padding:
                          EdgeInsets.fromLTRB(40.0, height * 0.06, 40.0, 0.0),
                      decoration: BoxDecoration(
                        color: AppColors.white1,
                        borderRadius: BorderRadius.circular(11.0),
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

                          /// congrats texts
                          Container(
                            margin: EdgeInsets.only(
                              top: width * .04,
                              left: width * .02,
                              right: width * .02,
                            ),
                            child: Text(
                              "Your request was submitted successfully.",
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
                              "Your request will be reviewed by our team and you will be notified within 48hrs about the status of your request.",
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
                              bottom: width * .08,
                            ),
                            child: Text(
                              "Until then, you will be able to view your shares in the dashboard or explore investment opportunities",
                              style: poppinsRegular.copyWith(
                                fontSize: width * .03,
                                color: greyColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// View my Request button
                    // SizedBox(height: height * 0.096),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    //   child: CustomButton(
                    //     onTap: (){},
                    //     btnText: 'View my Request',
                    //     btnColor: AppColors.whiteColor.withOpacity(0.1),
                    //     borderColor: AppColors.whiteColor.withOpacity(0.1),
                    //   ),
                    // ),

                    /// Back  to Home Screen button
                    SizedBox(height: height * 0.03),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: const HomeScreen(),
                            ),
                            (route) => false);
                      },
                      child: Text(
                        'Back  to Home Screen',
                        style: poppinsRegular.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child:
                        Image.asset(AppImages.logoImage, height: height * 0.08),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
