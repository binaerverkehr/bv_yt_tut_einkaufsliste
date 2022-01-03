import 'package:bv_yt_tut_einkaufsliste/database_helper.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shopping List'),
      ),
      body: Center(
        child: FutureBuilder<List<ShoppingItem>>(
          future: DatabaseHelper.instance.getShoppingItems(),
          builder: (BuildContext context, AsyncSnapshot<List<ShoppingItem>> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Loading...'),
              );
            }
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('No shopping items in list'),
                  )
                : ListView(
                    children: snapshot.data!.map((item) {
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
                                DatabaseHelper.instance.remove(item.id!);
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
                              DatabaseHelper.instance.update(item.copyWith(done: newValue));
                            });
                          },
                        ),
                      );
                    }).toList(),
                  );
          },
        ),
      ),
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
