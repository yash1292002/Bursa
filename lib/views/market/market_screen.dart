import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/market/debt/debt_screen.dart';
import 'package:bursa_flutter/views/market/equity/equity_screen.dart';
import 'package:bursa_flutter/views/market/funds/funds_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import 'components/tab_button.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key? key}) : super(key: key);

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  bool? isEquity = true;
  bool? isDebt = false;
  bool? isFunds = false;

  void isEquityActive() {
    setState(() {
      isEquity = true;
      isDebt = false;
      isFunds = false;
    });
  }

  void isDebtActive() {
    setState(() {
      isEquity = false;
      isDebt = true;
      isFunds = false;
    });
  }

  void isFundsActive() {
    setState(() {
      isEquity = false;
      isDebt = false;
      isFunds = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      /// gradient background
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
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.leftToRight,
                    child: const HomeScreen(),
                  ),
                  (route) => false);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/icons/back_button.png'),
            ),
          ),
          title: Text(
            'Investment Opportunities',
            style: poppinsRegular.copyWith(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),

        /// body
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Equity, Debt and Funds tab
            SizedBox(height: height * 0.03),
            Container(
              width: width,
              height: 40.0,
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.whiteColor.withOpacity(0.1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TabButton(
                    onTap: isEquityActive,
                    tabText: 'Equity',
                    tabBackColor: isEquity == true
                        ? AppColors.whiteColor
                        : Colors.transparent,
                    tabDataColor: isEquity == true
                        ? AppColors.greenColor
                        : AppColors.whiteColor,
                  ),
                  TabButton(
                    onTap: isDebtActive,
                    tabText: 'Debt',
                    tabBackColor: isDebt == true
                        ? AppColors.whiteColor
                        : Colors.transparent,
                    tabDataColor: isDebt == true
                        ? AppColors.greenColor
                        : AppColors.whiteColor,
                  ),
                  TabButton(
                    onTap: isFundsActive,
                    tabText: 'Funds',
                    tabBackColor: isFunds == true
                        ? AppColors.whiteColor
                        : Colors.transparent,
                    tabDataColor: isFunds == true
                        ? AppColors.greenColor
                        : AppColors.whiteColor,
                  ),
                ],
              ),
            ),

            /// all screens according to the tabs
            isFunds == true
                ? const FundsScreen()
                : isDebt == true
                    ? const DebtScreen()
                    : const EquityScreen(),
          ],
        ),
      ),
    );
  }
}
