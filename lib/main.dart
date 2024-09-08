import 'package:bursa_flutter/Services/shared_pref_services.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/controllers/profileController.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/splash_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefService.init();
  // await FlutterDownloader.initialize(
  //     debug: true // optional: set false to disable printing logs to console
  //     );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //intialization Auth Controller
          ChangeNotifierProvider(create: (_) => AuthController()),
          //intialization RegisterShareController
          ChangeNotifierProvider(create: (_) => RegisterShareController()),
          // initialization issueDdigitalCertificat
          ChangeNotifierProvider(create: (_) => IssueDigitalCertiController()),
          // Initialization ProfileController
          ChangeNotifierProvider(create: (_) => ProfileController()),
          // Initialization OfferShareController
          ChangeNotifierProvider(create: (_) => OfferShareController()),
          // Initialization PrimaryOfferController
          ChangeNotifierProvider(create: (_) => PrimaryOfferController())
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bursa App',

          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),

          routes: {
            "/home": (ctx) => const HomeScreen(),
          },
          home: const SplashScreen(),
          // home: const PersisNavBar(),
          // home: const AuthenticationDashBoardScreen(),
          // home: const WelcomeScreen(),
        ));
  }
}
