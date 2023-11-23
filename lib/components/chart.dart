import 'package:despesas_pessoais/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction>? recentTransactions;

  List<Map<String, Object>> get groupedTransictions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions!.length; i++) {
        bool sameDay = recentTransactions![i].data.day == weekDay.day;
        bool sameMonth = recentTransactions![i].data.month == weekDay.month;
        bool sameYear = recentTransactions![i].data.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions![i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  const Chart({super.key, this.recentTransactions});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
