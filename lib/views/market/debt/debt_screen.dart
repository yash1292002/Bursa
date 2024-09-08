import 'package:flutter/material.dart';

import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({Key? key}) : super(key: key);

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.05),
        Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          padding: const EdgeInsets.only(top: 15.0, bottom: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Project Mundo and loan Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Project Mundo',
                      style: poppinsRegular.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBlueColor2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.darkBlueColor2,
                          width: 1.0,
                        ),
                      ),
                      child: Text(
                        'Loan',
                        style: poppinsRegular.copyWith(
                          color: AppColors.darkBlueColor2,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// description texts
              SizedBox(height: height * 0.016),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Lorem Ipsum is simply dummy text of the printing and'
                  ' typesetting industry.',
                  style: poppinsRegular.copyWith(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor2,
                  ),
                ),
              ),

              /// price and days left texts
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$50000 Target',
                      style: poppinsRegular.copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
                      ),
                    ),
                    Text(
                      '5 Days Left',
                      style: poppinsRegular.copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.greenColor,
                      ),
                    ),
                  ],
                ),
              ),

              /// green box
              SizedBox(height: height * 0.008),
              Container(
                width: width,
                padding: const EdgeInsets.only(
                    top: 4.0, bottom: 4.0, left: 24.0, right: 20.0),
                color: AppColors.greenColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '162%',
                      style: poppinsRegular.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

              /// raise, term and rate
              SizedBox(height: height * 0.016),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Raised',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '\$21289',
                          style: poppinsRegular.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Term',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '6 months',
                          style: poppinsRegular.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rate',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '6.7%',
                          style: poppinsRegular.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
