import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredValue = _amountController.text.isEmpty
        ? 0
        : double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredValue <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredValue, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 60,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'Data não selecionada!'
                            : DateFormat('dd/MM/yyyy').format(_selectedDate),
                      ),
                    ),
                    AdaptiveTextButton('Selecione a data', _presentDatePicker)
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Criar transação'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
