import 'package:bv_yt_tut_einkaufsliste/models/shopping_item.dart';
import 'package:flutter/cupertino.dart';

class Configuration extends InheritedWidget {
  final List<ShoppingItem> shoppingList;

  Configuration({
    required this.shoppingList,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(Configuration oldWidget) {
    return shoppingList != oldWidget.shoppingList;
  }
}
