import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:dukka_finance/features/services/contact_user_services/make_phone_call.dart';
import 'package:dukka_finance/features/services/contact_user_services/send_email.dart';
import 'package:dukka_finance/features/services/contact_user_services/send_sms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> showReminderBottomSheet(BuildContext context, Debt debt) async {
  final value = await showModalBottomSheet<bool>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    builder: (context) {
      return SizedBox(
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 200.0.w,
                child: OutlinedButton.icon(
                  onPressed: () {
                    sendEmail(debt)
                        .then((value) => Navigator.pop(context, value));
                  },
                  label: const Text('Send Email'),
                  icon: const Icon(Icons.email),
                ),
              ),
              SizedBox(
                width: 200.0.w,
                child: OutlinedButton.icon(
                  onPressed: () {
                    sendSms(debt)
                        .then((value) => Navigator.pop(context, value));
                  },
                  label: const Text('Send Message'),
                  icon: const Icon(Icons.message),
                ),
              ),
              SizedBox(
                width: 200.0.w,
                child: OutlinedButton.icon(
                  onPressed: () {
                    makePhoneCall(debt)
                        .then((value) => Navigator.pop(context, value));
                  },
                  label: const Text('Make Phone Call'),
                  icon: const Icon(Icons.phone),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  return value;
}

showDebtPaidDialog(
  BuildContext context,
  Debt debt, {
  void Function()? onSelectYes,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          content: Text(
            'Confirm Has Paid?',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          actions: [
            TextButton(
              onPressed: onSelectYes,
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      });
}
