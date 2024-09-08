import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/BidAllShare_model.dart';
import 'package:bursa_flutter/models/getAllBid_offerShare.dart';
import 'package:bursa_flutter/views/home_screen/offer_shares/primary_share_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import '../../controllers/offer_share_controller.dart';
import '../../widgets/small_chip_widget.dart';
import '../home_screen/issue_digital_certificate/components/card_texts_widget.dart';
import '../home_screen/offer_shares/share_request_detail.dart';
import '../market/components/tab_button.dart';

class MyTransactionScreen extends StatefulWidget {
  const MyTransactionScreen({Key? key}) : super(key: key);

  @override
  State<MyTransactionScreen> createState() => _MyTransactionScreenState();
}

class _MyTransactionScreenState extends State<MyTransactionScreen> {
  bool? isEquity = true;
  bool? isDebt = false;
  bool? isFunds = false;

  void isEquityActive() {
    setState(() {
      isEquity = true;
      isDebt = false;
      isFunds = false;
    });
  }

  void isDebtActive() {
    setState(() {
      isEquity = false;
      isDebt = true;
      isFunds = false;
    });
  }

  void isFundsActive() {
    setState(() {
      isEquity = false;
      isDebt = false;
      isFunds = true;
    });
  }

  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PrimaryOfferController _controller =
        Provider.of<PrimaryOfferController>(context, listen: false);
    _controller.getAllBidsOnPrimaryOffers().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: true);
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: true);

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
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
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
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Image.asset('assets/icons/back_button.png'),
                  ),
                ),
                title: Text(
                  'My Transactions',
                  style: poppinsRegular.copyWith(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),

              /// body
              ///
              body: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// Equity, Debt and Funds tab
                        SizedBox(height: height * 0.03),
                        Container(
                          width: width,
                          height: 40.0,
                          margin: const EdgeInsets.symmetric(horizontal: 24.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: AppColors.whiteColor.withOpacity(0.1),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TabButton(
                                onTap: isEquityActive,
                                tabText: 'Equity',
                                tabBackColor: isEquity == true
                                    ? AppColors.whiteColor
                                    : Colors.transparent,
                                tabDataColor: isEquity == true
                                    ? AppColors.greenColor
                                    : AppColors.whiteColor,
                              ),
                              TabButton(
                                onTap: isDebtActive,
                                tabText: 'Debt',
                                tabBackColor: isDebt == true
                                    ? AppColors.whiteColor
                                    : Colors.transparent,
                                tabDataColor: isDebt == true
                                    ? AppColors.greenColor
                                    : AppColors.whiteColor,
                              ),
                              TabButton(
                                onTap: isFundsActive,
                                tabText: 'Funds',
                                tabBackColor: isFunds == true
                                    ? AppColors.whiteColor
                                    : Colors.transparent,
                                tabDataColor: isFunds == true
                                    ? AppColors.greenColor
                                    : AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        if (isEquity!)
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // pushNewScreen(context,
                                            //     screen: ShareRequestDetail(
                                            //       offerShareBid: offerShareBid,
                                            //     ),
                                            //     withNavBar: true);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PrimaryOfferShareDetails(
                                                          bidPrimaryOfferDataInfo:
                                                              _primaryOfferController
                                                                      .bidPrimaryOfferData![
                                                                  index],
                                                        )));
                                          },
                                          child: Container(
                                            width: width,
                                            padding: const EdgeInsets.only(
                                                left: 18.0,
                                                right: 18.0,
                                                top: 24.0,
                                                bottom: 30.0),
                                            margin: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20,
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                              color: AppColors.white1,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                // offerShareBid.businessLogo == null
                                                SvgPicture.asset(
                                                  AppImages.blankImg,
                                                  height: 35,
                                                  width: 35,
                                                ),
                                                //     : Image.network(
                                                //         offerShareBid.businessLogo!,
                                                //         height: 35.0,
                                                //         width: 35.0,
                                                //         fit: BoxFit.fill,
                                                //         // errorBuilder:
                                                //         //     ((context, error, stackTrace) {
                                                //         //   return SvgPicture.asset(
                                                //         //       AppImages.blankImg);
                                                //         // }),
                                                //       ),
                                                const SizedBox(width: 12.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              _primaryOfferController
                                                                  .bidPrimaryOfferData![
                                                                      index]
                                                                  .companyName
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                      .poppins()
                                                                  .copyWith(
                                                                color: AppColors
                                                                    .lightBlueColor,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          SmallChip(
                                                            onTap: () {},
                                                            chipText:
                                                                '${_primaryOfferController.bidPrimaryOfferData![index].verificationStatus}',
                                                            chipColor: _primaryOfferController
                                                                        .bidPrimaryOfferData![
                                                                            index]
                                                                        .verificationStatus ==
                                                                    "Pending"
                                                                ? AppColors
                                                                    .yellowColor1
                                                                : AppColors
                                                                    .greenColor1,
                                                          ),
                                                          const SizedBox(
                                                              width: 5.0),
                                                          // SmallChip(
                                                          //   onTap: () {},
                                                          //   chipText:
                                                          //       offerShareBid.offerType,
                                                          //   chipColor: AppColors.lightBlue1,
                                                          // ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16.0),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                CardTextsWidget(
                                                              titleText:
                                                                  'Placement Amount',
                                                              descText: (_primaryOfferController
                                                                      .bidPrimaryOfferData![
                                                                          index]
                                                                      .placementAmount
                                                                      .toString())
                                                                  .replaceAllMapped(
                                                                      RegExp(
                                                                          r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                                      (Match match) =>
                                                                          '${match[1]},'),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 12.0),
                                                          Expanded(
                                                            child: CardTextsWidget(
                                                                titleText:
                                                                    'Payment Type',
                                                                descText: _primaryOfferController
                                                                    .bidPrimaryOfferData![
                                                                        index]
                                                                    .paymentType
                                                                    .toString()),

                                                            // '\$${offerShareBid.maximumBidPrice.toString()}',
                                                          ),
                                                          // Expanded(
                                                          //   child: CardTextsWidget(
                                                          //       titleText:
                                                          //           'approvedOn',
                                                          //       descText: _primaryOfferController
                                                          //           .bidPrimaryOfferData![
                                                          //               index]
                                                          //           .approvedOn

                                                          //       // '\$${offerShareBid.maximumBidPrice.toString()}',
                                                          //       ),
                                                          // ),
                                                          // Expanded(
                                                          //   child: CardTextsWidget(
                                                          //     titleText:
                                                          //         'Limit Offer',
                                                          //     descText: offerShareBid
                                                          //         .offerTimeLimit,
                                                          //   ),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: _primaryOfferController
                                          .bidPrimaryOfferData!.length),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 24),
                                    child:
                                        FutureBuilder<List<BidShareDetails>?>(
                                      future: _offerShareController
                                          .getAllBidShares(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.waiting ||
                                            !snapshot.hasData) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        } else {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data?.length,
                                            itemBuilder: (context, i) {
                                              BidShareDetails offerShareBid =
                                                  snapshot.data![i];
                                              // if (offerShareBid.verificationState.toString() ==
                                              //     '2') {
                                              //   return SizedBox.shrink();
                                              // }
                                              return GestureDetector(
                                                onTap: () {
                                                  pushNewScreen(context,
                                                      screen:
                                                          ShareRequestDetail(
                                                        offerShareBid:
                                                            offerShareBid,
                                                      ),
                                                      withNavBar: true);
                                                },
                                                child: Container(
                                                  width: width,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 18.0,
                                                          right: 18.0,
                                                          top: 24.0,
                                                          bottom: 30.0),
                                                  margin: const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20,
                                                      bottom: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    color: AppColors.white1,
                                                  ),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      offerShareBid
                                                                  .businessLogo ==
                                                              null
                                                          ? SvgPicture.asset(
                                                              AppImages
                                                                  .blankImg,
                                                              height: 35,
                                                              width: 35,
                                                            )
                                                          : Image.network(
                                                              offerShareBid
                                                                  .businessLogo!,
                                                              height: 35.0,
                                                              width: 35.0,
                                                              fit: BoxFit.fill,
                                                              // errorBuilder:
                                                              //     ((context, error, stackTrace) {
                                                              //   return SvgPicture.asset(
                                                              //       AppImages.blankImg);
                                                              // }),
                                                            ),
                                                      const SizedBox(
                                                          width: 12.0),
                                                      Expanded(
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
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    offerShareBid
                                                                        .companyName
                                                                        .toString(),
                                                                    style: GoogleFonts
                                                                            .poppins()
                                                                        .copyWith(
                                                                      color: AppColors
                                                                          .lightBlueColor,
                                                                      fontSize:
                                                                          14.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SmallChip(
                                                                  onTap: () {},
                                                                  chipText:
                                                                      'Payment Done',
                                                                  chipColor:
                                                                      AppColors
                                                                          .greenColor1,
                                                                ),
                                                                const SizedBox(
                                                                    width: 5.0),
                                                                SmallChip(
                                                                  onTap: () {},
                                                                  chipText:
                                                                      offerShareBid
                                                                          .offerType,
                                                                  chipColor:
                                                                      AppColors
                                                                          .lightBlue1,
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 16.0),
                                                            Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      CardTextsWidget(
                                                                    titleText:
                                                                        'Quantity Share',
                                                                    descText: offerShareBid
                                                                        .quantity
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width:
                                                                        12.0),
                                                                Expanded(
                                                                  child:
                                                                      CardTextsWidget(
                                                                    titleText:
                                                                        'Offer Price',
                                                                    descText:
                                                                        '\$${offerShareBid.maximumBidPrice.toString()}',
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      CardTextsWidget(
                                                                    titleText:
                                                                        'Limit Offer',
                                                                    descText:
                                                                        offerShareBid
                                                                            .offerTimeLimit,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
            ),
    );
  }
}
