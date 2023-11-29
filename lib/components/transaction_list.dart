import 'package:despesas_pessoais/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionList({super.key, required this.transactions, required this.removeTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Center(
            child: LayoutBuilder(
              builder: (context, constraints) => Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Text(
                    "Nenhuma transação Cadastrada",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
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
                  trailing: MediaQuery.of(context).size.width > 490
                      ? TextButton.icon(
                          onPressed: () => removeTransaction(tr.id),
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          label: Text(
                            "Deletar",
                            style: TextStyle(color: Theme.of(context).colorScheme.error),
                          ))
                      : IconButton(
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
            });
  }
}
