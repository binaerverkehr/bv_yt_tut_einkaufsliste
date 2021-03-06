import 'package:bv_yt_tut_einkaufsliste/screens/add_shopping_item_screen.dart';
import 'package:bv_yt_tut_einkaufsliste/screens/shopping_item_list_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ShoppingItemListScreen(),
        '/add': (context) => AddShoppingItemScreen(),
      },
    );
  }
}
