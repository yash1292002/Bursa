// import 'package:bursa_flutter/views/home_screen/offer_shares/add_share_request/add_share_request_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
// import 'package:provider/provider.dart';

// import '../../../consts/app_images.dart';
// import '../../../consts/color_const.dart';
// import '../../../consts/textstyle_const.dart';
// import '../../../controllers/offer_share_controller.dart';
// import '../../../models/bid_model.dart';
// import '../../../widgets/custom_button.dart';
// import '../../../widgets/small_chip_widget.dart';
// import '../issue_digital_certificate/components/card_texts_widget.dart';
// import 'share_request_detail.dart';

// class ShareRequestScreen extends StatefulWidget {
//   const ShareRequestScreen({Key? key}) : super(key: key);

//   @override
//   State<ShareRequestScreen> createState() => _ShareRequestScreenState();
// }

// class _ShareRequestScreenState extends State<ShareRequestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     var offerShareController = Provider.of<OfferShareController>(context);

//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             AppColors.blueColor,
//             AppColors.greenColor,
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: AppColors.transparentColor,

//         /// Appbar
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           leadingWidth: 60.0,
//           leading: IconButton(
//             onPressed: () {
//               //Get.offAll(const PersisNavBar());
//               Navigator.pop(context);
//             },
//             icon: Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Image.asset('assets/icons/back_button.png'),
//             ),
//           ),
//           centerTitle: true,
//           title: Text(
//             "Share Request",
//             style: poppinsRegular.copyWith(
//               color: AppColors.white1,
//               fontWeight: FontWeight.w600,
//               fontSize: 16.0,
//             ),
//           ),
//         ),

//         body: Padding(
//           padding: EdgeInsets.only(top: 24, bottom: height * 0.15),
//           child: FutureBuilder<List<OfferShareBid>?>(
//             future: offerShareController.getOfferShares(),
//             builder: (context, snapshot){
//               if (snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
//                 return Center(child: CircularProgressIndicator(),);
//               }

//               return ListView.builder(
//                 itemCount: snapshot.data?.length,
//                 itemBuilder: (context, i){
//                   OfferShareBid offerShareBid = snapshot.data![i];

//                   if (!offerShareBid.isPayed){
//                     return SizedBox.shrink();
//                   }

//                   return GestureDetector(
//                     onTap: () {
//                       pushNewScreen(context,
//                           screen: ShareRequestDetail(offerShareBid: offerShareBid,), withNavBar: true);
//                     },
//                     child: Container(
//                       width: width,
//                       padding: const EdgeInsets.only(
//                           left: 18.0, right: 18.0, top: 24.0, bottom: 30.0),
//                       margin: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15.0),
//                         color: AppColors.white1,
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.network(offerShareBid.logo,
//                               height: 45.0, width: 45.0, fit: BoxFit.fill),
//                           const SizedBox(width: 12.0),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         offerShareBid.companyName,
//                                         style: GoogleFonts.poppins().copyWith(
//                                           color: AppColors.lightBlueColor,
//                                           fontSize: 14.0,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                     SmallChip(
//                                       onTap: () {},
//                                       chipText: 'Payment Done',
//                                       chipColor: AppColors.greenColor1,
//                                     ),
//                                     const SizedBox(width: 5.0),
//                                     SmallChip(
//                                       onTap: () {},
//                                       chipText: 'Auction',
//                                       chipColor: AppColors.lightBlue1,
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(height: 16.0),
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children:[
//                                     Expanded(
//                                       child: CardTextsWidget(
//                                         titleText: 'Quantity Share',
//                                         descText: offerShareBid.quantity.toString(),
//                                       ),
//                                     ),
//                                     SizedBox(width: 12.0),
//                                     Expanded(
//                                       child: CardTextsWidget(
//                                         titleText: 'Offer Price',
//                                         descText: '\$${offerShareBid.offerPrice}',
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: CardTextsWidget(
//                                         titleText: 'Limit Offer',
//                                         descText: offerShareBid.offerTimeLimit,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               PageTransition(
//                 duration: Duration(milliseconds: 300),
//                 reverseDuration: Duration(milliseconds: 300),
//                 type: PageTransitionType.rightToLeft,
//                 child: AddShareRequestScreen(),
//               ),
//             );
//           },
//           child: Container(
//             margin: EdgeInsets.only(bottom: height * .025),
//             height: height * .054,
//             width: width * .88,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               // color: blackColor,
//               borderRadius: BorderRadius.circular(08),
//               color: AppColors.whiteColor.withOpacity(0.1),
//               border: Border.all(
//                 color: AppColors.whiteColor.withOpacity(0.1),
//                 // width: 1,
//               ),
//             ),
//             child: Text(
//               "Add your share request",
//               style: poppinsRegular.copyWith(
//                   fontSize: width * .036,
//                   fontWeight: FontWeight.w500,
//                   color: whiteColor),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
