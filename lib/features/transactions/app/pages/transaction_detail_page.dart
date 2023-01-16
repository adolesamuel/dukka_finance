import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TransactionDetailPage extends StatefulWidget {
  final Activity transaction;
  const TransactionDetailPage({
    super.key,
    required this.transaction,
  });

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  late Activity transaction;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEEE, d MMMM yyyy, hh:mma');

    return Scaffold(
      //holds Date
      appBar: AppBar(
        title: Text(
          format.format(
            transaction.date,
          ),
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0.h,
            ), //Description
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                transaction.description,
                style: const TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),
            //Receiver/Sender.
            Container(
              padding: const EdgeInsets.all(20.0),
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                  color: AppColors.authAppBarBgColor,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.type == ActivityType.debit ? 'To' : 'From',
                    style: const TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  Text(
                    transaction.type == ActivityType.debit
                        ? transaction.receiver
                        : transaction.sender,
                    style: const TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ],
              ),
            ),

            //Income/Expense
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                transaction.type.name.toString()[0].toUpperCase() +
                    transaction.type.name.toString().substring(1),
                style: const TextStyle(fontSize: 30.0, color: Colors.black),
              ),
            ),

            //Amount of Transaction
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  NumberFormat.simpleCurrency(name: 'NGN').currencySymbol,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                Text(
                  transaction.amount.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 30.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
