import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transactions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //this is the list containing all the transactions
  final List<Transactions> user_transactions = [];

  //pass recent_transactions to chart page
  Iterable<Transactions> get _recentTransaction {
    return user_transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    });
  }

  //function for adding new the transactions
  //takes a Transaction object and adds it to the user_transactions list
  void addNewTransaction(String title, int amount, DateTime chosenDate) {
    final newTx = Transactions(title: title, price: amount, date: chosenDate);
    setState(() {
      user_transactions.add(newTx);
      user_transactions.reversed.toList();
    });
  }

  //bottom sheet to add new transactions
  void displayAddTransactionPage(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(addNewTransaction);
        });
  }

  void deleteTransaction(String titleAsId, DateTime dateAsId) {
    setState(() {
      user_transactions.removeWhere((tx) {
        return (tx.title == titleAsId && tx.date == dateAsId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expence Manager"),
        actions: [
          IconButton(
              onPressed: () {
                displayAddTransactionPage(context);
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //AREA FOR BARS
              Chart(_recentTransaction.toList()),
              TransactionList(user_transactions, deleteTransaction),
            ],
          ),
        ),
      ),
    );
  }
}
