import 'dart:developer';

import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../widgets/small_chip_widget.dart';
import 'primary_offer_detail_screen.dart';

class PrimaryOfferScreen extends StatefulWidget {
  const PrimaryOfferScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PrimaryOfferScreen> createState() => _PrimaryOfferScreenState();
}

class _PrimaryOfferScreenState extends State<PrimaryOfferScreen> {
  @override
  bool isLoading = true;
  List<String> tags = [];

  var difference;
  void initState() {
    // TODO: implement initState

    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: false);
    // log("Primary Offer Data=================" +
    //     _offerShareController.GetPrimaryOfferDatas().toString());
    _primaryOfferController.GetPrimaryOfferDatas().then((value) {
      setState(() {
        isLoading = false;
      });

      // setState(() {
      //   isLoading = false;
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: true);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.only(top: height * 0.02),

            /// primary offering box
            // SizedBox(height: height * 0.05),

            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var numbers = [
                  _primaryOfferController.primaryOfferDataInfo![index].tags
                ]; // List<dynamic>
                var ints = numbers.map((s) => s).toList();

                var closeDate = _primaryOfferController
                    .primaryOfferDataInfo![index].closingDate
                    .toString();

                var dat1 = _primaryOfferController.convertDateFormat(
                    closeDate, "MM/dd/yyyy", "yyyy-MM-dd HH:mm:ss");

                var dat2 = DateTime.parse(dat1);
                var dateFormat = DateTime.now();

                difference = dat2
                    .difference(DateTime.parse(dateFormat.toString()))
                    .inDays;

                return SingleChildScrollView(
                  child: GestureDetector(
                    onTap: () {
                      _primaryOfferController
                                  .primaryOfferDataInfo![index].myBidStatus ==
                              0
                          ? Navigator.push(
                              context,
                              PageTransition(
                                duration: const Duration(milliseconds: 300),
                                reverseDuration:
                                    const Duration(milliseconds: 300),
                                type: PageTransitionType.rightToLeft,
                                child: PrimaryOfferDetailScreen(
                                  primaryOfferDataInfo: _primaryOfferController
                                      .primaryOfferDataInfo![index],
                                ),
                              ),
                            )
                          : null;
                    },
                    child: Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(horizontal: 24.0),
                      padding: const EdgeInsets.only(top: 6.0, bottom: 14.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: AppColors.whiteColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// project hot row
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6.0),
                                      child: Text(
                                        _primaryOfferController
                                            .primaryOfferDataInfo![index]
                                            .companyName
                                            .toString(),
                                        style: poppinsRegular.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkBlueColor2,
                                        ),
                                      ),
                                    ),
                                    // Text(
                                    //   ' Hot',
                                    //   style: poppinsRegular.copyWith(
                                    //     fontSize: 13.0,
                                    //     fontWeight: FontWeight.w600,
                                    //     color: AppColors.redTextColor,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 4.0),
                                  margin: const EdgeInsets.only(top: 6.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(
                                      color: AppColors.darkBlueColor2,
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Text(
                                    'Equity',
                                    style: poppinsRegular.copyWith(
                                      color: AppColors.darkBlueColor2,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// tags row
                          const SizedBox(height: 4.0),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,

                                // spacing: 5.0,
                                children: [
                                  SmallChip(
                                    onTap: () {},
                                    chipText:
                                        '${_primaryOfferController.primaryOfferDataInfo![index].tags.toString()}',
                                    chipColor: AppColors.darkBlueColor2
                                        .withOpacity(0.5),
                                  ),
                                  // Container(
                                  //   // color: redColor,
                                  //   width: 200,
                                  //   height: 50,
                                  //   child: ListView.separated(
                                  //       shrinkWrap: true,
                                  //       scrollDirection: Axis.horizontal,
                                  //       itemBuilder: (context, index) {
                                  //         final tagName =
                                  //             _primaryOfferController
                                  //                 .primaryOfferDataInfo![index]
                                  //                 .tags
                                  //                 .toString();
                                  //         final split = tagName.split(',');

                                  //         log("log---->" + split.toString());

                                  //         for (int i = 0;
                                  //             i < split.length;
                                  //             i++) {
                                  //           tags.add(split[i]);
                                  //         }

                                  //         log(tags.toString());
                                  //         setState(() {});

                                  //         log("log---->" + tags.toString());

                                  //         return Container(
                                  //           width: 10.0,
                                  //           color: greenColor,
                                  //           child: Text(tags.toString()),
                                  //         );
                                  //       },
                                  //       separatorBuilder: (index, context) {
                                  //         //log("log---sw->" + tags[index].toString());
                                  //         return Container(
                                  //           width: 10.0,
                                  //           color: blackColor,
                                  //         );
                                  //       },
                                  //       itemCount: tags.length),
                                  // ),
                                  _primaryOfferController
                                              .primaryOfferDataInfo![index]
                                              .myBidStatus !=
                                          0
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          margin:
                                              const EdgeInsets.only(top: 0.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.greenColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            // border: Border.all(
                                            //   // color: AppColors.darkBlueColor2,
                                            //   width: 1.0,
                                            // ),
                                          ),
                                          child: Text(
                                            'Bid Completed',
                                            style: poppinsRegular.copyWith(
                                              color: AppColors.white1,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 4.0),
                                          margin:
                                              const EdgeInsets.only(top: 0.0),
                                          decoration: BoxDecoration(
                                            color: AppColors.blueColor,
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            // border: Border.all(
                                            //   // color: AppColors.darkBlueColor2,
                                            //   width: 1.0,
                                            // ),
                                          ),
                                          child: Text(
                                            'Bid Now',
                                            style: poppinsRegular.copyWith(
                                              color: AppColors.white1,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                        ),
                                ],
                              )),
                          // ListView.separated(
                          //     scrollDirection: Axis.horizontal,
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 24.0),
                          //         child: Wrap(
                          //           spacing: 5.0,
                          //           children: [
                          //             SmallChip(
                          //               onTap: () {},
                          //               chipText: _primaryOfferController
                          //                   .primaryOfferDataInfo![index]
                          //                   .companyInfo![0]
                          //                   .value!
                          //                   .split(",")
                          //                   .toString().isNotEmpty?"0":"1"
                          //               chipColor: AppColors.darkBlueColor2
                          //                   .withOpacity(0.5),
                          //             ),
                          //             // SmallChip(
                          //             //   onTap: () {},
                          //             //   chipText: 'Financial Services',
                          //             //   chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                          //             // ),
                          //             // SmallChip(
                          //             //   onTap: () {},
                          //             //   chipText: 'EIS',
                          //             //   chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                          //             // ),
                          //             // SmallChip(
                          //             //   onTap: () {},
                          //             //   chipText: 'Early Stage',
                          //             //   chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                          //             // ),
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //     separatorBuilder: (context, index) {
                          //       return Container(
                          //         width: 1.0,
                          //         color: AppColors.greyColor,
                          //       );
                          //     },
                          //     itemCount: _primaryOfferController
                          //         .primaryOfferDataInfo![index]
                          //         .companyInfo![0]
                          //         .value!
                          //         .length),

                          /// description texts
                          SizedBox(height: height * 0.008),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              '${_primaryOfferController.primaryOfferDataInfo![index].shortDescription}',
                              style: poppinsRegular.copyWith(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor2,
                              ),
                            ),
                          ),

                          /// price and days left texts
                          const SizedBox(height: 4.0),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    "\$${_primaryOfferController.primaryOfferDataInfo![index].totalTargetAmount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')} ", // '\$${_primaryOfferController.primaryOfferDataInfo![index].companyInfo![2].value.toString() == "null" ? 0 : _primaryOfferController.primaryOfferDataInfo![index].companyInfo![2].value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]},')}',
                                    style: poppinsRegular.copyWith(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.greenColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  difference = dat2
                                              .difference(DateTime.parse(
                                                  dateFormat.toString()))
                                              .isNegative ==
                                          true
                                      ? "Expired"
                                      : ' ${_primaryOfferController.primaryOfferDataInfo![index].daysLeft}',
                                  // "",
                                  style: poppinsRegular.copyWith(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.redTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// green box
                          SizedBox(height: height * 0.008),
                          Container(
                            width: width,
                            padding: const EdgeInsets.only(
                                top: 4.0, bottom: 4.0, left: 24.0, right: 20.0),
                            color: AppColors.greenColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${_primaryOfferController.primaryOfferDataInfo![index].feePercentage}",
                                  // _primaryOfferController
                                  //     .primaryOfferDataInfo![index]
                                  //     .companyInfo![5]
                                  //     .value
                                  //     .toString(),
                                  style: poppinsRegular.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.whiteColor,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// raise, term and rate
                          SizedBox(height: height * 0.016),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Raised',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.greyColor2,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      "\$ ${_primaryOfferController.primaryOfferDataInfo![index].raisedAmount}",
                                      // '\$ XXXX',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Allocation %',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.greyColor2,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      "${_primaryOfferController.primaryOfferDataInfo![index].allocation}",
                                      // 'X . X %',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Investors',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.greyColor2,
                                      ),
                                    ),
                                    const SizedBox(height: 4.0),
                                    Text(
                                      // _primaryOfferController
                                      //     .primaryOfferDataInfo![index]
                                      //     .investorDto![0]
                                      //     .verificationStatus
                                      //     .toString(),
                                      "${_primaryOfferController.primaryOfferDataInfo![index].totalInvestors}",
                                      // '${_primaryOfferController.primaryOfferDataInfo![index].investorDto!.isEmpty ? "0" : _primaryOfferController.primaryOfferDataInfo![index].investorDto![0].verificationStatus.toString()}',
                                      style: poppinsRegular.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.blackColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: height * 0.02,
                );
              },
              itemCount: _primaryOfferController.primaryOfferDataInfo!.length,
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
            ),

            // GestureDetector(
            //   onTap: () {
            //     /*Get.to(
            //       const PrimaryOfferDetailScreen(),
            //       transition: Transition.rightToLeft,
            //       duration: const Duration(
            //         milliseconds:
            //         300),
            //     );*/
            //   Navigator.push(
            //     context,
            //     PageTransition(
            //       duration: const Duration(milliseconds: 300),
            //       reverseDuration: const Duration(milliseconds: 300),
            //       type: PageTransitionType.rightToLeft,
            //       child: const PrimaryOfferDetailScreen(),
            //     ),
            //   );
            // },
            //   child: Container(
            //     width: width,
            //     margin: const EdgeInsets.symmetric(horizontal: 24.0),
            //     padding: const EdgeInsets.only(top: 6.0, bottom: 14.0),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15.0),
            //       color: AppColors.whiteColor,
            //     ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         /// project hot row
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(top: 6.0),
            //                     child: Text(
            //                       'Project Cardy',
            //                       style: poppinsRegular.copyWith(
            //                         fontSize: 14.0,
            //                         fontWeight: FontWeight.w500,
            //                         color: AppColors.darkBlueColor2,
            //                       ),
            //                     ),
            //                   ),
            //                   Text(
            //                     ' Hot',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 13.0,
            //                       fontWeight: FontWeight.w600,
            //                       color: AppColors.redTextColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               Container(
            //                 padding: const EdgeInsets.symmetric(
            //                     horizontal: 8.0, vertical: 4.0),
            //                 margin: const EdgeInsets.only(top: 6.0),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5.0),
            //                   border: Border.all(
            //                     color: AppColors.darkBlueColor2,
            //                     width: 1.0,
            //                   ),
            //                 ),
            //                 child: Text(
            //                   'Equity',
            //                   style: poppinsRegular.copyWith(
            //                     color: AppColors.darkBlueColor2,
            //                     fontWeight: FontWeight.w500,
            //                     fontSize: 12.0,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),

            //         /// tags row
            //         const SizedBox(height: 4.0),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //           child: Wrap(
            //             spacing: 5.0,
            //             children: [
            //               SmallChip(
            //                 onTap: () {},
            //                 chipText: 'UAE',
            //                 chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
            //               ),
            //               SmallChip(
            //                 onTap: () {},
            //                 chipText: 'Financial Services',
            //                 chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
            //               ),
            //               SmallChip(
            //                 onTap: () {},
            //                 chipText: 'EIS',
            //                 chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
            //               ),
            //               SmallChip(
            //                 onTap: () {},
            //                 chipText: 'Early Stage',
            //                 chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
            //               ),
            //             ],
            //           ),
            //         ),

            //         /// description texts
            //         SizedBox(height: height * 0.008),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //           child: Text(
            //             'Series AB co-investment oppourtunity in a regulated fintech '
            //             'Software as a Service platform.',
            //             style: poppinsRegular.copyWith(
            //               fontSize: 12.0,
            //               fontWeight: FontWeight.w400,
            //               color: AppColors.greyColor2,
            //             ),
            //           ),
            //         ),

            //         /// price and days left texts
            //         const SizedBox(height: 4.0),
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 '\$1500000 Target',
            //                 style: poppinsRegular.copyWith(
            //                   fontSize: 13.0,
            //                   fontWeight: FontWeight.w500,
            //                   color: AppColors.greenColor,
            //                 ),
            //               ),
            //               Text(
            //                 '5 Days Left',
            //                 style: poppinsRegular.copyWith(
            //                   fontSize: 13.0,
            //                   fontWeight: FontWeight.w500,
            //                   color: AppColors.redTextColor,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),

            //         /// green box
            //         SizedBox(height: height * 0.008),
            //         Container(
            //           width: width,
            //           padding: const EdgeInsets.only(
            //               top: 4.0, bottom: 4.0, left: 24.0, right: 20.0),
            //           color: AppColors.greenColor,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Text(
            //                 '162%',
            //                 style: poppinsRegular.copyWith(
            //                   fontWeight: FontWeight.w700,
            //                   color: AppColors.whiteColor,
            //                   fontSize: 16.0,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),

            //         /// raise, term and rate
            //         SizedBox(height: height * 0.016),
            //         Row(
            //           children: [
            //             Expanded(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     'Raised',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 12.0,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.greyColor2,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 4.0),
            //                   Text(
            //                     '\$21289',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 16.0,
            //                       fontWeight: FontWeight.w600,
            //                       color: AppColors.blackColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Expanded(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     'Allocation %',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 12.0,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.greyColor2,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 4.0),
            //                   Text(
            //                     '1.4 %',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 16.0,
            //                       fontWeight: FontWeight.w600,
            //                       color: AppColors.blackColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Expanded(
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Text(
            //                     'Investors',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 12.0,
            //                       fontWeight: FontWeight.w400,
            //                       color: AppColors.greyColor2,
            //                     ),
            //                   ),
            //                   const SizedBox(height: 4.0),
            //                   Text(
            //                     '639',
            //                     style: poppinsRegular.copyWith(
            //                       fontSize: 16.0,
            //                       fontWeight: FontWeight.w600,
            //                       color: AppColors.blackColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          );
  }
}
