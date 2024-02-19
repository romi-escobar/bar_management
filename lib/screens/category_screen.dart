// category_screen.dart
import 'package:bar_management/models/category.dart';
import 'package:bar_management/providers/category_provider.dart';
import 'package:bar_management/widgets/category/add_category_dialog.dart';
import 'package:bar_management/widgets/category/delete_category_dialog.dart';
import 'package:bar_management/widgets/category/edit_category_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AddCategoryDialog(
          onAdd: (String newName) {
            final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
            final newCategory = Category(
              id: categoryProvider.categories.length + 1, 
              name: newName,
            );
            categoryProvider.addCategory(newCategory);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
          return ListView.builder(
            itemCount: categoryProvider.categories.length,
            itemBuilder: (context, index) {
              final category = categoryProvider.categories[index];
              return ListTile(
                title: Text(category.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return EditCategoryDialog(
                              currentName: category.name,
                              onEdit: (String newName) {
                                categoryProvider.editCategory(category.id, newName);
                              },
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteConfirmationDialog(
                              onDelete: () {
                                categoryProvider.deleteCategory(category.id);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
