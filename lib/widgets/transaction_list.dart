import 'package:expenses_app/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;
  const TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.67,
        child: transactions.isEmpty
            ? Center(
                child: Container(
                  child: Column(
                    children: [
                      const Text(
                        "No transactions added yet.",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Lottie.asset("assets/expenses.json", fit: BoxFit.contain),
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 4, left: 8.0, right: 8, bottom: 4),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      elevation: 5,
                      child: Container(
                        decoration: const BoxDecoration(
                            //color: Colors.grey,
                            ),
                        child: Row(
                          children: [
                            //pricebox
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                        child: Text(
                                            "${transactions[index].price}.Rs")),
                                  )),
                            ),

                            //title and date
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transactions[index].title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  DateFormat.yMMMd()
                                      .format(transactions[index].date),
                                  style: const TextStyle(
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: const Icon(Icons.delete),
                                onTap: () {
                                  deleteTx(transactions[index].title,
                                      transactions[index].date);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}
