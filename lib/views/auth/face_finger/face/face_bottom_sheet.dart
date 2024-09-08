import 'dart:developer';

import 'package:bursa_flutter/Services/shared_pref_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../controllers/authcontroller.dart';
import '../../../../widgets/custom_button.dart';
import '../finger/all_set_dialog.dart';
import '../finger/scan_failed_dialog.dart';

class FaceBottomSheet extends StatefulWidget {
  const FaceBottomSheet({Key? key}) : super(key: key);

  @override
  State<FaceBottomSheet> createState() => _FaceBottomSheetState();
}

class _FaceBottomSheetState extends State<FaceBottomSheet> {
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
        Get.back();
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
    if (_authorized == "Authorized") {
      String? userName = SharedPrefService().getUserName();
      String? password = SharedPrefService().getPassword();

      if (userName != null && password != null) {
        Get.dialog(
          const AllSetDialog(),
          barrierDismissible: false,
        );
      } else {
        Get.dialog(const ScanFailedDialog(), barrierDismissible: false);
      }
    } else {
      //  Get.back();
      Get.dialog(const ScanFailedDialog(), barrierDismissible: false);
    }
    // Get.back();
    //     Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
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
            _authenticateWithBiometrics(_controller);
          },
          child: Text(
            _isAuthenticating
                ? 'Cancel'
                : 'Authenticate using Apple Face ID instead of \nentering your password',
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
            //   Get.to(const FaceScanScreen(),
            //   transition: Transition.rightToLeft,
            //   );
            // },
            onTap: () {
              _authenticateWithBiometrics(_controller);
            },
            btnText: 'Use Face ID',
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
