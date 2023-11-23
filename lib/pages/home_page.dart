import 'dart:math';

import 'package:despesas_pessoais/components/chart.dart';
import 'package:despesas_pessoais/components/transaction_form.dart';
import 'package:despesas_pessoais/components/transaction_list.dart';
import 'package:despesas_pessoais/model/transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Transaction> _transactions = [];

class _HomePageState extends State<HomePage> {
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => TransactionForm(onSubmmit: _addTransaction));
  }

  _addTransaction(String title, double price) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: price,
      data: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
        actions: [IconButton(onPressed: () => _openTransactionFormModal(context), icon: const Icon(Icons.add))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Chart(),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
