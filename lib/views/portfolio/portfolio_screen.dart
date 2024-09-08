import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/portfolio/components/graph_data.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import 'my_holding_screen.dart';
import 'my_transaction.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  late List<charts.Series<Pollution, String>> _seriesData;
  late List<charts.Series<Sales, int>> _seriesLineData;
  _generateData() {
    var data1 = [
      Pollution(1980, 'Jan', int.parse('${25000}'.toString())),
      Pollution(1980, 'Feb', int.parse('${50000}'.toString())),
      Pollution(1980, 'March', int.parse('${65000}'.toString())),
      Pollution(1980, 'April', int.parse('${35000}'.toString())),
      Pollution(1980, 'May', int.parse('${65000}'.toString())),
      Pollution(1980, 'June', int.parse('${75000}'.toString())),
      // new Pollution(1980, 'Asia', 40),
      // new Pollution(1980, 'Europe', 10),
    ];
    var data2 = [
      Pollution(1980, 'Feb', int.parse('${25000}'.toString())),
      Pollution(1980, 'March', int.parse('${45000}'.toString())),
      Pollution(1980, 'April', int.parse('${35000}'.toString())),
    ];

    var linesalesdata = [
      new Sales(0, 45),
      new Sales(1, 56),
      new Sales(2, 55),
      new Sales(3, 60),
      new Sales(4, 61),
      new Sales(5, 70),
    ];
    var linesalesdata1 = [
      new Sales(0, 0),
      new Sales(1, 10),
      new Sales(2, -20),
      new Sales(3, 30),
      new Sales(4, 35),
      new Sales(5, 60),
    ];

    // var linesalesdata2 = [
    //   new Sales(0, 20),
    //   new Sales(1, 24),
    //   new Sales(2, 25),
    //   new Sales(3, 40),
    //   new Sales(4, 45),
    //   new Sales(5, 60),
    // ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(AppColors.lightBlueColor),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Colors.orange),
      ),
    );

    // _seriesData.add(
    //   charts.Series(
    //     domainFn: (Pollution pollution, _) => pollution.place,
    //     measureFn: (Pollution pollution, _) => pollution.quantity,
    //     id: '2019',
    //     data: data3,
    //     fillPatternFn: (_, __) => charts.FillPatternType.solid,
    //     fillColorFn: (Pollution pollution, _) =>
    //         charts.ColorUtil.fromDartColor(Color(0xffff9900)),
    //   ),
    // );

    // _seriesPieData.add(
    //   charts.Series(
    //     domainFn: (Task task, _) => task.task,
    //     measureFn: (Task task, _) => task.taskvalue,
    //     colorFn: (Task task, _) =>
    //         charts.ColorUtil.fromDartColor(task.colorval),
    //     id: 'Air Pollution',
    //     data: piedata,
    //     labelAccessorFn: (Task row, _) => '${row.taskvalue}',
    //   ),
    // );

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) =>
            charts.ColorUtil.fromDartColor(AppColors.lightBlueColor),
        id: 'Air Pollution',
        data: linesalesdata,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Colors.orange),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    // _seriesLineData.add(
    //   charts.Series(
    //     colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
    //     id: 'Air Pollution',
    //     data: linesalesdata2,
    //     domainFn: (Sales sales, _) => sales.yearval,
    //     measureFn: (Sales sales, _) => sales.salesval,
    //   ),
    // );
  }

// @override
// void initState() {
// ignore: todo
//   // TODO: implement initState
//   super.initState();
//   // _seriesData = List<charts.Series<Pollution, String>>();
//   // ignore: deprecated_member_use
//   _seriesData = <charts.Series<Pollution, String>>[];
//   // _seriesPieData = <charts.Series<Task, String>>[];
//   // _seriesLineData = <charts.Series<Sales, int>>[];
//   _generateData();
// }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = <charts.Series<Pollution, String>>[];
    _seriesLineData = <charts.Series<Sales, int>>[];
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 300),
              reverseDuration: const Duration(milliseconds: 300),
              type: PageTransitionType.rightToLeft,
              child: const HomeScreen(),
            ),
            (route) => false);
        return false;
      },
      child: Container(
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
                padding: const EdgeInsets.only(left: 6.0),
                child: Image.asset('assets/icons/back_button.png'),
              ),
            ),
            title: Text(
              'Portofolio',
              style: poppinsRegular.copyWith(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
          ),

          /// body
          body: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// portfolio balance row
                SizedBox(height: height * 0.04),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Portfolio Balance',
                            style: poppinsRegular.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.0,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          const SizedBox(height: 3.0),
                          Text(
                            '\$1,298.91',
                            style: poppinsRegular.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(32.0),
                        child: Ink(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32.0, vertical: 11.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: AppColors.whiteColor,
                          ),
                          child: Text(
                            'Invest',
                            style: poppinsRegular.copyWith(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// current portfolio box
                SizedBox(height: height * 0.04),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: height * 0.02,
                      top: height * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// my transactions and my holdings button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    type: PageTransitionType.rightToLeft,
                                    child: const MyTransactionScreen(),
                                  ),
                                );
                              },
                              btnText: 'My Transactions',
                              btnTextSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: CustomButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    duration: const Duration(milliseconds: 300),
                                    reverseDuration:
                                        const Duration(milliseconds: 300),
                                    type: PageTransitionType.rightToLeft,
                                    child: const MyHoldingScreen(),
                                  ),
                                );
                              },
                              btnText: 'My Holdings',
                              btnTextSize: 12.0,
                            ),
                          ),
                        ],
                      ),

                      /// current portfolio texts
                      SizedBox(height: height * 0.035),
                      Text(
                        'Current Portfolio',
                        style: poppinsRegular.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                          color: AppColors.lightBlueColor,
                        ),
                      ),

                      /// risk level, earnings and returns row
                      SizedBox(height: height * 0.015),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          cPortfolioData('Risk level', 'Conservative'),
                          Container(
                            height: 27.0,
                            width: 0.5,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            color: AppColors.lightBlueColor.withOpacity(0.3),
                          ),
                          cPortfolioData('Earnings', '\$3.04'),
                          cPortfolioData('Returns', '0.23%'),
                        ],
                      ),

                      /// graph with data
                      SizedBox(height: height * 0.03),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 120,
                            width: 130.0,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: PieChart(
                              initialAngleInDegree: 270.0,
                              ringStrokeWidth: 16.0,
                              dataMap: const {
                                "europe": 42,
                                "latin": 5,
                                "emerg": 5,
                                "usFin": 20,
                                "ustech": 28,
                              },
                              chartType: ChartType.ring,
                              legendOptions: const LegendOptions(
                                showLegends: false,
                              ),
                              baseChartColor: AppColors.blueDarkColor,
                              colorList: const [
                                AppColors.darkBlueColor,
                                AppColors.blueAccentColor,
                                AppColors.redAccentColor,
                                AppColors.yellowAccentColor,
                                AppColors.greenAccentColor,
                              ],
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: false,
                                showChartValues: false,
                              ),
                              totalValue: 100,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const GraphData(
                                  boxColor: AppColors.darkBlueColor,
                                  text: 'Europe value',
                                  percentText: '42%',
                                ),
                                SizedBox(height: height * 0.016),
                                const GraphData(
                                  boxColor: AppColors.greenAccentColor,
                                  text: 'US tech',
                                  percentText: '28%',
                                ),
                                SizedBox(height: height * 0.016),
                                const GraphData(
                                  boxColor: AppColors.yellowAccentColor,
                                  text: 'US financials',
                                  percentText: '20%',
                                ),
                                SizedBox(height: height * 0.016),
                                const GraphData(
                                  boxColor: AppColors.redAccentColor,
                                  text: 'Emerging Market b...',
                                  percentText: '5%',
                                ),
                                SizedBox(height: height * 0.016),
                                const GraphData(
                                  boxColor: AppColors.blueAccentColor,
                                  text: 'Latin america',
                                  percentText: '5%',
                                ),
                                SizedBox(height: height * 0.016),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /// Advanced information button
                      SizedBox(height: height * 0.04),
                      CustomButton(
                        onTap: () {},
                        btnText: 'Advanced information',
                        btnColor: AppColors.whiteColor,
                        btnTextColor: AppColors.lightBlueColor,
                        borderColor: AppColors.lightBlueColor,
                        btnHeight: 40.0,
                        borderRadius: 15.0,
                        btnTextSize: 11.0,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ],
                  ),
                ),

                /// projected gains graph box

                // SizedBox(height: height * 0.016),
                SizedBox(height: height * 0.016),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: EdgeInsets.only(
                      left: 16.0, bottom: height * 0.02, top: height * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * .35,
                          width: width,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                // Text(
                                //   'SO₂ emissions, by world region (in million tonnes)',
                                //   style: TextStyle(
                                //       fontSize: 24.0,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                Expanded(
                                  child: charts.BarChart(
                                    _seriesData,
                                    animate: true,
                                    barGroupingType:
                                        charts.BarGroupingType.grouped,
                                    //behaviors: [new charts.SeriesLegend()],
                                    animationDuration:
                                        const Duration(seconds: 3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 13.0,
                            width: 13.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          const Text("Investment",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightBlueColor)),
                          SizedBox(width: width * 0.03),
                          Container(
                            height: 13.0,
                            width: 13.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          const Text("Exist",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightBlueColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.016),
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: EdgeInsets.only(
                      left: 16.0, bottom: height * 0.02, top: height * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(11.0),
                    color: AppColors.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: height * .6,
                          width: width,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                // Text(
                                //   'SO₂ emissions, by world region (in million tonnes)',
                                //   style: TextStyle(
                                //       fontSize: 24.0,
                                //       fontWeight: FontWeight.bold),
                                // ),
                                Expanded(
                                  child: charts.LineChart(_seriesLineData,
                                      defaultRenderer:
                                          new charts.LineRendererConfig(
                                              includeArea: true, stacked: true),
                                      animate: true,
                                      animationDuration: Duration(seconds: 5),
                                      behaviors: []),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 13.0,
                            width: 13.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          const Text("Investment",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightBlueColor)),
                          SizedBox(width: width * 0.03),
                          Container(
                            height: 13.0,
                            width: 13.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(width: width * 0.01),
                          const Text("Exist",
                              style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.lightBlueColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cPortfolioData(headText, bottomText) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              headText,
              style: poppinsRegular.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.0,
                color: AppColors.lightBlueColor,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              bottomText,
              style: poppinsRegular.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                color: AppColors.lightBlueColor,
              ),
            ),
          ],
        ),
      );
}

class Pollution {
  String place;
  int year;
  int quantity;

  Pollution(this.year, this.place, this.quantity);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
