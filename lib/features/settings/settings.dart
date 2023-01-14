import 'package:dukka_finance/features/auth/app/state/auth_state_notifier.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        body: Center(
          child: AppButton(
            onPressed: () {
              ref.read(authStateProvider.notifier).signOut();
            },
            text: 'Sign Out',
          ),
        ),
      );
    });
  }
}
