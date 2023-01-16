import 'dart:io';

import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

class CreateDebtPage extends StatefulWidget {
  const CreateDebtPage({super.key});

  @override
  State<CreateDebtPage> createState() => _CreateDebtPageState();
}

class _CreateDebtPageState extends State<CreateDebtPage> {
  final _formKey = GlobalKey<FormState>();

  final space = SizedBox(
    height: 30.0.h,
  );

  getContact() async {
    if (Platform.isIOS) {
    } else if (Platform.isAndroid) {
      final FullContact contact = await FlutterContactPicker.pickFullContact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Debtor')),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              //Name
              TextFieldBox(
                // controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (value) => validator(value, Validator.normal),
                // hintText: activityType == ActivityType.credit
                //     ? 'Sender Name'
                //     : 'Reciever Name',
              ),
              space,

              //Description
              TextFieldBox(
                hintText: 'Description',
                // controller: descController,
                textInputAction: TextInputAction.next,
                validator: (value) => validator(value, Validator.normal),
              ),

              space,
              //amount
              TextFieldBox(
                hintText: 'Amount',
                // controller: amountController,
                textInputAction: TextInputAction.done,
                validator: (value) => validator(value, Validator.normal),
                // onEditingComplete: _handleAddTransaction,
              ),
              space,

              //Get Debtor from Contacts.
              TextButton.icon(
                onPressed: () {},
                label: const Text('Add From Contacts'),
                icon: const Icon(Icons.person_add),
              ),

              // if (state is AddTransactionLoadingState)
              //   const LoadingWidget()
              // else
              //   AppButton(
              //     text: 'Add Transaction',
              //     onPressed: _handleAddTransaction,
              //   ),
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
