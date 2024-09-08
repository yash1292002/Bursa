import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/models/register_share_model.dart';

import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/textstyle_const.dart';

class StepOneScreen extends StatefulWidget {
  StepOneScreen({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<StepOneScreen> createState() => _StepOneScreenState();
}

class _StepOneScreenState extends State<StepOneScreen> {
  // String? shareValue;

  // List<String> shareName = [
  //   "Share 1",
  //   "Share 2",
  //   "Share 3",
  //   "Share 4",
  //   "Share 5",
  // ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IssueDigitalCertiController _issueDigitalCertiController =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: AppColors.white1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Which shares would you like to issue a certificate for ?',
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.lightBlueColor,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'You will only be able to select one company share per request..',
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.greyColor2,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(height: height * 0.08),
            Container(
              margin: EdgeInsets.only(
                top: height * .01,
              ),
              width: width,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: width * .002,
                    color: lightBlueColorWithopacity30,
                  ),
                ),
              ),
              child: DropdownButton<RegisterShareInfo>(
                hint: Text(
                  "Select your approved shares",
                  style: poppinsRegular.copyWith(
                    color: lightBlueColor,
                    fontSize: width * .036,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: poppinsRegular.copyWith(
                  color: blackColor,
                  fontSize: width * .036,
                  fontWeight: FontWeight.w500,
                ),
                isExpanded: true,
                underline: DropdownButtonHideUnderline(
                  child: Container(),
                ),
                value: _issueDigitalCertiController.selectedShareValue,
                items: List.generate(
                    _issueDigitalCertiController.shareValueList!.length,
                    (index) {
                  return DropdownMenuItem<RegisterShareInfo>(
                      child: Text(
                        _issueDigitalCertiController
                            .shareValueList![index].companyName!,
                        style: poppinsRegular.copyWith(
                          color: blackColor,
                          fontSize: width * .036,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value:
                          _issueDigitalCertiController.shareValueList![index]);
                }),
                onChanged: (value) {
                  // shareValue = value as String;

                  _issueDigitalCertiController.setShareVlaue(value);
                  // _issueDigitalCertiController.setShareVlaue(value as String);
                },
              ),
            ),
            const Spacer(),
            CustomButton(
              onTap: (_issueDigitalCertiController.selectedShareValue != null)
                  ? widget.onTap
                  : null,
              btnColor:
                  (_issueDigitalCertiController.selectedShareValue != null)
                      ? AppColors.greenColor
                      : AppColors.greyColor,
              borderColor:
                  (_issueDigitalCertiController.selectedShareValue != null)
                      ? AppColors.greenColor
                      : AppColors.greyColor1,
              btnText: 'Next',
              margin: const EdgeInsets.all(0.0),
            ),
          ],
        ),
      ),
    );
  }
}
