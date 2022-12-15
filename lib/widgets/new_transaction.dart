import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime _pickedDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.purple),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(_pickedDate == DateTime(2000)
                        ? "No date chosen"
                        : "Picked date: ${DateFormat.yMd().format(_pickedDate)}"),
                  ),
                  TextButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now())
                          .then((pickedDate) {
                        if (pickedDate == null) return;
                        setState(() {
                          _pickedDate = pickedDate;
                        });
                      });
                    },
                    child: const Text("Choose date"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isEmpty ||
                    int.parse(amountController.text) <= 0 ||
                    amountController.text.isEmpty ||
                    _pickedDate == DateTime(2000)) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Alert!!"),
                      content: const Text("Enter valid title, amount and date"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("ok"),
                        ),
                      ],
                    ),
                  );
                } else {
                  widget.addTx(titleController.text,
                      int.parse(amountController.text), _pickedDate);
                  Navigator.of(context).pop();
                }
              },
              child: const Text(
                "Add Transaction",
              ),
            )
          ],
        ),
      ),
    );
  }
}
