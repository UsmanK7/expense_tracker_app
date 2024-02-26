import 'package:expense_tracker_app/screens/transactions/edit_transactions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/screens/transactions/all_transactions.dart';

class TransactionDetails extends StatefulWidget {
  String img_path;
  String categorie;
  int amount;
  String date;
  String note;
  String time;
  int expenseRowId;

  TransactionDetails(
      {super.key,
      required this.amount,
      required this.img_path,
      required this.date,
      required this.expenseRowId,
      required this.note,
      required this.time,
      required this.categorie});

  @override
  State<TransactionDetails> createState() => _TransactionDetailsState();
}

class _TransactionDetailsState extends State<TransactionDetails> {
  DBHelper dbHelper = DBHelper();

  Future<void> deleteTransaction(int id) async {
    final db = await dbHelper.database;
    widget.expenseRowId = widget.expenseRowId + 1;
    print(widget.expenseRowId);
    await db.delete(
      'expense',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Transaction Details',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          GestureDetector(
              onTap: () async {
                await deleteTransaction(widget.expenseRowId);
                Navigator.pop(
                    context, true); // Pass any value to indicate success
              },
              child: Icon(Icons.delete)),
          SizedBox(
            width: 20,
          ),
          GestureDetector(
            onTap: () async{
              Get.to(EditTransaction(note: widget.note,amount: widget.amount,selectedCategory: widget.categorie,selectedDate: widget.date,selectedTime: widget.time,expenseRowId: widget.expenseRowId,));
              
            },
            child: Icon(Icons.edit)),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 20),
            width: screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xff1F1F1F),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Choose your desired color
                      width: 0.5, // Choose your desired width
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 55,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0xff95AEEE),
                            ),
                            child: Image(image: AssetImage(widget.img_path)),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.categorie,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "\-${widget.amount.toString()}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Choose your desired color
                      width: 0.5, // Choose your desired width
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.category),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        widget.categorie,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Choose your desired color
                      width: 0.5, // Choose your desired width
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        widget.date,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, // Choose your desired color
                      width: 0.5, // Choose your desired width
                    ),
                  )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Time",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Text(
                        widget.time.toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.date_range),
                          SizedBox(width: 10),
                          Text(
                            "Note",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.note,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
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
}
