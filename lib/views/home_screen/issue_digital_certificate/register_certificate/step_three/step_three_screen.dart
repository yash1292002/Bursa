import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';
import '../../components/custom_field.dart';
import 'dart:io' as io;

class StepThreeScreen extends StatefulWidget {
  StepThreeScreen({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<StepThreeScreen> createState() => _StepThreeScreenState();
}

class _StepThreeScreenState extends State<StepThreeScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: false);

    _controller.dateOfEmploymentController.text =
        DateFormat("dd MMMM yyyy").format(DateTime.now());

    super.initState();
    AuthController _authcontroller =
        Provider.of<AuthController>(context, listen: false);
    _controller.setUserDetail(_authcontroller.userDetail!);

    //  selectedDate = _authcontroller.userDetail!.dateOfBirth!;
  }

  final FocusNode _nodeText1 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IssueDigitalCertiController _issueDigitalCertiController =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
    return KeyboardActions(
      config: _buildConfig(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      'Please review, edit or approve the below details !',
                      style: GoogleFonts.poppins().copyWith(
                        color: AppColors.lightBlueColor,
                        fontSize: 16.0,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    /// first and middle name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomField(
                            controller: _issueDigitalCertiController
                                .firstNameController,
                            hintText: 'First Name',
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        // SizedBox(width: width * 0.1),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    /// last name and company name
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomField(
                            controller: _issueDigitalCertiController
                                .companyNameController,
                            hintText: 'Company Name',
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    /// birth date and number share
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: width * .0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // showDatePicker(
                                    //   context: context,
                                    //   initialDate: DateTime.now(),
                                    //   firstDate: DateTime(1990),
                                    //   lastDate: DateTime.now(),
                                    //   helpText: '${DateTime.now()}',
                                    // ).then((value) {
                                    //   if (value != null) {
                                    //     selectedDate = value;
                                    //     _issueDigitalCertiController
                                    //             .dateOfEmploymentController
                                    //             .text =
                                    //         DateFormat("dd MMM yyyy")
                                    //             .format(selectedDate!);
                                    //     setState(() {});
                                    //   }
                                    // });
                                  },
                                  child: SizedBox(
                                    height: 50.0,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _issueDigitalCertiController
                                                .selectedShareValue!
                                                .dateOfGrant!,
                                            style: poppinsRegular.copyWith(
                                              color: blackColor,
                                              fontSize: width * .036,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          color: blackColor,
                                          size: width * .055,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 1,
                                    color: lightBlueColorWithopacity30)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.1),
                        Expanded(
                          child: io.Platform.isAndroid
                              ? CustomField(
                                  controller: _issueDigitalCertiController
                                      .shareNumberController,
                                  // focusNode: _nodeText1,
                                  hintText: 'Number of Shares',
                                  keyboardType: TextInputType.number,
                                )
                              : CustomField(
                                  controller: _issueDigitalCertiController
                                      .shareNumberController,
                                  focusNode: _nodeText1,
                                  hintText: 'Number of Shares',
                                  keyboardType: TextInputType.number,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),

                    /// confirm detail button
                  ],
                ),
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 18.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Disclosure Agreement',
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12.0,
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width * .03, right: 0),
                        child: FlutterSwitch(
                          width: width * .1,
                          height: width * .05,
                          toggleSize: width * .04,
                          value: _issueDigitalCertiController.isAgree,
                          toggleColor: greenColor,
                          borderRadius: width * .03,
                          activeColor: greenColorWithOpacity20,
                          inactiveColor: lightGreyColor,
                          padding: width * .006,
                          onToggle: (val) {
                            _issueDigitalCertiController.setIsAgree(val);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  stepRow(
                      'Concent to the terms of the E-Sign Consent Agreement'),
                  stepRow(
                      'Have been advised to print or save a copy of the agreement for my records.'),
                  stepRow(
                      'Agree to recieve required disclosures and communications electronically from Bursa Security Services.'),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Container(
              height: 45,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              child: CustomButton(
                onTap: (_issueDigitalCertiController.isAgree &&
                        _issueDigitalCertiController
                            .firstNameController.text.isNotEmpty &&
                        _issueDigitalCertiController
                            .companyNameController.text.isNotEmpty &&
                        _issueDigitalCertiController
                            .shareNumberController.text.isNotEmpty &&
                        _issueDigitalCertiController
                            .dateOfEmploymentController.text.isNotEmpty)
                    ? () {
                        widget.onTap();

                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    : null,
                btnText: 'Click to Sign',
                margin: const EdgeInsets.symmetric(horizontal: 0.0),
                btnColor: (_issueDigitalCertiController.isAgree)
                    ? AppColors.greenColor
                    : greyColor,
                borderColor: (_issueDigitalCertiController.isAgree)
                    ? AppColors.greenColor
                    : AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stepRow(text) => Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 4.0,
              width: 4.0,
              margin: const EdgeInsets.only(top: 4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyStepColor,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 10.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}
