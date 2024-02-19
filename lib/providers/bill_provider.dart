// bill_provider.dart
import 'package:flutter/material.dart';
import 'package:bar_management/models/bill.dart';

class BillProvider extends ChangeNotifier {
  List<Bill> _bills = [];

  List<Bill> get bills => _bills;

  void addBill(Bill bill) {
    _bills.add(bill);
    notifyListeners();
  }
}
