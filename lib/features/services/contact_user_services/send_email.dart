import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendEmail(Debt debt) async {
  final Email email = Email(
    body:
        'Hi ${debt.receiver} \nThis is a reminder about the loan of ${debt.amount} I gave you,'
        ' for ${debt.description} on ${debt.date}.\n'
        'I really need it now',
    subject: 'Loan Reminder from ${debt.sender}',
    recipients: [debt.receiverEmail ?? ''],
  );

  await FlutterEmailSender.send(email);
}
