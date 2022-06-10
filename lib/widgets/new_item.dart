import 'dart:io';

import 'package:flutter/material.dart';
import 'adaptative_text_button.dart';

class NewItem extends StatefulWidget {
  final Function addTx;

  NewItem(this.addTx);

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _titleController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void _submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    widget.addTx(enteredTitle);

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
                focusNode: focusNode,
                autofocus: true,
                decoration: InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) {
                  _submitData();
                },
                textInputAction: TextInputAction.send,
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text('Criar Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
