import 'package:expense_tracker_app/components/loans.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker_app/const/theme.dart';

class LoanScreen extends StatefulWidget {
  LoanScreen({super.key});

  @override
  State<LoanScreen> createState() => _LoanScreenState();
}

class _LoanScreenState extends State<LoanScreen> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.sizeOf(context).width;
    var payable = 8000;
    var receivable = 3621;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Loan Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  width: screenWidth,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Color(0xff1F1F1F),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                          padding: EdgeInsets.all(5),
                          labelColor: Colors.white,
                          controller: tabController,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.zero,
                          indicator: BoxDecoration(
                              color: myblue,
                              borderRadius: BorderRadius.circular(5)),
                          tabs: [
                            Tab(
                              text: 'Payable',
                            ),
                            Tab(
                              text: 'Receivable',
                            ),
                            Tab(
                              text: 'History',
                            ),
                          ],
                        ),
                      )
                    ],
                    
                  )),
            ),
            SizedBox(
              height: 14,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 180,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : Color(0xff1F1F1F),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PieChart(
                      dataMap: {
                        "Payable": double.parse(payable.toString()),
                        "Recieved": double.parse(receivable.toString()),
                      },
                      animationDuration: Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      chartRadius: screenWidth / 3.5,
                      ringStrokeWidth: 40,
                      colorList: [myRed, myGreen],
                      legendOptions:
                          LegendOptions(legendPosition: LegendPosition.left),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("12 Jan 2024"),
                ],
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Column(
              children: [
                Loans(
                    name: "Trump",
                    imgPath: "assets/arrow-up.png",
                    price: "\$31.1",
                    time: "06:45 PM"),
                Loans(
                    name: "Trump",
                    imgPath: "assets/arrow-down.png",
                    price: "\$31.1",
                    time: "06:45 PM"),
                Loans(
                    name: "Trump",
                    imgPath: "assets/arrow-down.png",
                    price: "\$31.1",
                    time: "06:45 PM"),
                Loans(
                    name: "Trump",
                    imgPath: "assets/arrow-down.png",
                    price: "\$31.1",
                    time: "06:45 PM"),
                Loans(
                    name: "Trump",
                    imgPath: "assets/arrow-down.png",
                    price: "\$31.1",
                    time: "06:45 PM"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
