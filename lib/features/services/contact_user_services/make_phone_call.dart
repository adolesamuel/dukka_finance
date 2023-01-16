import 'package:dukka_finance/features/debtors/models/debt.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(Debt debt) async {
  String telephoneNumber = 'tel:${debt.receiverPhoneNumber}';

  if (await canLaunchUrl(Uri.parse(telephoneNumber))) {
    await launchUrl(Uri.parse(telephoneNumber));
  }
}
