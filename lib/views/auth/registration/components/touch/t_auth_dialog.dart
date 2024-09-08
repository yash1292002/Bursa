import 'dart:async';
import 'dart:developer';

import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/app_images.dart';
import '../../../../../consts/color_const.dart';

class TAuthDialog extends StatefulWidget {
  const TAuthDialog({Key? key}) : super(key: key);

  @override
  State<TAuthDialog> createState() => _TAuthDialogState();
}

class _TAuthDialogState extends State<TAuthDialog> {
  @override
  void initState() {
    super.initState();

    /*Timer(
      const Duration(seconds: 3),
          () => Get.dialog(
        const TScanFieldDialog(),
        barrierDismissible: false,
      ),
    );*/
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
    Future.delayed(const Duration(seconds: 1), () {
      _authenticateWithBiometrics(_controller);
    });
  }

  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<void> _authenticateWithBiometrics(AuthController _controller) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error';
      });
    } on PlatformException catch (e) {
      log(e.toString());
      log(e.code);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    Get.back(result: _authorized == 'Authorized' ? true : false);
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// fingerprint auth text
              SizedBox(height: height * 0.14),
              Text(
                'Fingerprint Authentication',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              /// fingerprint auth desc
              SizedBox(height: height * 0.015),
              Text(
                'Touch Sensor',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.greyColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),

              /// fingerprint auth desc
              SizedBox(height: height * 0.015),
              // Text('Authenticate to access',
              //   style: GoogleFonts.poppins().copyWith(
              //     color: AppColors.greyColor,
              //     fontSize: 14.0,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              GestureDetector(
                onTap: () {
                  _authenticateWithBiometrics;
                },
                child: Text(
                  _isAuthenticating
                      ? 'Cancel'
                      : 'Authenticate: biometrics only',
                  style: GoogleFonts.poppins().copyWith(
                      color: AppColors.greyColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400),
                ),
              ),

              /// fingerprint auth sensor
              SizedBox(height: height * 0.015),
              GestureDetector(
                onTap: () {},
                // onTap: _authenticateWithBiometrics,
                // onTap: (){
                //   // Get.back();
                //   // Get.dialog(
                //   //   const TScanFieldDialog(),
                //   //   barrierDismissible: false,
                //   // );

                // },
                child: SvgPicture.asset(
                  AppImages.touchScanIcon,
                  height: height * 0.15,
                  width: height * 0.1,
                  fit: BoxFit.fill,
                ),
              ),

              /// cancel button
              SizedBox(height: height * 0.015),
              TextButton(
                onPressed: () {
                  Get.back(result: _authorized == 'Authorized' ? true : false);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greenColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
