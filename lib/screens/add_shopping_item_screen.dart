import 'package:bv_yt_tut_einkaufsliste/models/shopping_item.dart';
import 'package:flutter/material.dart';

import '../config.dart';

class AddShoppingItemScreen extends StatefulWidget {
  const AddShoppingItemScreen({Key? key}) : super(key: key);

  @override
  _AddShoppingItemScreenState createState() => _AddShoppingItemScreenState();
}

class _AddShoppingItemScreenState extends State<AddShoppingItemScreen> {
  TextEditingController _textEditingController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.dependOnInheritedWidgetOfExactType<Configuration>()!.shoppingList;

    final editedShoppingItem = ModalRoute.of(context)!.settings.arguments as ShoppingItem;

    bool inEditMode = editedShoppingItem.name != '';

    if (inEditMode) {
      _textEditingController.text = editedShoppingItem.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(inEditMode ? 'Edit item' : 'Add item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (inEditMode) {
                  ShoppingItem newShoppingItem = editedShoppingItem.copyWith(name: _textEditingController.text);
                  int indexOfEditedItem = shoppingList.indexOf(editedShoppingItem);
                  shoppingList[indexOfEditedItem] = newShoppingItem;
                } else {
                  shoppingList.add(ShoppingItem(name: _textEditingController.text, done: false));
                }

                _textEditingController.clear();
                Navigator.pop(context);
              },
              child: Text(inEditMode ? 'Update' : 'Add'),
            )
          ],
        ),
      ),
    );
  }
}
