import 'package:expenses_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class Chart extends StatelessWidget {
  final List<Transactions> recentTransactions;
  Chart(this.recentTransactions, {super.key});

  //seperate list containing recent 7 days expenditure
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].price;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  int get totalSpending {
    return groupedTransactionValues.fold(0, (sum, element) {
      return sum + (element['amount'] as int);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 227, 241),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'].toString(),
                      int.parse(data['amount'].toString()),
                      totalSpending == 0
                          ? 0.0
                          : double.parse(data['amount'].toString()) /
                              totalSpending),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
