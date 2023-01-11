import 'package:dukka_finance/routes.dart';
import 'package:flutter/material.dart';

class DebtorListPage extends StatefulWidget {
  static const route = ScreenPaths.debtorsListScreen;
  const DebtorListPage({super.key});

  @override
  State<DebtorListPage> createState() => _DebtorListPageState();
}

class _DebtorListPageState extends State<DebtorListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //Call list of widgets here
      //or use it to listen to the list of debtors.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
