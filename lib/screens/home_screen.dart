// ignore_for_file: unnecessary_const

import 'package:expense_tracker_app/components/home_buttons.dart';
import 'package:expense_tracker_app/components/transactions.dart';
import 'package:expense_tracker_app/screens/add_expense.dart';
import 'package:expense_tracker_app/screens/loan_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/services/theme_mode.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker_app/const/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:expense_tracker_app/screens/transactions/all_transactions.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
        leading: GestureDetector(
            onTap: () {
              ThemeServices().SwitchTheme();
            },
            child: const Icon(Icons.nightlight)),
            
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Item 2'),
              onTap: (){},
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: (){},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  children: [
                    const Expanded(
                      child: ListTile(
                        leading: CircleAvatar(
                                      backgroundImage: AssetImage('assets/user.png'),
                                    ),
                        title: Text('Hello Welcome!',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w100),),
                        subtitle: Text('Smith Steven',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Builder(builder: (context)=> IconButton(
                      onPressed: (){
                        Scaffold.of(context).openEndDrawer();
                      }, icon: const Icon(Icons.notifications))),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(Ionicons.ellipsis_horizontal),
                  ],
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  width: screenWidth,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).brightness == Brightness.light
                        ? myblue
                        : const Color(0xff1F1F1F),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      'Available Balance',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const Text(
                      '\$1,398.00',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Column(
                          children: [
                            LinearPercentIndicator(
                              lineHeight: 5,
                              percent: 0.3,
                              progressColor: const Color(0xffFFB800),
                              backgroundColor: Colors.white,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$301 spent',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                                Text(
                                  'out of \$500',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ]),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomHomeButton(
                    imgPath: 'assets/wallet.png',
                    text: 'Add Income',
                  ),
                  CustomHomeButton(
                    imgPath: 'assets/expenses.png',
                    text: 'Add Expanse',
                  ),
                  CustomHomeButton(
                    imgPath: 'assets/investment.png',
                    text: 'Investment',
                  ),
                ],
              ),
              const SizedBox(
                height: 29,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomHomeButton(
                    imgPath: 'assets/budget.png',
                    text: 'Add Income',
                  ),
                  CustomHomeButton(
                    imgPath: 'assets/loan.png',
                    text: 'Add Income',
                  ),
                  CustomHomeButton(
                    imgPath: 'assets/bank.png',
                    text: 'Bank',
                  ),
                ],
              ),
              const SizedBox(
                height: 44,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Today Transection',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(TransactionScreen());
                      },
                      child: Container(
                          width: 64,
                          height: 18,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Theme.of(context).brightness == Brightness.light
                                ? Colors.white
                                : const Color(0xff1F1F1F),
                          ),
                          child: const Center(
                              child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Column(
                children: [
                  CustomTransection(
                    imgPath: 'assets/shopping.png',
                    title: 'Shopping',
                    subtitle: 'Some Groceries',
                  ),
                  CustomTransection(
                    imgPath: 'assets/school.png',
                    title: 'School Fee',
                    subtitle: 'Kids',
                  ),
                  CustomTransection(
                    imgPath: 'assets/apple-pie.png',
                    title: 'Dinner',
                    subtitle: 'Family',
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                    width: screenWidth,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xff1F1F1F),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: TabBar(
                            padding: const EdgeInsets.all(5),
                            labelColor: Colors.white,
                            controller: tabController,
                            indicatorWeight: 2,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                color: myblue,
                                borderRadius: BorderRadius.circular(5)),
                            tabs: const [
                              Tab(
                                text: 'Income',
                              ),
                              Tab(
                                text: 'Loan',
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        width: 101,
                        height: 18,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Theme.of(context).brightness == Brightness.light
                              ? Colors.white
                              : const Color(0xff1F1F1F),
                        ),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(()=> LoanScreen());
                          },
                          child: const Center(
                              child: Text(
                            'Loan Details',
                            style: TextStyle(
                              fontSize: 13,
                            ),
                          )),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 180,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color(0xff1F1F1F),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PieChart(
                        dataMap: {
                          "Payable": double.parse(payable.toString()),
                          "Recieved": double.parse(receivable.toString()),
                        },
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        chartRadius: screenWidth / 3.5,
                        ringStrokeWidth: 40,
                        colorList: const [myRed, myGreen],
                        legendOptions:
                            const LegendOptions(legendPosition: LegendPosition.left),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddExpenseScreen());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: const Color(0xff95AEEE),
        child: const Icon(Icons.add),
        // mini: true,
      ),
      bottomNavigationBar: const BottomAppBar(
        notchMargin: 10.0,
        shape: CircularNotchedRectangle(),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Ionicons.calculator),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Budget',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Ionicons.analytics),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Expense Report',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Ionicons.person),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
