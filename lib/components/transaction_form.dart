import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmmit;
  const TransactionForm({super.key, required this.onSubmmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (value) => _submitForm(),
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
              onSubmitted: (value) => _submitForm(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => _submitForm(),
                    child: const Text(
                      "Nova Transação",
                      style: TextStyle(color: Colors.purple),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _submitForm() {
    final title = titleController.text;
    final price = double.tryParse(priceController.text) ?? 0.0;

    if (title.isEmpty || price <= 0) {
      return;
    }
    widget.onSubmmit(title, price);
  }
}
