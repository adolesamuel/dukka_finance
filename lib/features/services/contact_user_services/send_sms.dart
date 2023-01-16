import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:flutter_sms/flutter_sms.dart';

Future<void> sendSms(Debt debt) async {
  final message =
      'Hi ${debt.receiver} \nThis is a reminder about the loan of ${debt.amount} I gave you,'
      ' for ${debt.description} on ${debt.date}.\n'
      'I really need it now';

  await sendSMS(message: message, recipients: [debt.receiverPhoneNumber ?? '']);
}
