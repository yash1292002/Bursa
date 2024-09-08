// import 'package:bursa_flutter/consts/color_const.dart';
// import 'package:bursa_flutter/views/insights/insights.dart';
// import 'package:bursa_flutter/views/market/market_screen.dart';
// import 'package:bursa_flutter/views/portfolio/portfolio_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// import 'home_screen/home_screen.dart';

// class PersisNavBar extends StatefulWidget {
//   const PersisNavBar({Key? key}) : super(key: key);

//   @override
//   _PersisNavBarState createState() => _PersisNavBarState();
// }

// class _PersisNavBarState extends State<PersisNavBar> {
//   final PersistentTabController? _controller =
//       PersistentTabController(initialIndex: 0);

//   List<Widget> _buildScreens() {
//     return [
//       const HomeScreen(),
//       const MarketScreen(),
//       const Insights(),
//       const PortfolioScreen(),
//     ];
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems() {
//     return [
//       PersistentBottomNavBarItem(
//         icon: Image.asset('assets/icons/homeicon.png', color: greenColor),
//         inactiveIcon:
//             Image.asset('assets/icons/homeicon.png', color: greyColor),
//         title: "Home",
//         activeColorPrimary: greenColor,
//         inactiveColorPrimary: greyColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset('assets/icons/marketicon.png', color: greenColor),
//         inactiveIcon:
//             Image.asset('assets/icons/marketicon.png', color: greyColor),
//         title: "Market",
//         activeColorPrimary: greenColor,
//         inactiveColorPrimary: greyColor,
//       ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset(
//           'assets/icons/insights.png',
//           color: greenColor,
//         ),
//         inactiveIcon: Image.asset(
//           'assets/icons/insights.png',
//           color: greyColor,
//         ),
//         title: "Insights",
//         activeColorPrimary: greenColor,
//         inactiveColorPrimary: greyColor,
//       ),
//       // PersistentBottomNavBarItem(
//       //   icon: Image.asset('assets/icons/pricing.png', color: greenColor),
//       //   inactiveIcon: Image.asset('assets/icons/pricing.png', color: greyColor),
//       //   title: "Pricing",
//       //   activeColorPrimary: greenColor,
//       //   inactiveColorPrimary: greyColor,
//       // ),
//       PersistentBottomNavBarItem(
//         icon: Image.asset('assets/icons/portfolioicon.png', color: greenColor),
//         inactiveIcon:
//             Image.asset('assets/icons/portfolioicon.png', color: greyColor),
//         title: "Portfolio",
//         activeColorPrimary: greenColor,
//         inactiveColorPrimary: greyColor,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       controller: _controller,
//       screens: _buildScreens(),
//       items: _navBarsItems(),
//       confineInSafeArea: true,
//       //padding: const NavBarPadding.symmetric(horizontal: 8.0, vertical: 16.0),
//       padding: const NavBarPadding.only(left: 8.0, right: 8.0, top: 12.0),
//       backgroundColor: Colors.white,
//       handleAndroidBackButtonPress: true,
//       stateManagement: true,
//       hideNavigationBarWhenKeyboardShows: true,
//       decoration: const NavBarDecoration(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(24.0),
//           topLeft: Radius.circular(24.0),
//         ),
//       ),
//       navBarHeight: 70.0,
//       popAllScreensOnTapOfSelectedTab: true,
//       popActionScreens: PopActionScreensType.all,
//       itemAnimationProperties: const ItemAnimationProperties(
//         duration: Duration(milliseconds: 200),
//         curve: Curves.ease,
//       ),
//       screenTransitionAnimation: const ScreenTransitionAnimation(
//         animateTabTransition: true,
//         curve: Curves.ease,
//         duration: Duration(milliseconds: 200),
//       ),
//       navBarStyle: NavBarStyle.style6,
//     );
//   }
// }
