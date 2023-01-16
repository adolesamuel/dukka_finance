import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:dukka_finance/features/transactions/app/pages/transcation_list_tile.dart';
import 'package:dukka_finance/features/transactions/app/state/transaction_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../services/app_user_manager.dart';

class DashboardContent extends ConsumerStatefulWidget {
  const DashboardContent({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends ConsumerState<DashboardContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  AppUser user = AppUserManager.user;

  double sumForTheMonth = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          const SizedBox(height: 5.0),
          //
          Text(user.fullName),
          //
          const SizedBox(height: 5.0),
          Text(
              'Cumulative Transactions for ${DateFormat('MMMM').format(DateTime.now())}'),
          //
          Text(
            NumberFormat.simpleCurrency(name: 'NGN').currencySymbol +
                sumForTheMonth.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          //
          StreamBuilder<TransactionState>(
            stream:
                ref.watch(activityStateProvider.notifier).streamTransaction(),
            builder: (context, snapshot) {
              final transactionState = snapshot.data;

              if (transactionState is TransactionDataLoading) {
                return const LoadingWidget();
              } else if (transactionState is TransactionData) {
                final dataList = transactionState.activity;

                sumForTheMonth = dataList
                    .where(
                        (element) => element.date.month == DateTime.now().month)
                    .fold(0, (previousValue, element) {
                  return previousValue +
                      (element.type == ActivityType.credit
                          ? element.amount
                          : -element.amount);
                });

                return Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) => TransactionListTile(
                      transaction: dataList[index],
                    ),
                  ),
                );
              } else {
                return const Text('Error');
              }
            },
          ),
          //
        ],
      ),
    );
  }
}
