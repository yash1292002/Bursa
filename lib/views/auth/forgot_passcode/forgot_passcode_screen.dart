import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/auth/signin/verification_secound_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../Services/api_services.dart';
import '../../../consts/strings.dart';
import '../../../widgets/dialogs/status_faild_dialog.dart';
import '../../../widgets/dialogs/status_success_dialog.dart';

class ForgotPasscodeScreen extends StatefulWidget {
  const ForgotPasscodeScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasscodeScreen> createState() => _ForgotPasscodeScreenState();
}

class _ForgotPasscodeScreenState extends State<ForgotPasscodeScreen> {
  @override
  void initState() {
    super.initState();

    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);

    _authController.resetLoginInfo();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: transparentColor,
            resizeToAvoidBottomInset: false,

            /// Appbar
            appBar: AppBar(
              backgroundColor: transparentColor,
              elevation: 0.0,
              leadingWidth: 60.0,
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
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.12),

                  /// welcome text
                  Text(
                    'Forgot Passcode?',
                    style: poppinsRegular.copyWith(
                      color: whiteColor,
                      fontSize: width * .05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8.0),

                  /// signin continue text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Please enter your Email address or Mobile number. '
                      'We will generate a new Passcode and send it to your registered Email Address.',
                      textAlign: TextAlign.center,
                      style: poppinsRegular.copyWith(
                        color: whiteColor,
                        fontSize: width * .045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  /// email or mobile number field
                  SizedBox(height: height * 0.06),
                  Container(
                    margin: EdgeInsets.only(
                      top: height * .1,
                      left: width * .08,
                      right: width * .08,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          width * .015,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: height * .02,
                      bottom: height * .015,
                      left: width * .03,
                      right: width * .03,
                    ),
                    child: TextFormField(
                      controller: _authController.emialOrPhoneController,
                      style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .035,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                      decoration: InputDecoration(
                        label: Text(
                          "Email Address or Mobile number",
                          style: poppinsRegular.copyWith(
                            color: lightBlueColorWithopacity40,
                            fontSize: width * .035,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: width * .01,
                          right: width * .01,
                        ),
                      ),
                    ),
                  ),

                  /// login button
                  GestureDetector(
                    onTap: isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading = true;
                            });

                            bool status = await ApiServices()
                                .verifyEmailOrPhone(_authController
                                    .emialOrPhoneController.text);

                            if (!status) {
                              Get.dialog(
                                  const StatusFailedDialog(
                                      text: AppStrings.unableToIdentify),
                                  barrierDismissible: false);

                              setState(() {
                                isLoading = false;
                              });
                              return;
                            }

                            await _authController
                                .forgetPassCodes()
                                .then((value) {
                              if (value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (_authController
                                    .emialOrPhoneController.text.isNotEmpty) {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => const VerificationScreen(),
                                  // ));
                                  /* Navigator.push(
                          context,
                          PageTransition(
                            duration: Duration(milliseconds: 300),
                            reverseDuration: Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: VerificationSecoundScreen(),
                          ),
                        );*/
                                  Get.dialog(
                                    StatusSuccessDialog(
                                      text: AppStrings.generateANewPasscode,
                                      onTap: () {
                                        Navigator.of(context).pop();

                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            reverseDuration: const Duration(
                                                milliseconds: 300),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child:
                                                const VerificationSecoundScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Please enter mobile number or email",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: whiteColor,
                                    textColor: greenColor,
                                    fontSize: width * .035,
                                  );
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          },
                    child: Container(
                      height: width * .11,
                      margin: EdgeInsets.only(
                        top: width * .03,
                        left: width * .08,
                        right: width * .08,
                      ),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(width * .015),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: isLoading
                          ? CircularProgressIndicator(color: whiteColor)
                          : Text(
                              "Submit",
                              style: poppinsRegular.copyWith(
                                color: whiteColor,
                                fontSize: width * .036,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: width * .05,
                  ),
                  child: Image.asset("assets/images/logo.png",
                      width: width * 0.53),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
