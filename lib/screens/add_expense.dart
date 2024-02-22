import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker_app/screens/transactions/all_transactions.dart';
import 'package:expense_tracker_app/const/theme.dart';
class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late DateTime _showDateTime = DateTime.now();
  late TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController _priceController = TextEditingController();
  String _selectedCategory = "Food";
  String _selectedCard = "HBL";
  
  Const constants = Const();
  // final List<Map<String, dynamic>> expenseCategories = [
  //   {"name": "Food", "icon": Icons.fastfood},
  //   {"name": "Transportation", "icon": Icons.directions_car},
  //   {"name": "Shopping", "icon": Icons.shopping_cart},
  //   {"name": "Utilities", "icon": Icons.lightbulb_outline},
  //   {"name": "Housing", "icon": Icons.home},
  //   {"name": "Entertainment", "icon": Icons.local_movies},
  //   {"name": "Healthcare", "icon": Icons.local_hospital},
  //   {"name": "Education", "icon": Icons.school},
  //   {"name": "Travel", "icon": Icons.flight},
  //   {"name": "Insurance", "icon": Icons.local_offer},
  //   {"name": "Charity", "icon": Icons.favorite},
  //   {"name": "Personal Care", "icon": Icons.person},
  //   {"name": "Gifts", "icon": Icons.card_giftcard},
  //   {"name": "Other", "icon": Icons.category},
  // ];
  


  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2025))
        .then((value) {
      if (value != null) {
        setState(() {
          _showDateTime = DateTime(value.year, value.month, value.day);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_selectedCategory);
    // String dropdownValue = 'One';
    
    var screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Expense',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 51),
              child: Container(
                width: screenWidth,
                height: 85,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xff1F1F1F),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: TextField(
                    controller: _priceController,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "\$0",
                      hintStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.light
                                ? Colors.black
                                : Colors.white),
                    ),
                  ),

                  // style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: screenWidth,
                  height: 63,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color(0xff1F1F1F),
                  ),
                  child: Center(
                    child: SingleChildScrollView(
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                      
                          // filled: true,
                          // fillColor: Theme.of(context).brightness == Brightness.light
                          //     ? Colors.white
                          //     : const Color(0xff1F1F1F),
                          // labelText: 'Expense Category',
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          // suffixIcon: Icon(Icons.arrow_drop_down),
                        ),
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCategory = newValue!;
                          });
                        },
                        items: constants.expenseCategories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category['name'],
                            child: Row(
                              children: [
                                Icon(category['icon']),
                                SizedBox(width: 10),
                                Text(category['name']),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: _showDatePicker,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: screenWidth,
                    height: 63,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : const Color(0xff1F1F1F),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(DateFormat('yyyy-MM-dd').format(_showDateTime)),
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: _showTimePicker,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: screenWidth,
                  height: 63,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : const Color(0xff1F1F1F),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 20),
                      Text(_selectedTime.format(context)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: (){
                Get.to(TransactionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 63,
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: const Color(0xff4B7AF1),
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                      child: Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
