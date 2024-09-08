import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';

import 'package:bursa_flutter/views/register_shares/ragester_share.dart';
import 'package:bursa_flutter/views/register_shares/register_next.dart';
import 'package:bursa_flutter/widgets/register_share_list_item_view.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../widgets/loading_progress_widget.dart';
import 'share_info_screen.dart';

class RegisterSharInfo extends StatefulWidget {
  const RegisterSharInfo({Key? key}) : super(key: key);

  @override
  State<RegisterSharInfo> createState() => _RegisterSharInfoState();
}

class _RegisterSharInfoState extends State<RegisterSharInfo> {
  bool registershareInfo = false;
  void setRegisterSharInfo(bool value) {
    registershareInfo = value;
    setState(() {});
  }

  bool registerDetails = false;
  void setRegisterDetails(bool value) {
    registerDetails = value;
    setState(() {});
  }

  bool registerGoback = false;

  void setregisterGoback(bool value) {
    registerGoback = value;
    setState(() {});
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    RegisterShareController _controller =
        Provider.of<RegisterShareController>(context, listen: false);
    _controller.getRegisterShares().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    RegisterShareController _controller =
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
            ? const LoadingProgressWidget()
            : (_controller.registerSharesList!.isEmpty
                ? RegisterNext(
                    isCertificate: false,
                  )
                : Scaffold(
                    backgroundColor: transparentColor,
                    body: Container(
                      margin: EdgeInsets.only(
                          left: width * .04,
                          right: width * .02,
                          top: height * .05),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    // setregisterGoback(true);
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    "assets/icons/back_button.png",
                                    height: height * .06,
                                    width: width * .1,
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: width * .18),
                                child: Text(
                                  "Register Shares",
                                  style: poppinsRegular.copyWith(
                                      color: white1,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * .048,
                                      letterSpacing: .05),
                                ),
                              ),
                            ],
                          ),
                          //  widget.shareInfoData!.businessLogo ==
                          //               null
                          //           ? SvgPicture.asset(
                          //               "assets/svgs/nullImage.svg")
                          Container(
                            width: width * .94,
                            height: height * .78,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _controller.registerSharesList!.length,
                              itemBuilder: (context, index) {
                                return RegisterShareListItemView(
                                    businessLogo: _controller
                                        .registerSharesList![index].businessLogo
                                        .toString(),
                                    companyName: _controller
                                        .registerSharesList![index]
                                        .companyName!,
                                    verficationStatus: _controller
                                        .registerSharesList![index]
                                        .verficationStatus!,
                                    grantType: _controller
                                            .registerSharesList![index]
                                            .grantType ??
                                        "-",
                                    equityRound: _controller
                                            .registerSharesList![index]
                                            .equityRound ??
                                        "-",
                                    debtRound: _controller
                                            .registerSharesList![index]
                                            .debtRound ??
                                        "-",
                                    dateOfGrant: _controller
                                        .registerSharesList![index]
                                        .dateOfGrant!,
                                    numberOfShares: _controller
                                        .registerSharesList![index]
                                        .numberOfShares!,
                                    investmentValue: _controller
                                        .registerSharesList![index].sharePrice!,
                                    onTap: () {
                                      // setRegisterDetails(true);
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          reverseDuration:
                                              const Duration(milliseconds: 300),
                                          type: PageTransitionType.rightToLeft,
                                          child: ShareInfoView(
                                            shareInfoData: _controller
                                                .registerSharesList![index],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  height: height * .018,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    // floatingActionButtonLocation:
                    //     FloatingActionButtonLocation.centerFloat,
                    bottomNavigationBar: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: const RagisterShar(),
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
                          "Register Additional Shares",
                          style: poppinsRegular.copyWith(
                              fontSize: width * .036,
                              fontWeight: FontWeight.w500,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  )));
  }
}
