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
bool showChart = false;

class _HomePageState extends State<HomePage> {
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => TransactionForm(onSubmmit: _addTransaction));
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
          (tr) => tr.data.isAfter(
            DateTime.now().subtract(const Duration(days: 7)),
          ),
        )
        .toList();
  }

  _addTransaction(String title, double price, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: price,
      data: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandiscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(Icons.add),
        ),
        if (isLandiscape)
          IconButton(
            onPressed: () {
              setState(() {
                showChart = !showChart;
              });
            },
            icon: Icon(showChart ? Icons.list : Icons.pie_chart_outline),
          )
      ],
    );
    final availableHeight = mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (isLandiscape)
              if (showChart || !isLandiscape)
                SizedBox(
                  height: availableHeight * (isLandiscape ? 0.7 : 0.3),
                  child: Chart(recentTransactions: _recentTransactions),
                ),
            if (!showChart || !isLandiscape)
              SizedBox(
                height: availableHeight * 0.75,
                child: TransactionList(
                  transactions: _transactions,
                  removeTransaction: _removeTransaction,
                ),
              ),
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
