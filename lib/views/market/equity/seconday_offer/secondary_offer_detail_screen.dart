import 'dart:developer';

import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/views/market/equity/seconday_offer/request_allocation_review_detail/request_allocation_review_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/textstyle_const.dart';

class SecondaryOfferDetailScreen extends StatefulWidget {
  const SecondaryOfferDetailScreen({Key? key, required this.offerShareBid})
      : super(key: key);
  final OfferShareBid offerShareBid;

  @override
  State<SecondaryOfferDetailScreen> createState() =>
      _SecondaryOfferDetailScreenState();
}

class _SecondaryOfferDetailScreenState extends State<SecondaryOfferDetailScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  bool isLoading = true;

  int selectedIndex = 0;

  @override
  void initState() {
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: false);
    log("print id =================" + widget.offerShareBid.id.toString());

    _offerShareController.GetSecoundaryOffer(widget.offerShareBid.id)
        .then((value) {
      log("_offerShareController.categoryInfoData!.length -----  " +
          _offerShareController.categoryInfoData!.length.toString());
      _tabController = TabController(
          length: _offerShareController.categoryInfoData!.length, vsync: this);
      setState(() {
        _offerShareController.setSelectedCategoryInfoData(
            _offerShareController.categoryInfoData![0]);

        isLoading = false;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  // WebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: true);
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
        backgroundColor: Colors.transparent,

        /// appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
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
          title: Text(
            'Details',
            style: poppinsRegular.copyWith(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),

        /// body
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// dubizzle box
                  SizedBox(height: height * 0.01),
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.whiteColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 25,
                            height: 25,
                            child: Image.network(widget.offerShareBid.logo,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(AppImages.blankImg);
                            })),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.offerShareBid.companyName,
                                style: poppinsRegular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                  color: AppColors.lightBlueColor,
                                ),
                              ),
                              offerRow('Offer Price :',
                                  ' \$${widget.offerShareBid.offerPrice}'),
                              offerRow('Total Offer Shares :',
                                  ' ${widget.offerShareBid.quantity}'),
                              // offerRow('Share Class :', ' Serie C'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// tabs
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 38.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColors.whiteColor.withOpacity(0.1),
                      ),
                      child: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: AppColors.whiteColor,
                        ),
                        onTap: (index) {
                          // _offerShareController.setSelectedCategoryInfoData(
                          //     _offerShareController.categoryInfoData![index]);

                          // log("dat---->" + index.toString());
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        tabs: List.generate(
                            _offerShareController.categoryInfoData!.length,
                            (index) => Container(
                                  height: 50,
                                  child: Center(
                                    child: Tab(
                                      text: _offerShareController
                                          .categoryInfoData![index].title
                                          .toString(),
                                      // style: poppinsRegular.copyWith(
                                      //   fontWeight: FontWeight.w500,
                                      //   fontSize: 16.0,
                                      //   color: AppColors.lightBlueColor,
                                      // ),
                                    ),
                                  ),
                                  // child: Text(_offerShareController
                                  //     .categoryInfoData![index].name
                                  //     .toString()),
                                )),
                        labelColor: AppColors.greenColor,
                        labelStyle: poppinsRegular.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                        unselectedLabelColor: AppColors.whiteColor,
                        unselectedLabelStyle: poppinsRegular.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),

                  /// details box
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                          _offerShareController.categoryInfoData!.length,
                          (index) {
                        return Container(
                          // height: height * .04,
                          // width: width,
                          margin: EdgeInsets.only(
                            top: height * .02,
                            bottom: height * .13,
                            left: width * .05,
                            right: width * .05,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: SingleChildScrollView(
                            child: Container(
                              margin: EdgeInsets.only(
                                top: height * .02,
                                bottom: height * .095,
                                left: width * .05,
                                right: width * .05,
                              ),
                              child: _offerShareController
                                      .categoryInfoData![selectedIndex]
                                      .content!
                                      .isEmpty
                                  ? Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("No Data Found"),
                                        ],
                                      ),
                                    )
                                  : HtmlWidget(
                                      '''
                                  ${_offerShareController.categoryInfoData![index].content.toString()}
                                ''',
                                      webView: true,
                                    ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),

        floatingActionButton: Container(
          // margin: EdgeInsets.only(top: height * .02),
          height: height * 0.06,
          width: width * .92,
          child: CustomButton(
            onTap: () {
              // Get.to(const RegisterCertificateScreen());
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.rightToLeft,
                  child: RequestAllocationReviewScreen(
                      offerShareBid: widget.offerShareBid),
                ),
              );
            },
            btnColor: AppColors.whiteColor.withOpacity(0.1),
            borderColor: AppColors.whiteColor.withOpacity(0.1),
            btnText: 'Request Allocation',
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
        ),
      ),
    );
  }

  // _loadHtmlFromAssets() async {
  //   OfferShareController _offerShareController =
  //       Provider.of<OfferShareController>(context, listen: true);
  //   String fileText = await rootBundle.loadString('assets/html/index.html');
  //   _webViewController!.loadUrl(Uri.dataFromString(fileText,
  //           mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
  //       .toString());
  // }

  Widget offerRow(mainText, descText) => Padding(
        padding: const EdgeInsets.only(top: 7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              mainText,
              style: poppinsRegular.copyWith(
                color: AppColors.lightBlueColor,
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              descText,
              style: poppinsRegular.copyWith(
                color: AppColors.greyColor2,
                fontSize: 11.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
}
