import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ionicons/ionicons.dart';
import 'package:expense_tracker_app/screens/transactions/all_transactions.dart';
import 'package:expense_tracker_app/const/theme.dart';

class EditTransaction extends StatefulWidget {
  String selectedCategory;
  int amount;
  int expenseRowId;
  String note;
  String selectedDate;
  String selectedTime;

  EditTransaction(
      {super.key,
      required this.selectedCategory,
      required this.selectedDate,
      required this.expenseRowId,
      required this.amount,
      required this.selectedTime,
      required this.note});
  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  DBHelper dbHelper = DBHelper();
  late DateTime _showDateTime =
      DateFormat('yyyy-MM-dd').parse(widget.selectedDate);
  late TimeOfDay _selectedTime = _parseTimeOfDay(widget.selectedTime);

  TimeOfDay _parseTimeOfDay(String formattedTime) {
    List<String> components = formattedTime.split(':');
    int hour = int.parse(components[0]);
    int minute = int.parse(components[1].split(' ')[0]);
    String period = components[1].split(' ')[1];
    if (period.toLowerCase() == 'pm') {
      hour += 12;
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  late TextEditingController _priceController;
  @override
  late TextEditingController _notesController;

  List<String> items = [];

  String? selectedValue;
  List<String> banks = ['HBL', 'Askari bank'];
  String? selectedBank;
  void initState() {
    super.initState();
    fetchCategoriesIntoList();
    _priceController = TextEditingController(text: widget.amount.toString());
    _notesController = TextEditingController(text: widget.note.toString());
    selectedValue = widget.selectedCategory;
  }

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

  Future<void> updateExpenseIntoDb(int categorie_id, int amount, String date,
      int month, int year, String note, int bank_id, String time) async {
    // Change parameter types
    await dbHelper.initDb();
    final db = await dbHelper.database;
    categorie_id++;
    await db.update(
      'expense',
      {
        'categorie_id': categorie_id,
        'amount': amount,
        'date': date,
        'month': month,
        'year': year,
        'note': note,
        'bank_id': bank_id,
        'time': time,
      },
      where: 'id = ?',
      whereArgs: [widget.expenseRowId],
    );

    print("values edited");
  }

  Future<void> fetchCategoriesIntoList() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> categories = await db.query('categorie');
    items = categories.map((e) => e['name'] as String).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // String dropdownValue = 'One';
    print(selectedValue);

    var screenWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Edit Expense',
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
                          color:
                              Theme.of(context).brightness == Brightness.light
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
                    child: Row(
                      children: [
                        Icon(Icons.money_off),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Category',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              items: items
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                  print(selectedValue);
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
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
              height: 10,
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
                    child: Row(
                      children: [
                        Icon(Icons.credit_card_outlined),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Bank',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              items: banks
                                  .map(
                                      (String item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                  .toList(),
                              value: selectedBank,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedBank = value;
                                  print(selectedBank);
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))),
            const SizedBox(
              height: 10,
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
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.note_add)),
                        Expanded(
                          child: TextField(
                            controller: _notesController,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white),
                                hintText: "Add a Note (optional)"),
                          ),
                        ),
                      ],
                    ))),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                Get.to(TransactionScreen());
              },
              child: GestureDetector(
                onTap: () async {
                  if (_priceController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Price cannot be empty',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    int amount = int.parse(_priceController.text);
                    int categorie_id = items.indexOf(selectedValue.toString());
                    String date =
                        DateFormat('yyyy-MM-dd').format(_showDateTime);
                    int month = _showDateTime.month;
                    int year = _showDateTime.year;
                    String note = _notesController.text;
                    int bank_id = banks.indexOf(selectedBank.toString());

                    String time = _selectedTime.format(context);

                    updateExpenseIntoDb(categorie_id, amount, date, month, year,
                        note, bank_id, time);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
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
                      "Edit",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
