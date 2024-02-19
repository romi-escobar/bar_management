// costumer_provider.dart
import 'package:bar_management/models/costumer.dart';
import 'package:flutter/material.dart';

class CostumerProvider extends ChangeNotifier {
  List<Costumer> _people = [];  // List of costumers

  List<Costumer> get people => _people;
  
  void addCostumer(Costumer costumer) {
    _people.add(costumer);
    notifyListeners();
  }

  Costumer getCostumerById(int id) {
    return _people.firstWhere((costumer) => costumer.id == id);
  }

  Costumer getCostumerByName(String name) {
  return _people.firstWhere((costumer) => costumer.name == name);
  }

  Costumer getCostumerByRUC(String ruc) {
    return _people.firstWhere((costumer) => costumer.ruc == ruc);
  }

  List<Costumer> getCostumerByNameOrLastName(String query) {
    return _people
      .where((costumer) =>
          costumer.name.contains(query) || costumer.lastName.contains(query))
      .toList();
  }

  void editCostumer(int id, String newName, String newLastName, String newRuc, String newEmail) {
    final costumer = _people.firstWhere((p) => p.id == id);
    costumer.name = newName;
    costumer.lastName = newLastName;
    costumer.ruc = newRuc;
    costumer.email = newEmail;

    notifyListeners();
  }

  void deleteCostumer(int id) {
    _people.removeWhere((costumer) => costumer.id == id);
    notifyListeners();
  }
}
