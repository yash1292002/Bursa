import 'package:bursa_flutter/Services/shared_pref_services.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String? token = SharedPrefService().getToken();
    String? refreshToken = SharedPrefService().getRefreshToken();

    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);

    if (token != null && refreshToken != null) {
      if (token.isNotEmpty && refreshToken.isNotEmpty) {
        _controller.refreshToken().then((value) {
          _controller.getUserInfo().then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          });
        });
      }
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomeScreen(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: width * .07,
      ),
      child: Image.asset("assets/images/logo.png", width: width * 0.65),
    );
  }
}
