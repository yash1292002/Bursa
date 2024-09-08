import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:bursa_flutter/views/register_shares/register_next.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../consts/app_images.dart';
import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';
import '../../../widgets/small_chip_widget.dart';
import 'register_certificate/register_certificate_screen.dart';
import 'view_certificate_screen.dart';

class IssueDigitalCertificateScreen extends StatefulWidget {
  const IssueDigitalCertificateScreen({Key? key}) : super(key: key);

  @override
  State<IssueDigitalCertificateScreen> createState() =>
      _IssueDigitalCertificateScreenState();
}

class _IssueDigitalCertificateScreenState
    extends State<IssueDigitalCertificateScreen> {
  @override
  bool isLoading = true;
  void initState() {
    super.initState();
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: false);

    _controller.getAllIssueshareCertificate().then((value) {
      _controller.getRegisterShare().then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
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
          ? Center(
              child: CircularProgressIndicator(
                color: whiteColor,
              ),
            )
          : (_controller.issueShareList!.isEmpty
              ? RegisterNext(
                  isCertificate: true,
                )
              : Scaffold(
                  backgroundColor: transparentColor,

                  /// appbar
                  appBar: AppBar(
                    centerTitle: true,
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      onPressed: () {
                        // setregisterGoback(true);
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        "assets/icons/back_button.png",
                        height: height * .06,
                        width: width * .1,
                      ),
                    ),
                    title: Text(
                      "Issue Digital Certificates",
                      style: poppinsRegular.copyWith(
                          color: white1,
                          fontWeight: FontWeight.w500,
                          fontSize: width * .048,
                          letterSpacing: .05),
                    ),
                  ),

                  /// bottom navigation bar
                  bottomNavigationBar: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          duration: const Duration(milliseconds: 300),
                          reverseDuration: const Duration(milliseconds: 300),
                          type: PageTransitionType.rightToLeft,
                          child: const RegisterCertificateScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      height: height * .054,
                      width: width * .88,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: blackColor,
                        borderRadius: BorderRadius.circular(08),
                        color: AppColors.whiteColor.withOpacity(0.1),
                        border: Border.all(
                          color: AppColors.whiteColor.withOpacity(0.1),
                          // width: 1,
                        ),
                      ),
                      child: Text(
                        "Register your digital certificate",
                        style: poppinsRegular.copyWith(
                            fontSize: width * .036,
                            fontWeight: FontWeight.w500,
                            color: whiteColor),
                      ),
                    ),
                  ),

                  /// body
                  body: Container(
                      margin: EdgeInsets.only(
                        left: width * .04,
                        right: width * .02,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: height * .02,
                          bottom: height * .02,
                        ),
                        itemCount: _controller.issueShareList!.length,
                        itemBuilder: (context, index) {
                          RegisterShareInfo? shareDetail;

                          for (var item in _controller.shareValueList!) {
                            if (item.id ==
                                _controller.issueShareList![index].shareId) {
                              shareDetail = item;
                            }
                          }

                          return GestureDetector(
                            onTap: () {
                              // setRegisterDetails(true);
                              Navigator.push(
                                context,
                                PageTransition(
                                  duration: const Duration(milliseconds: 300),
                                  reverseDuration:
                                      const Duration(milliseconds: 300),
                                  type: PageTransitionType.rightToLeft,
                                  child: ViewCertificateScreen(
                                    shareInfosData:
                                        _controller.issueShareList![index],
                                    registerInfoData: shareDetail,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              //width: width * .4,
                              // height: height * .27,
                              //width: width*.,
                              padding: EdgeInsets.only(
                                bottom: height * .01,
                              ),
                              decoration: BoxDecoration(
                                  color: white1,
                                  borderRadius:
                                      BorderRadius.circular(width * .04)),
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: width * .04,
                                        bottom: height * .13),
                                    height: height * .04,
                                    width: width * .09,
                                    decoration: BoxDecoration(
                                        color: white1,
                                        borderRadius:
                                            BorderRadius.circular(width * .09)),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(width * .00),
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(
                                          shareDetail!.businessLogo.toString(),
                                          errorBuilder:
                                              ((context, error, stackTrace) {
                                            return SvgPicture.asset(
                                                AppImages.blankImg);
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: width * .27,
                                              margin: EdgeInsets.only(
                                                top: width * .06,
                                                left: width * .04,
                                              ),
                                              child: Text(
                                                shareDetail.companyName ?? "-",
                                                style: poppinsRegular.copyWith(
                                                    color: lightBlueColor,
                                                    fontSize: width * .04,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: height * .015,
                                                  left: width * .02,
                                                  right: width * .0),
                                              height: height * .03,
                                              width: width * .2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        width * .05),
                                                //  color: greenColor
                                                //       .withOpacity(.5),
                                                color: greenColor,
                                              ),
                                              child: Center(
                                                  child: Text(
                                                shareDetail.verficationStatus
                                                    .toString(),
                                                style: poppinsRegular.copyWith(
                                                    color: white1,
                                                    fontSize: width * .030),
                                              )),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: height * .012,
                                                  right: width * .02),
                                              child: SmallChip(
                                                onTap: () {},
                                                chipText: 'Non-Certified',
                                                chipColor: AppColors.lightBlue1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * .01),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04,
                                                          top: height * .0),
                                                      child: Text(
                                                        "Type of grant",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize:
                                                                    width *
                                                                        .03),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04),
                                                      child: Text(
                                                          shareDetail
                                                                  .grantType ??
                                                              "-",
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            color:
                                                                lightBlueColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                width * .03,
                                                          ))),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .08,
                                                          top: height * .0),
                                                      child: Text(
                                                        "Equity Rounds",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize:
                                                                    width *
                                                                        .03),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets
                                                          .only(
                                                              left:
                                                                  width * .08),
                                                      child: Text(
                                                          shareDetail
                                                                  .equityRound ??
                                                              "-",
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  color:
                                                                      lightBlueColor,
                                                                  fontSize:
                                                                      width *
                                                                          .03,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * .02),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04,
                                                          top: height * .0),
                                                      child: Text(
                                                        "Debt Rounds",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize:
                                                                    width *
                                                                        .03),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04),
                                                      child: Text(
                                                          shareDetail
                                                                  .debtRound ??
                                                              "-",
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  color:
                                                                      lightBlueColor,
                                                                  fontSize:
                                                                      width *
                                                                          .03,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .08,
                                                          top: height * .0),
                                                      child: Text(
                                                        "Certificate Issue Date",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize:
                                                                    width *
                                                                        .03),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets
                                                          .only(
                                                              left:
                                                                  width * .08),
                                                      child: Text(
                                                          shareDetail
                                                                  .dateOfGrant ??
                                                              "-",
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  color:
                                                                      lightBlueColor,
                                                                  fontSize:
                                                                      width *
                                                                          .03,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600))),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: height * .02),
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04,
                                                          top: height * .0),
                                                      child: Text(
                                                        "Share Grant",
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                color:
                                                                    greyColor,
                                                                fontSize:
                                                                    width *
                                                                        .03),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: width * .04),
                                                      child: Text(
                                                          (shareDetail.numberOfShares ??
                                                                  "-")
                                                              .toString(),
                                                          style: poppinsRegular
                                                              .copyWith(
                                                            color:
                                                                lightBlueColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                width * .03,
                                                          ))),
                                                ],
                                              ),
                                              // Column(
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   children: [
                                              //     Container(
                                              //         margin: EdgeInsets.only(
                                              //             left: width * .08,
                                              //             top: height * .0),
                                              //         child: Text(
                                              //           "Granted Shares Price",
                                              //           style: poppinsRegular
                                              //               .copyWith(
                                              //                   color: greyColor,
                                              //                   fontSize:
                                              //                       width * .03),
                                              //         )),
                                              //     Container(
                                              //       margin: EdgeInsets.only(
                                              //           left: width * .08),
                                              //       child: Text(
                                              //         ("\$" +
                                              //             ((shareDetail.numberOfShares ??
                                              //                         1) *
                                              //                     (shareDetail
                                              //                             .sharePrice ??
                                              //                         1))
                                              //                 .toString()),
                                              //         style:
                                              //             poppinsRegular.copyWith(
                                              //                 color: greenColor,
                                              //                 fontSize:
                                              //                     width * .03,
                                              //                 fontWeight:
                                              //                     FontWeight
                                              //                         .w600),
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            height: height * .018,
                          );
                        },
                      )),
                )),
    );
  }
}
