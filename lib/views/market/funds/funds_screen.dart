import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/widgets/small_chip_widget.dart';
import 'package:flutter/material.dart';

class FundsScreen extends StatefulWidget {
  const FundsScreen({Key? key}) : super(key: key);

  @override
  State<FundsScreen> createState() => _FundsScreenState();
}

class _FundsScreenState extends State<FundsScreen> {

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
          padding: const EdgeInsets.only(top: 20.0, bottom: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Tech Founder and Growth Equity Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TECH FOUNDER',
                      style: poppinsRegular.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkBlueColor2,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                          color: AppColors.darkBlueColor2,
                          width: 1.0,
                        ),
                      ),
                      child: Text('Growth Equity',
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

              /// tags row
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Wrap(
                  spacing: 5.0,
                  children: [
                    SmallChip(
                      onTap: (){},
                      chipText: 'Accenture',
                      chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                    ),
                    SmallChip(
                      onTap: (){},
                      chipText: 'Technology',
                      chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                    ),
                    SmallChip(
                      onTap: (){},
                      chipText: 'Europe',
                      chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                    ),
                    SmallChip(
                      onTap: (){},
                      chipText: 'Multi Asset',
                      chipColor: AppColors.darkBlueColor2.withOpacity(0.5),
                    ),
                  ],
                ),
              ),

              /// description texts
              const SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text('Target control-oriented growth equity and buyout investments in '
                    'software and technology enabled ibusiness services companies.',
                style: poppinsRegular.copyWith(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor2,
                ),
                ),
              ),

              /// open and minimum green Box
              const SizedBox(height: 5.0),
              Container(
                width: width,
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, left: 24.0, right: 20.0),
                color: AppColors.greenColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('OPEN',
                      style: poppinsRegular.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                        fontSize: 12.0,
                      ),
                    ),
                    Text('\$25000 Minimum',
                      style: poppinsRegular.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),

              /// gross ipr, size and gross multiple
              SizedBox(height: height * 0.016),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Gross IRR',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text('19%',
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
                        Text('Size',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text('\$5.8bn',
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
                        Text('Gross Multiple',
                          style: poppinsRegular.copyWith(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.greyColor2,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text('2.23',
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
