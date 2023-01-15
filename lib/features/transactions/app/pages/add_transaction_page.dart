import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/common/dropdown.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:dukka_finance/features/debtors/models/transaction.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:dukka_finance/features/transactions/app/state/transaction_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransactionPage extends ConsumerStatefulWidget {
  const AddTransactionPage({super.key});

  @override
  ConsumerState<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends ConsumerState<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  AppUser user = AppUserManager.user;

  ActivityType? activityType;

  final space = SizedBox(
    height: 30.0.h,
  );

  void _handleAddTransaction() {
    if (_formKey.currentState!.validate() && activityType != null) {
      final trans = Activity(
        id: DateTime.now().toIso8601String(),
        type: activityType!,
        date: DateTime.now(),
        amount: double.parse(amountController.text),
        description: descController.text,
        sender: activityType == ActivityType.credit
            ? nameController.text
            : user.fullName,
        receiver: activityType == ActivityType.debit
            ? nameController.text
            : user.fullName,
      );

      ref.read(activityStateProvider.notifier).createTransaction(trans);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(activityStateProvider);

    ref.listen(activityStateProvider, ((previous, next) {
      if (next is AddTransactionFailure) {
        AppSnackbar(
          context,
          isError: true,
          text: next.failure.message,
        ).show();
      } else if (next is AddTransactionSuccess) {
        AppSnackbar(
          context,
          text: 'Transaction Added',
        ).show();
        Navigator.pop(context);
      }
    }));

    return Scaffold(
      appBar: AppBar(title: const Text('Add Transaction')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              space,
              //Type income or debit or lending.
              AppDropdown<String>(
                items: ActivityType.values.map((e) => e.name).toList(),
                hintText: 'Credit or Debit',
                onChanged: (value) {
                  if (value == 'credit') {
                    activityType = ActivityType.credit;
                  } else {
                    activityType = ActivityType.debit;
                  }
                  setState(() {});
                },
              ),
              space,
              //Name
              TextFieldBox(
                controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (value) => validator(value, Validator.normal),
                hintText: activityType == ActivityType.credit
                    ? 'Sender Name'
                    : 'Reciever Name',
              ),
              space,

              //Description
              TextFieldBox(
                hintText: 'Description',
                controller: descController,
                textInputAction: TextInputAction.next,
                validator: (value) => validator(value, Validator.normal),
              ),

              space,
              //amount
              TextFieldBox(
                hintText: 'Amount',
                controller: amountController,
                textInputAction: TextInputAction.done,
                validator: (value) => validator(value, Validator.normal),
                onEditingComplete: _handleAddTransaction,
              ),
              space,

              if (state is AddTransactionLoadingState)
                const LoadingWidget()
              else
                AppButton(
                  text: 'Add Transaction',
                  onPressed: _handleAddTransaction,
                ),
              SizedBox(
                height: 10.0.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
