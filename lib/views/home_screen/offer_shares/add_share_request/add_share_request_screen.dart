import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/models/offer_share1_model.dart';
import 'package:bursa_flutter/views/home_screen/offer_shares/offershar_next.dart';
import 'package:bursa_flutter/views/home_screen/offer_shares/add_share_request/bank_details/bank_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../controllers/offer_share_controller.dart';
import 'offering_type/offering_type_screen.dart';
import 'review_details/review_details_screen.dart';
import 'select_issuer/select_issuer_screen.dart';

class AddShareRequestScreen extends StatefulWidget {
  const AddShareRequestScreen({Key? key}) : super(key: key);

  @override
  State<AddShareRequestScreen> createState() => _AddShareRequestScreenState();
}

class _AddShareRequestScreenState extends State<AddShareRequestScreen> {
  int progress = 0;
  int currentIndex = 0;
  PageController controller = PageController();
  OfferShareDetails? offerShare;
  // OfferShareDetails? offerShareDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    OfferShareController offerShareController =
        Provider.of<OfferShareController>(context, listen: false);

    // offerShareController.getCompanyShares().then((value) {
    //   setState(() {
    //     isLoading = false;
    //   });
    // });

    offerShareController.resetAllData();
    offerShareController.getCompanyShareWithOffer();
    // offerShareController.getCompanyShareWithOffer();
    offerShareController.getLimitOffers().then((value) {
      // log("offerShareList ----- " +
      //     offerShareController.offerShareList.toString());
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    OfferShareController _offershareController =
        Provider.of<OfferShareController>(context, listen: true);
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
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
      child: WillPopScope(
        onWillPop: () async {
          if (controller.page == 0) {
            return true;
          } else {
            setState(
              () {
                progress = (((currentIndex - 1) * 4 / 100)).toInt();
                currentIndex = currentIndex - 1;
              },
            );
            controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);
            return false;
          }
        },
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: whiteColor,
              ))
            : (_offershareController.offerShareList != null)
                ? _offershareController.offerShareList!.isEmpty
                    ? const OfferShareNext()
                    : Scaffold(
                        backgroundColor: transparentColor,

                        /// Appbar
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          leadingWidth: 60.0,
                          leading: IconButton(
                            onPressed: () {
                              //Get.offAll(const PersisNavBar());

                              if (controller.page == 0) {
                                Navigator.pop(context);
                              } else {
                                setState(
                                  () {
                                    progress = (((currentIndex - 1) / 4) * 100)
                                        .toInt();
                                    currentIndex = currentIndex - 1;
                                  },
                                );
                                controller.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.ease);
                              }
                            },
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child:
                                  Image.asset('assets/icons/back_button.png'),
                            ),
                          ),
                          centerTitle: true,
                          title: Text(
                            currentIndex == 0
                                ? "Select Issuer"
                                : currentIndex == 1
                                    ? 'Offering Type'
                                    : currentIndex == 2
                                        ? "Bank Details"
                                        : 'Review Details',
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
                                      "Step " +
                                          (currentIndex + 1).toString() +
                                          " of 4",
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
                                    child: SelectIssuerScreen(
                                      onTap: () {
                                        // offerShare = share;
                                        controller.animateToPage(
                                          1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                        setState(
                                          () {
                                            progress =
                                                ((100 / 4 * 1.5)).toInt();
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
                                    child: OfferingTypeScreen(
                                      onTap: () {
                                        // offerShare?.type = offerType;
                                        controller.animateToPage(
                                          2,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                        setState(
                                          () {
                                            progress = ((100 / 4 * 3)).toInt();
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
                                    child: BankDetails(
                                      // offerShareBid: widget.offerShareBid,
                                      onTap: () {
                                        controller.animateToPage(
                                          3,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                        setState(
                                          () {
                                            progress = ((100 / 4 * 4)).toInt();
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
                                    child: ReviewDetailsScreen(
                                      offerShare: offerShare,
                                      // offerShareDetails: offerShareDetails,
                                      onTap: () {
                                        controller.animateToPage(
                                          4,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut,
                                        );
                                        setState(
                                          () {
                                            progress = ((100 / 4 * 4)).toInt();
                                            currentIndex = 4;
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
                      )
                : const OfferShareNext(),
      ),
    );
  }
}
