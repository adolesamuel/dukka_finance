import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:dukka_finance/features/debtors/app/state/debt_state_notifier.dart';
import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> showUpdateContactInfoModal(
    BuildContext context, Debt debt) async {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
      TextEditingController(text: debt.receiverEmail);
  final TextEditingController phoneController =
      TextEditingController(text: debt.receiverPhoneNumber);

  final space = SizedBox(
    height: 30.0.h,
  );
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        contentPadding: EdgeInsets.zero,
        content: StatefulBuilder(
          builder: (context, setState) {
            return Consumer(builder: (context, ref, child) {
              ref.listen(debtStateProvider, (prev, next) {
                if (next is UpdateContactInfoFailure) {
                  AppSnackbar(
                    context,
                    isError: true,
                    text: next.failure.message,
                  ).show();
                } else if (next is UpdateContactInfoSuccess) {
                  Navigator.pop(context);
                }
              });

              final updateState = ref.watch(debtStateProvider);

              return SizedBox(
                  height: 400.0.h,
                  width: 400.0.w,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFieldBox(
                          width: 300.w,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          hintText: 'Email',
                        ),
                        space,
                        TextFieldBox(
                          width: 300.w,
                          controller: phoneController,
                          textInputAction: TextInputAction.next,
                          hintText: 'Phone Number',
                        ),
                        space,
                        //
                        if (updateState is UpdateContactInfoLoading)
                          const LoadingWidget()
                        else
                          AppButton(
                            width: 200.w,
                            text: 'Update',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ref
                                    .read(debtStateProvider.notifier)
                                    .updateContactInfo(
                                      debt,
                                      emailController.text,
                                      phoneController.text,
                                    );
                              }
                            },
                          ),
                      ],
                    ),
                  ));
            });
          },
        ),
      );
    },
  );
}
