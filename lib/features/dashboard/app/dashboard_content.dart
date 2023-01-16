import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/dashboard/app/state/dashboard_state_notifier.dart';
import 'package:dukka_finance/features/dashboard/data/model/dashboard_data.dart';
import 'package:dukka_finance/features/transactions/app/pages/transcation_list_tile.dart';
import 'package:dukka_finance/features/transactions/app/state/transaction_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('Current Balance'),
          //
          const SizedBox(height: 5.0),
          //
          Text(user.fullName),
          //
          const SizedBox(height: 5.0),
          //
          StreamBuilder<DashboardState>(
            stream: ref
                .watch(dashboardStateProvider.notifier)
                .streamDashboardState(user),
            builder: (context, snapshot) {
              final state = snapshot.data;
              DashboardData? dashboardData;
              if (state is DashboardDataState) {
                dashboardData = state.data;
              } else if (state is DashboardErrorState) {
                AppSnackbar(
                  context,
                  text: state.failure.message,
                  isError: true,
                ).show();
              }

              return Text(
                dashboardData?.balance.toStringAsFixed(2) ?? '',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
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
              }),
          //
        ],
      ),
    );
  }
}
