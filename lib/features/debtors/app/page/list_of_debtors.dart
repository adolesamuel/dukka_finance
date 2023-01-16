import 'package:dukka_finance/features/auth/app/state/auth_state_notifier.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebtorListPage extends StatefulWidget {
  static const route = ScreenPaths.debtorsListScreen;
  const DebtorListPage({super.key});

  @override
  State<DebtorListPage> createState() => _DebtorListPageState();
}

class _DebtorListPageState extends State<DebtorListPage> {
  final spacer = SizedBox(height: 5.0.h);

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
    return Scaffold(
      body: Center(
        child: SizedBox.expand(
          child: Column(
            children: [
              const Text('Total Debts'),
              spacer,
              const Text(
                'N30,000,',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              spacer,
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    onTap: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
