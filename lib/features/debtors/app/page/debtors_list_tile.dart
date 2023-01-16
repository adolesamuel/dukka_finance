import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter/material.dart';

class DebtorsListTile extends StatelessWidget {
  final Debt debt;
  const DebtorsListTile({super.key, required this.debt});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(
          color: Colors.grey,
          width: 0.2,
          strokeAlign: StrokeAlign.outside,
        ),
      ),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onTap: () {
          // navigate(
          //   context,
          //   TransactionDetailPage(
          //     transaction: transaction,
          //   ),
          // );
        },
        leading: CircleAvatar(
          backgroundColor: AppColors.authAppBarBgColor,
          foregroundColor: Colors.white,
          child: Text(
            debt.receiver.substring(0, 2),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        title: Text(debt.description),
        subtitle: debt.type == ActivityType.credit
            ? Text('From ${debt.sender}')
            : Text('To ${debt.receiver}'),
        trailing: Text(
          debt.amount.toCurrency(),
          maxLines: 1,
          style: TextStyle(
            color: debt.type == ActivityType.debit ? Colors.red : Colors.green,
            fontWeight: FontWeight.w300,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
