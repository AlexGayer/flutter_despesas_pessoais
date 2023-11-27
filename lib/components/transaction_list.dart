import 'package:despesas_pessoais/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionList({super.key, required this.transactions, required this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isEmpty
          ? Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Nenhuma transação Cadastrada",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: transactions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    trailing: IconButton(
                        onPressed: () => removeTransaction(tr.id),
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.error,
                        )),
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(child: Text("R\$ ${tr.value}")),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat("dd/MM/yyyy").format(tr.data),
                    ),
                  ),
                );
              }),
    );
  }
}
