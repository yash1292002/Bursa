import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../../consts/app_images.dart';
import '../../../../../consts/color_const.dart';
import '../../../../../widgets/custom_button.dart';

class FBottomSheet extends StatefulWidget {
  const FBottomSheet({Key? key}) : super(key: key);

  @override
  State<FBottomSheet> createState() => _FBottomSheetState();
}

class _FBottomSheetState extends State<FBottomSheet> {
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  Future<void> _authenticateWithBiometrics() async {
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
        // Get.back(result: false);
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
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16.0),
        Container(
          height: 2.0,
          width: 90.0,
          decoration: BoxDecoration(
            color: AppColors.greyColor.withOpacity(0.3),
          ),
        ),

        /// close button
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(AppImages.closeIcon),
          ),
        ),

        /// login text ID text
        Text(
          'Login with Face ID',
          style: GoogleFonts.poppins().copyWith(
            color: AppColors.greenColor,
            fontSize: width * .058,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 28.0),

        /// touch sensor
        SvgPicture.asset(
          AppImages.faceScanIcon,
          height: height * 0.14,
          width: height * 0.14,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 28.0),

        /// touch sensor description
        // Text('Authenticate using Apple’s Touch ID instead of \nentering your password',
        //   textAlign: TextAlign.center,
        //   style: GoogleFonts.poppins().copyWith(
        //     color: AppColors.greyColor,
        //     fontSize: 13.0,
        //     fontWeight: FontWeight.w500,
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            _authenticateWithBiometrics;
          },
          child: Text(
            _isAuthenticating
                ? 'Cancel'
                : 'Authenticate using Apple’s Face ID instead of \nentering your password',
            style: GoogleFonts.poppins().copyWith(
                color: AppColors.greyColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),

        /// use touch ID buton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
          child: CustomButton(
            // onTap: (){
            //   Get.back();
            //   // Get.to(const FScanScreen(),
            //   //   transition: Transition.rightToLeft,
            //   // );

            // },
            onTap: _authenticateWithBiometrics,
            btnText: 'Use Face ID',
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
