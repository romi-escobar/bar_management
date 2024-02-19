// welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:bar_management/screens/category_screen.dart';
import 'package:bar_management/screens/product_screen.dart';
import 'package:bar_management/screens/costumer_screen.dart';
import 'package:bar_management/screens/sale_screen.dart';
import 'package:bar_management/screens/bill_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bar Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryScreen()),
                );
              },
              child: Text('Categories'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductScreen()),
                );
              },
              child: Text('Products'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CostumerScreen()),
                );
              },
              child: Text('Costumers'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SaleScreen()),
                );
              },
              child: Text('Sales'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BillScreen()),
                );
              },
              child: Text('Bills'),
            ),
          ],
        ),
      ),
    );
  }
}
