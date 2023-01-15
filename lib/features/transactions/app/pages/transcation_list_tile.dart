import 'package:dukka_finance/configs/navigator.dart';
import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:dukka_finance/features/transactions/app/pages/transaction_detail_page.dart';
import 'package:flutter/material.dart';

class TransactionListTile extends StatelessWidget {
  const TransactionListTile({super.key});

  @override
  Widget build(BuildContext context) {
    Transaction transaction = Transaction(
        id: 'asdfasdf',
        type: TransactionType.debit,
        date: DateTime.now(),
        amount: 999.40,
        description: 'Let Cassy Chill',
        sender: 'Adole Samuel',
        receiver: 'Cassy');
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
          navigate(
              context,
              TransactionDetailPage(
                transaction: transaction,
              ));
        },
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Text(
            transaction.receiver.substring(0, 2),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        title: Text(transaction.description),
        subtitle: transaction.type == TransactionType.credit
            ? Text('From ${transaction.sender}')
            : Text('To ${transaction.receiver}'),
        trailing: Text(
          transaction.amount.toCurrency(),
          maxLines: 1,
          style: TextStyle(
              color: transaction.type == TransactionType.debit
                  ? Colors.red
                  : Colors.green,
              fontWeight: FontWeight.w300,
              fontSize: 22.0),
        ),
      ),
    );
  }
}
