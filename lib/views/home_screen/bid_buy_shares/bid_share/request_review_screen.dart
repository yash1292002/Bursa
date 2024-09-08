import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import 'components/detail_bid_screen.dart';
import 'components/request_bid_screen.dart';

class RequestReviewScreen extends StatefulWidget {
  const RequestReviewScreen({Key? key}) : super(key: key);

  @override
  State<RequestReviewScreen> createState() => _RequestReviewScreenState();
}

class _RequestReviewScreenState extends State<RequestReviewScreen> {

  int progress = ((1 / 2) * 100).toInt();
  int currentIndex = 0;
  PageController controller = PageController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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

      child: Scaffold(
        backgroundColor: Colors.transparent,

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
            currentIndex == 0
                ? "Request form"
                : "Review Details",
            style: poppinsRegular.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),

        body: Column(
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
                      "Step " + (currentIndex + 1).toString()  + " of 2",
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
                  Container(
                    margin: EdgeInsets.only(
                      bottom: height * .01,
                      left: width * .053,
                      right: width * .053,
                    ),
                    child: RequestBidScreen(
                      onTap: () {
                        controller.animateToPage(
                          1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(
                              () {
                            progress = ((2 / 2) * 100).toInt();
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
                    child: DetailBidScreen(
                      onTap: () {
                        controller.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(
                              () {
                            progress = ((2 / 2) * 100).toInt();
                            currentIndex = 2;
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
    );
  }
}
