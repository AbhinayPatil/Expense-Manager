import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double spendingPctOfTotal;
  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      // column to give a single day expense bar
      children: [
        FittedBox(
            child: Text(
          "$spendingAmount",
        )),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              //fractional sized box to overlap container with the amount spend on that particular day
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
