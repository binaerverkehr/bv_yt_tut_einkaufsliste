import 'package:bv_yt_tut_einkaufsliste/config.dart';
import 'package:bv_yt_tut_einkaufsliste/models/shopping_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShoppingItemListScreen extends StatefulWidget {
  const ShoppingItemListScreen({Key? key}) : super(key: key);

  @override
  _ShoppingItemListScreenState createState() => _ShoppingItemListScreenState();
}

class _ShoppingItemListScreenState extends State<ShoppingItemListScreen> {
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.dependOnInheritedWidgetOfExactType<Configuration>()!.shoppingList;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Shopping List'),
      ),
      body: ListView.builder(
          itemCount: shoppingList.length,
          itemBuilder: (context, index) {
            final item = shoppingList[index];

            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              secondaryActions: [
                IconSlideAction(
                  caption: 'Edit',
                  color: Colors.black45,
                  icon: Icons.edit,
                  onTap: () {
                    Navigator.pushNamed(context, '/add', arguments: item).then((value) => setState(() {}));
                  },
                ),
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                  onTap: () {
                    setState(() {
                      shoppingList.removeAt(index);
                    });
                    _showSnackBar(context, '${item.name} deleted.');
                  },
                ),
              ],
              child: CheckboxListTile(
                title: Text(
                  item.name,
                  style: TextStyle(
                    color: item.done ? Colors.grey : null,
                    decoration: item.done ? TextDecoration.lineThrough : null,
                  ),
                ),
                value: item.done,
                onChanged: (newValue) {
                  setState(() {
                    item.setDone(newValue);
                  });
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add', arguments: ShoppingItem(name: '', done: false))
              .then((value) => setState(() {}));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
