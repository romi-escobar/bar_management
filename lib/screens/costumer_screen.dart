// costumer_screen.dart
import 'package:bar_management/models/costumer.dart';
import 'package:bar_management/providers/costumer_provider.dart';
import 'package:bar_management/widgets/costumer/add_costumer_dialog.dart';
import 'package:bar_management/widgets/costumer/edit_costumer_dialog.dart';
import 'package:bar_management/widgets/costumer/read_costumer_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostumerScreen extends StatefulWidget {
  @override
  _CostumerScreenState createState() => _CostumerScreenState();
}

class _CostumerScreenState extends State<CostumerScreen> {
  String filterType = '';

  void _showAddCostumerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddCostumerDialog(
          onAdd: (String newName, String newLastName, String newRuc, String newEmail) {
            final costumerProvider = Provider.of<CostumerProvider>(context, listen: false);

            final newCostumer = Costumer(
              id: costumerProvider.people.length + 1,
              name: newName,
              lastName: newLastName,
              ruc: newRuc,
              email: newEmail,
            );

            costumerProvider.addCostumer(newCostumer);
          },
        );
      },
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter by Name, Last Name, or RUC'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                filterType = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Enter name, last name, or RUC',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final costumerProvider = Provider.of<CostumerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('People Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: costumerProvider.people.length,
        itemBuilder: (context, index) {
          final costumer = costumerProvider.people[index];

          if ((filterType.isEmpty ||
              costumer.name.toLowerCase().contains(filterType.toLowerCase()) ||
              costumer.lastName.toLowerCase().contains(filterType.toLowerCase()) ||
              costumer.ruc.toLowerCase().contains(filterType.toLowerCase()))) {
            return ListTile(
              title: Text(costumer.name),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      final selectedPerson = costumerProvider.getCostumerById(costumer.id);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ReadCostumerDialog(costumer: selectedPerson);
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return EditCostumerDialog(
                            currentName: costumer.name,
                            currentLastName: costumer.lastName,
                            currentRuc: costumer.ruc,
                            currentEmail: costumer.email,
                            onEdit: (String newName, String newLastName, String newRuc, String newEmail) {
                              final personProvider = Provider.of<CostumerProvider>(context, listen: false);

                              personProvider.editCostumer(
                                costumer.id,
                                newName,
                                newLastName,
                                newRuc,
                                newEmail,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      costumerProvider.deleteCostumer(costumer.id);
                    },
                  ),
                ],
              ),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCostumerDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
