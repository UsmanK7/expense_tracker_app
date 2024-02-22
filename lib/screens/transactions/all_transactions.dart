import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
   TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  int selectedMonth = 1;

  @override
  Widget build(BuildContext context) {
    print("this is the selected month = ${selectedMonth}");
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 12,
              itemBuilder: (BuildContext context,int index){
                final monthIndex = index +1;
                final monthName = _getMonthName(monthIndex);
               
                return GestureDetector(
                  onTap: (){
                    setState((){
                    selectedMonth = index+1;
                   });
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: selectedMonth == monthIndex ? Colors.blue : null,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      monthName,
                      style: TextStyle(
                        color: selectedMonth == monthIndex ? Colors.white :null,
                      ),
                      
                    ),
                  ),
                );
              }),
          )
        ],
      ),
    );
  }

  String _getMonthName(int monthIndex) {
    switch (monthIndex) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}