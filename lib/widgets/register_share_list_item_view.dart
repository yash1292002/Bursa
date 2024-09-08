import 'package:bursa_flutter/widgets/register_share_row_text.dart';
import 'package:bursa_flutter/widgets/register_shares_circular_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class RegisterShareListItemView extends StatelessWidget {
  final String businessLogo;
  final String companyName;
  final String grantType;
  final String verficationStatus;
  final String equityRound;
  final String debtRound;
  final String dateOfGrant;
  final num numberOfShares;
  final num investmentValue;
  final VoidCallback onTap;

  const RegisterShareListItemView({
    Key? key,
    required this.businessLogo,
    required this.companyName,
    required this.grantType,
    required this.equityRound,
    required this.debtRound,
    required this.dateOfGrant,
    required this.numberOfShares,
    required this.investmentValue,
    required this.verficationStatus,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //width: width * .4,
        // height: height * .27,
        //width: width*.,
        padding: EdgeInsets.only(
          bottom: height * .01,
        ),
        decoration: BoxDecoration(
            color: white1, borderRadius: BorderRadius.circular(width * .04)),
        child: Row(
          children: [
            RegisterShareCircularImage(
              businessLogo: businessLogo,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: width * .06,
                          left: width * .04,
                        ),
                        child: Text(
                          companyName,
                          style: AppStyles.companyNameText,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * .015,
                            // left: width * .22,
                            right: width * .05),
                        height: height * .03,
                        width: width * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * .05),
                          //  color: greenColor
                          //       .withOpacity(.5),
                          color: verficationStatus == "Pending"
                              ? AppColors.yellowAccentColor
                              : greenColor,
                        ),
                        child: Center(
                            child: Text(
                          verficationStatus.toString(),
                          style: AppStyles.registerSharesStatusText,
                        )),
                      ),
                    ],
                  ),
                  RegisterShareRowText(
                    heading_1: "Type of grant",
                    value_1: grantType,
                    heading_2: "Equity Rounds",
                    value_2: equityRound,
                  ),
                  RegisterShareRowText(
                    heading_1: "Debt Rounds",
                    value_1: debtRound,
                    heading_2: "Request Date",
                    value_2: dateOfGrant,
                  ),
                  RegisterShareRowText(
                    heading_1: "Share Grant",
                    value_1: "$numberOfShares",
                    heading_2: "Investment Value",
                    value_2: "$investmentValue",
                    // isGreen: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
