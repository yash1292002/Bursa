import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/getAllBid_offerShare.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/views/market/equity/primary_offer/request_allocation_primary_screen.dart/request_allocation_reveiw.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../consts/textstyle_const.dart';

class PrimaryOfferDetailScreen extends StatefulWidget {
  const PrimaryOfferDetailScreen({
    Key? key,
    required this.primaryOfferDataInfo,
  }) : super(key: key);
  final PrimaryOfferDataInfo primaryOfferDataInfo;

  @override
  State<PrimaryOfferDetailScreen> createState() =>
      _PrimaryOfferDetailScreenState();
}

class _PrimaryOfferDetailScreenState extends State<PrimaryOfferDetailScreen>
    with
        AutomaticKeepAliveClientMixin<PrimaryOfferDetailScreen>,
        SingleTickerProviderStateMixin {
  TabController? _tabController;

  bool isLoading = true;

  int selectedIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: false);

    // _offerShareController.getPrimaryCategory().then((value) {
    //   log("_offerShareController.categoryInfoData!.length -----  " +
    //       _offerShareController.categoryInfoData!.length.toString());
    // _tabController = TabController(
    //     length: _offerShareController.categoryInfoData!.length, vsync: this);
    //   setState(() {
    //     _offerShareController.setSelectedCategoryInfoData(
    //         _offerShareController.categoryInfoData![0]);
    //     isLoading = false;
    //   });
    // });

    _primaryOfferController
        .getPrimaryCompanyOffer(
            widget.primaryOfferDataInfo.companyId.toString())
        .then((value) {
      log("_offerShareController.companyOfferData!.length -----  " +
          widget.primaryOfferDataInfo.webView!.length.toString());
      _tabController = TabController(
          length: widget.primaryOfferDataInfo.webView!.length, vsync: this);

      setState(() {
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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /// tech founder growth equity fund box
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.whiteColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.primaryOfferDataInfo.companyName}',
                          style: poppinsRegular.copyWith(
                            color: AppColors.lightBlueColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        // //============================= Company name ================================
                        fundRow('${"Minimum Investment"} :',
                            ' \$${widget.primaryOfferDataInfo.minimumInvestment.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}'),

                        // //============================= Closing Date ================================
                        fundRow('${"Closing Date"} :',
                            '${widget.primaryOfferDataInfo.closingDate}'),

                        // // //============================= investment manager ================================
                        fundRow('${"Investment Manager"} :',
                            ' ${widget.primaryOfferDataInfo.investmentManager}'),
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

                          log("Selected Index--->" + selectedIndex.toString());
                        },
                        tabs: List.generate(
                            widget.primaryOfferDataInfo.webView!.length,
                            (index) => Container(
                                  height: 50,
                                  child: Center(
                                    child: Tab(
                                      text: widget.primaryOfferDataInfo
                                          .webView![index].name,
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

                  // / details box
                  // / details box
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                          widget.primaryOfferDataInfo.webView!.length, (index) {
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
                              child: widget.primaryOfferDataInfo.webView![index]
                                          .value ==
                                      null
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
                                  ${widget.primaryOfferDataInfo.webView![index].value}
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
                    // widget.primaryOfferDataInfo.companyName!.contains(
                    //         widget.bidPrimaryOfferDataInfo.companyName!)
                    Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeft,
                          child: PrimaryRequestAllocationScreen(
                            primaryOfferDataInfo: widget.primaryOfferDataInfo,
                          )),
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

  Widget fundRow(mainText, descText) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
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

  Widget summeryRow(mainText, descText) => Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                mainText,
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlueColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                ':',
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlueColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                descText,
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor2,
                ),
              ),
            ),
          ],
        ),
      );
}
