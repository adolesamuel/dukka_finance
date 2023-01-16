import 'package:dukka_finance/configs/navigator.dart';
import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/debtors/app/page/debt_detail_page.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:flutter/material.dart';

class DebtorsListTile extends StatelessWidget {
  final Debt debt;
  const DebtorsListTile({super.key, required this.debt});

  Color _determineColor() {
    //
    final totalDays = debt.dueDate.difference(debt.date).inDays + 1;
    final daysElapsed = DateTime.now().difference(debt.date).inDays + 1;
    final fraction = daysElapsed / totalDays;

    if (debt.isPaid) {
      return Colors.blue;
    } else if (fraction < 0.3) {
      return Colors.green;
    } else if (0.6 > fraction && fraction > 0.3) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalDays = debt.dueDate.difference(debt.date).inDays + 1;

    final daysElapsed = DateTime.now().difference(debt.date).inDays + 1;

    final fraction = daysElapsed / totalDays;
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
            DebtDetailPage(
              debt: debt,
            ),
          );
        },
        leading: SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 46,
                width: 46,
                child: CircularProgressIndicator(
                  value: debt.isPaid
                      ? 1
                      : fraction > 1
                          ? 1
                          : fraction,
                  color: _determineColor(),
                ),
              ),
              CircleAvatar(
                backgroundColor: AppColors.authAppBarBgColor,
                foregroundColor: Colors.white,
                child: Text(
                  debt.receiver.substring(0, 2),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              if (fraction >= 1)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                ),
            ],
          ),
        ),
        title: Text(
            debt.description[0].toUpperCase() + debt.description.substring(1)),
        subtitle: debt.type == ActivityType.credit
            ? Text('From ${debt.sender}')
            : Text('To ${debt.receiver}'),
        trailing: Text(
          debt.amount.toCurrency(),
          maxLines: 1,
          style: TextStyle(
            color: debt.isPaid ? Colors.green : Colors.red,
            fontWeight: FontWeight.w300,
            fontSize: 22.0,
          ),
        ),
      ),
    );
  }
}
