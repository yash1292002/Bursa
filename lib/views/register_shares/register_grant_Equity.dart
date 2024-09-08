import 'dart:developer';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../widgets/custom_next_button.dart';
import '../../widgets/grant_type_item_builder.dart';
import '../../widgets/loading_progress_widget.dart';

class RegisterGrantEqutity extends StatefulWidget {
  RegisterGrantEqutity({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterGrantEqutity> createState() => _RegisterGrantEqutityState();
}

class _RegisterGrantEqutityState extends State<RegisterGrantEqutity>
    with TickerProviderStateMixin {
  bool isLoading = true;

  @override
  void initState() {
    RegisterShareController _controller =
        Provider.of<RegisterShareController>(context, listen: false);

    super.initState();
    _controller.getEquityRound().then((value) {
      _controller.getDebtRounds().then((value1) {
        setState(() {
          isLoading = false;
        });
      });
    });

    // log("SelectedEquity ------ " +
    //     _controller.selectedEquityRounds!.name.toString());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(bottom: width * .03, top: width * .02),
      // height: height*.6,
      child: isLoading
          ? const LoadingProgressWidget()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        // height: height * .6,
                        margin: EdgeInsets.only(
                          left: width * .02,
                          right: width * .02,
                        ),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(width * .03),
                        ),
                        // alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          left: width * .05,
                          right: width * .05,
                          top: width * .05,
                          bottom: width * .05,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "At what stage the shares were granted to you ?",
                              style: poppinsRegular.copyWith(
                                color: darkBlueColor2,
                                fontSize: width * .04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: height * .025,
                                  bottom: height * .02,
                                ),
                                child: Text(
                                  "Equity Rounds",
                                  style: poppinsRegular.copyWith(
                                    color: darkBlueColor2,
                                    fontSize: width * .036,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.3,
                                crossAxisSpacing: width * .03,
                                mainAxisSpacing: width * .03,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return GrantTypeGridItemBuilder(
                                  onTap: () {
                                    _registerShareController
                                        .setSelectedEquityRounds(
                                            _registerShareController
                                                .equityRoundsList![index]);
                                  },
                                  text: _registerShareController
                                      .equityRoundsList![index].name!,
                                  isSelected: _registerShareController
                                              .selectedEquityRounds !=
                                          null
                                      ? _registerShareController
                                                  .selectedEquityRounds!.name ==
                                              _registerShareController
                                                  .equityRoundsList![index].name
                                          ? true
                                          : false
                                      : false,
                                );
                              },
                              itemCount: _registerShareController
                                  .equityRoundsList!.length,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: height * .04,
                                  bottom: width * .04,
                                ),
                                child: Text(
                                  "Debt Rounds",
                                  style: poppinsRegular.copyWith(
                                    color: darkBlueColor2,
                                    fontSize: width * .036,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            GridView.builder(
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 2.3,
                                crossAxisSpacing: width * .03,
                                mainAxisSpacing: width * .03,
                              ),
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return GrantTypeGridItemBuilder(
                                  onTap: () {
                                    _registerShareController
                                        .setSelectedDebtRound(
                                            _registerShareController
                                                .debtRoundList[index]);
                                    log(_registerShareController
                                        .debtRoundList[index]
                                        .toString());
                                  },
                                  text: _registerShareController
                                      .debtRoundList[index].name!,
                                  isSelected: _registerShareController
                                              .selectedDebtRound !=
                                          null
                                      ? (_registerShareController
                                                  .selectedDebtRound!.name ==
                                              _registerShareController
                                                  .debtRoundList[index].name
                                          ? true
                                          : false)
                                      : false,
                                );
                              },
                              itemCount:
                                  _registerShareController.debtRoundList.length,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: height * .028,
                                bottom: height * .028,
                              ),
                              child: Text(
                                "Please select all that apply, and ensure uploading all relevant agreements.",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .032,
                                  color: greyColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            CustomNextButton(
                              onTap:
                                  (_registerShareController.selectedDebtRound !=
                                              null ||
                                          _registerShareController
                                                  .selectedEquityRounds !=
                                              null)
                                      ? widget.onTap
                                      : null,
                              btnColor:
                                  (_registerShareController.selectedDebtRound !=
                                              null ||
                                          _registerShareController
                                                  .selectedEquityRounds !=
                                              null)
                                      ? greenColor
                                      : grey1Color,
                              text: "Next",
                              marginTop: height * .08,
                              marginBottom: width * .02,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
