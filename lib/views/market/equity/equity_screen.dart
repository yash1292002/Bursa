import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/views/market/equity/primary_offer/primary_offer_screen.dart';
import 'package:bursa_flutter/views/market/equity/seconday_offer/secondary_offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EquityScreen extends StatefulWidget {
  const EquityScreen({Key? key}) : super(key: key);

  @override
  State<EquityScreen> createState() => _EquityScreenState();
}

class _EquityScreenState extends State<EquityScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: true);
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// primary earning and secondary offering tabs
          SizedBox(height: height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.whiteColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.whiteColor,
                tabs: const [
                  Tab(
                    text: "Primary Offerings",
                  ),
                  Tab(
                    text: "Secondary Offerings",
                  ),
                ],
                labelColor: whiteColor,
                labelStyle: poppinsRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
                unselectedLabelColor: AppColors.whiteColor.withOpacity(0.5),
                unselectedLabelStyle: poppinsRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),

          /// TabBar view for both screens
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PrimaryOfferScreen(),
                SecondaryOfferScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
