import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  final Function addTx;
  Color? color;

  NewItem(this.addTx, [this.color]);

  @override
  State<NewItem> createState() => _NewItemState(color);
}

class _NewItemState extends State<NewItem> {
  final _titleController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ColorSwatch? _tempMainColor;
  Color? _tempShadeColor;
  ColorSwatch? _mainColor = Colors.blue;
  Color? _shadeColor = Colors.blue[800];
  bool useColor = false;

  _NewItemState(Color? color) {
    if (color != null) {
      useColor = true;
      _mainColor = color as ColorSwatch?;
    }
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: const Text('CANCELAR'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: const Text('ESCOLHER'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => _mainColor = _tempMainColor);
                setState(() => _shadeColor = _tempShadeColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openColorPicker() async {
    _openDialog(
      "Color picker",
      MaterialColorPicker(
        allowShades: false,
        selectedColor: _shadeColor,
        onColorChange: (color) => setState(() => _tempShadeColor = color),
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        onBack: () => print("Back button pressed"),
      ),
    );
  }

  void _submitData() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    if (useColor)
      widget.addTx(enteredTitle, _mainColor);
    else
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
                decoration: const InputDecoration(labelText: 'Título'),
                controller: _titleController,
                onSubmitted: (_) {
                  _submitData();
                },
                textInputAction: TextInputAction.send,
              ),
              const SizedBox(height: 16.0),
              useColor
                  ? Container(
                      height: 60,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 20),
                            child: CircleAvatar(
                                backgroundColor: _mainColor, radius: 20),
                          ),
                          OutlinedButton(
                            onPressed: _openColorPicker,
                            child: const Text('Escolher cor'),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Criar Item'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
