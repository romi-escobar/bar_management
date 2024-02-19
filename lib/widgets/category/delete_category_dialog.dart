// delete_category_dialog.dart
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Function() onDelete;

  DeleteConfirmationDialog({required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Delete Confirmation'),
      content: Text('Are you sure you want to delete this category?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without deleting
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onDelete(); // Call the onDelete function to perform the deletion
            Navigator.of(context).pop(); // Close the dialog after deleting
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
