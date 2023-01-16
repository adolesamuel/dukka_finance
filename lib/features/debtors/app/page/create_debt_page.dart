import 'dart:io';

import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:dukka_finance/features/debtors/app/page/custom_date_picker.dart';
import 'package:dukka_finance/features/debtors/app/state/debt_state_notifier.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class CreateDebtPage extends ConsumerStatefulWidget {
  const CreateDebtPage({super.key});

  @override
  ConsumerState<CreateDebtPage> createState() => _CreateDebtPageState();
}

class _CreateDebtPageState extends ConsumerState<CreateDebtPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? dueDate;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final space = SizedBox(
    height: 30.0.h,
  );

  Future<void> _getContact() async {
    if (Platform.isIOS) {
      final PhoneContact contact =
          await FlutterContactPicker.pickPhoneContact();

      if (contact.phoneNumber?.number != null) {
        phoneController.text = contact.phoneNumber?.number ?? '';
      }

      nameController.text = contact.fullName ?? '';
    } else if (Platform.isAndroid) {
      final FullContact contact = await FlutterContactPicker.pickFullContact();
      if (contact.emails.isNotEmpty) {
        emailController.text = contact.emails[0].email ?? '';
      }
      if (contact.phones.isNotEmpty) {
        phoneController.text = contact.phones[0].number ?? '';
      }
      nameController.text = '${(contact.name?.firstName ?? '')} '
          '${(contact.name?.middleName ?? '')} '
          '${(contact.name?.lastName ?? '')}';
    }
  }

  Future<void> _pickEmail() async {
    //used to pick email on iOS
    final EmailContact contact = await FlutterContactPicker.pickEmailContact();

    emailController.text = contact.email?.email ?? '';
  }

  void _handleCreateDebt() {
    if (_formKey.currentState!.validate()) {
      //create debt item
      if (dueDate != null) {
        final debt = Debt(
          id: DateTime.now().toIso8601String(),
          amount: double.parse(amountController.text),
          description: descriptionController.text,
          receiver: nameController.text,
          receiverPhoneNumber: phoneController.text,
          receiverEmail: emailController.text,
          sender: AppUserManager.user.fullName,
          date: DateTime.now(),
          dueDate: dueDate!,
          isPaid: false,
        );

        ref.read(debtStateProvider.notifier).addDebt(debt);
      } else {
        AppSnackbar(
          context,
          isError: true,
          text: 'Please select Due Date',
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(debtStateProvider);

    ref.listen(debtStateProvider, (previous, next) {
      if (next is CreateDebtFailure) {
        AppSnackbar(
          context,
          isError: true,
          text: next.failure.message,
        ).show();
      } else {
        Navigator.pop(context);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add Debtor')),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //Name
                TextFieldBox(
                  controller: nameController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => validator(value, Validator.normal),
                  hintText: 'Name',
                ),
                space,
                TextFieldBox(
                  prefixIcon: Platform.isIOS
                      ? IconButton(
                          onPressed: _pickEmail,
                          icon: const Icon(Icons.attach_email))
                      : null,
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Email',
                ),
                space,
                TextFieldBox(
                  controller: phoneController,
                  textInputAction: TextInputAction.next,
                  hintText: 'Phone Number',
                ),
                space,

                //Description
                TextFieldBox(
                  hintText: 'Description',
                  controller: descriptionController,
                  textInputAction: TextInputAction.next,
                  validator: (value) => validator(value, Validator.normal),
                ),
                //
                space,

                BuildDatePicker(
                  onSelectDate: (date) {
                    dueDate = date;
                  },
                ),

                space,
                //amount
                TextFieldBox(
                  hintText: 'Amount',
                  controller: amountController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  validator: (value) => validator(value, Validator.digits),
                  onEditingComplete: _handleCreateDebt,
                ),
                space,

                //Get Debtor from Contacts.
                TextButton.icon(
                  onPressed: () async {
                    await _getContact();
                  },
                  label: const Text('Add From Contacts'),
                  icon: const Icon(Icons.person_add),
                ),
                space,

                if (state is CreateDebtLoading)
                  const LoadingWidget()
                else
                  AppButton(
                    text: 'Add Debt',
                    onPressed: _handleCreateDebt,
                  ),
                SizedBox(
                  height: 10.0.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
