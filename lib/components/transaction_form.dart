import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmmit;
  const TransactionForm({super.key, required this.onSubmmit});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onSubmitted: (value) => _submitForm(),
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: "Valor (R\$)"),
              onSubmitted: (value) => _submitForm(),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
            ),
            Container(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null ? "Nenhuma Data selecionada" : DateFormat("dd/MM/yyyy").format(_selectedDate!),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text(
                      "Selecionar Data",
                      style: TextStyle(color: Colors.purple),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () => _submitForm(),
                    child: Text(
                      "Nova Transação",
                      style: TextStyle(color: Theme.of(context).textTheme.labelLarge!.color),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  _submitForm() {
    final title = _titleController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final date = _selectedDate;

    if (title.isEmpty || price <= 0 || date == null) {
      return;
    }
    widget.onSubmmit(title, price, date);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}
