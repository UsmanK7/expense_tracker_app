import 'dart:convert';

import 'package:expense_tracker_app/components/transactions.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/services/db_helper.dart';
import 'package:expense_tracker_app/screens/transactions/transaction_details.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DBHelper dbHelper = DBHelper();
  late Future<List<Map<String, dynamic>>> _transactionsFuture;

  Future<List<Map<String, dynamic>>> fetchTransactionsIntoList() async {
    final db = await dbHelper.database;
    setState(() {});

    return db.rawQuery('''
      SELECT e.*, c.name AS category_name, c.img_path AS category_img_path
      FROM expense e
      INNER JOIN categorie c ON e.categorie_id = c.categorie_id
    ''');
  }

  @override
  void initState() {
    super.initState();
    _transactionsFuture = fetchTransactionsIntoList();
  }

  Future<void> _fetchTransactions() async {
    setState(() {
      _transactionsFuture = fetchTransactionsIntoList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Transactions Screen",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _transactionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.isEmpty == true) {
            return Center(child: Text("No record available"));
          } else {
            List<Map<String, dynamic>> transactions = snapshot.data ?? [];
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions.reversed.toList()[index];
                final category_name = transaction['category_name'];
                final category_img_path = transaction['category_img_path'];

                return InkWell(
                    onTap: () async {
                      final result = await Get.to(TransactionDetails(
                          amount: transaction['amount'],
                          img_path: category_img_path,
                          date: transaction['date'],
                          note: transaction['note'],
                          time: transaction['time'],
                          categorie: category_name,
                          expenseRowId: transaction['id']));

                      if (result == true) {
                        _fetchTransactions(); // Refresh transaction data
                      }
                    },
                    child: CustomTransection(
                      imgPath: category_img_path,
                      subtitle: transaction['note'],
                      title: category_name,
                      amount: transaction['amount'],
                      date: transaction['date'],
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
