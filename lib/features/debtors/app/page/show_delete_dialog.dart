import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter/material.dart';

showDeleteDialog(
  BuildContext context,
  Debt debt, {
  void Function()? onSelectYes,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          title: const Text('Delete Debt Entry?'),
          content: Text(
            "The transaction entry will still exist on Home\nDebt tracking will stop",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            TextButton(
              onPressed: onSelectYes,
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
              ),
            )
          ],
        );
      });
}
