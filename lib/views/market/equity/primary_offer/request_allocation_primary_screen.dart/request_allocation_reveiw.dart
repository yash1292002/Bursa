import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/views/market/equity/primary_offer/request_allocation_primary_screen.dart/request_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';

class PrimaryRequestAllocationScreen extends StatefulWidget {
  const PrimaryRequestAllocationScreen(
      {Key? key, required this.primaryOfferDataInfo
      /*required this.offerShareBid*/
      })
      : super(key: key);
  // final OfferShareBid offerShareBid;
  final PrimaryOfferDataInfo primaryOfferDataInfo;
  @override
  State<PrimaryRequestAllocationScreen> createState() =>
      _PrimaryRequestAllocationScreenState();
}

class _PrimaryRequestAllocationScreenState
    extends State<PrimaryRequestAllocationScreen> {
  int progress = ((100 / 1 * 1)).toInt();
  int currentIndex = 0;
  PageController controller = PageController();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState

    // _primaryOfferController.getPrimaryPaymentType();
    // offerShareController.getLimitOffers().then((value) => {
    //       setState(() {
    //         isLoading = false;
    //       })
    //     });
    // offerShareController.resetBidPrice();
    // offerShareController.resetDropdown();
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: false);
    _primaryOfferController.getPrimaryPaymentType().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    _primaryOfferController.resetPrimaryData();
    _primaryOfferController.resetPaymentType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // OfferShareController _offerShareController =
    //     Provider.of<OfferShareController>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
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
            "Request form",
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
                        "Step " + (currentIndex + 1).toString() + " of 1",
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
                      child: isLoading
                          ? Center(child: CircularProgressIndicator())
                          : PrimaryRequestForm(
                              primaryOfferDataInfo: widget.primaryOfferDataInfo,
                              // offerShareBid: widget.offerShareBid,
                              onTap: () {
                                controller.animateToPage(
                                  1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                                setState(
                                  () {
                                    // progress = ((1 / 3) * 100).toInt();
                                    progress = ((100 / 1 * 1)).toInt();

                                    currentIndex = 1;
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
    );
  }
}
