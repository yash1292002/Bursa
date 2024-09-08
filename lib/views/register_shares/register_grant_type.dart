import 'dart:developer';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../widgets/custom_next_button.dart';
import '../../widgets/grant_type_item_builder.dart';
import '../../widgets/loading_progress_widget.dart';

class RegisterGrantType extends StatefulWidget {
  RegisterGrantType({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterGrantType> createState() => _RegisterGrantTypeState();
}

class _RegisterGrantTypeState extends State<RegisterGrantType> {
  // String selectedDebtRounds = "Common";
  @override
  void initState() {
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: false);
    // TODO: implement initState
    super.initState();
    _registerShareController.getGrantTypes().then((value) {
      _registerShareController
          .setSelectedGrantType(_registerShareController.grantTypeList![0]);
      setState(() {
        isLoading = true;
      });
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return isLoading
        ? Container(
            margin: EdgeInsets.only(bottom: width * .03, top: width * .02),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    // height: height * .16,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          width * .03,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04,
                              top: height * .02,
                              right: width * .04),
                          child: Text(
                            "Please select the type of grant that was offered to you ?",
                            style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .035,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        GridView.builder(
                          padding: EdgeInsets.only(
                              left: width * .04,
                              right: width * .04,
                              top: height * .011,
                              bottom: height * .008),
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
                                if (_registerShareController
                                        .selectedGrantType !=
                                    _registerShareController
                                        .grantTypeList![index]) {
                                  _registerShareController.setSelectedGrantType(
                                      _registerShareController
                                          .grantTypeList![index]);
                                  log(_registerShareController
                                      .grantTypeList![index]
                                      .toString());
                                }
                              },
                              text: _registerShareController
                                  .grantTypeList![index].name!,
                              isSelected:
                                  _registerShareController.selectedGrantType ==
                                      _registerShareController
                                          .grantTypeList![index],
                            );
                          },
                          itemCount:
                              _registerShareController.grantTypeList!.length,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * .015),
                    // height: height * .42,
                    width: width,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          width * .03,
                        ),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: height * .01,
                                          left: width * .04,
                                          right: width * .04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _registerShareController
                                                .grantTypeList![index].name!,
                                            style: poppinsRegular.copyWith(
                                                color: lightBlueColor,
                                                fontSize: width * .036,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: width * .01),
                                            child: Text(
                                              _registerShareController
                                                  .grantTypeList![index]
                                                  .description!,
                                              style: poppinsRegular.copyWith(
                                                  color: greyColor,
                                                  fontSize: width * .032),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return Container(
                                  width: width * .02,
                                );
                              },
                              itemCount: _registerShareController
                                  .grantTypeList!.length),
                          CustomNextButton(
                            onTap:
                                (_registerShareController.selectedGrantType !=
                                        null)
                                    ? widget.onTap
                                    : null,
                            btnColor:
                                (_registerShareController.selectedGrantType !=
                                        null)
                                    ? greenColor
                                    : grey1Color,
                            text: "Next",
                            marginTop: height * .05,
                            marginBottom: width * .04,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : const LoadingProgressWidget();
  }
}
