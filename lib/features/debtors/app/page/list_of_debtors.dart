import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/empty_widget.dart';
import 'package:dukka_finance/features/debtors/app/page/debtors_list_tile.dart';
import 'package:dukka_finance/features/debtors/app/state/debt_state_notifier.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DebtorListPage extends ConsumerStatefulWidget {
  static const route = ScreenPaths.debtorsListScreen;
  const DebtorListPage({super.key});

  @override
  ConsumerState<DebtorListPage> createState() => _DebtorListPageState();
}

class _DebtorListPageState extends ConsumerState<DebtorListPage> {
  final spacer = SizedBox(height: 5.0.h);
  double sumOfDebts = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DebtState>(
        stream: ref.watch(debtStateProvider.notifier).streamDebt(),
        builder: (context, snapshot) {
          final state = snapshot.data;

          List<Debt> debtData = [];
          if (state is DebtListSuccess) {
            debtData = state.listOfDebts;
            //updated sum of debts not paid
            sumOfDebts = debtData.fold(0, (previousValue, element) {
              if (!element.isPaid) {
                return previousValue + element.amount;
              }
              return previousValue;
            });
          } else if (state is DebtListFailure) {
            AppSnackbar(
              context,
              text: state.failure.message,
              isError: true,
            ).show();
          }

          return Scaffold(
            body: Center(
              child: SizedBox.expand(
                child: Column(
                  children: [
                    const Text('Total Debts'),
                    spacer,
                    Text(
                      NumberFormat.simpleCurrency(name: 'NGN').currencySymbol +
                          sumOfDebts.toStringAsFixed(2),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    spacer,
                    if (debtData.isEmpty)
                      const EmptyWidget(
                          message:
                              'No Debt Data Present\n Add Debtors to Proceed')
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: debtData.length,
                          itemBuilder: (context, index) =>
                              DebtorsListTile(debt: debtData[index]),
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
