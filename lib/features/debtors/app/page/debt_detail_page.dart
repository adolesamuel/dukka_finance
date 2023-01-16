import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DebtDetailPage extends StatefulWidget {
  final Debt debt;
  const DebtDetailPage({
    super.key,
    required this.debt,
  });

  @override
  State<DebtDetailPage> createState() => _DebtDetailPageState();
}

class _DebtDetailPageState extends State<DebtDetailPage> {
  late Debt debt;
  @override
  void initState() {
    super.initState();
    debt = widget.debt;
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat('EEEE, d MMMM yyyy, hh:mma');

    return Scaffold(
      //holds Date
      appBar: AppBar(
        title: Text(
          format.format(
            debt.date,
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
            ),
            //Description
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                debt.description,
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
                  const Text(
                    'To',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  Text(
                    debt.receiver,
                    style: const TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ],
              ),
            ),

            //Income/Expense
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Borrowed',
                style: TextStyle(fontSize: 30.0, color: Colors.black),
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
                  debt.amount.toStringAsFixed(2),
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
