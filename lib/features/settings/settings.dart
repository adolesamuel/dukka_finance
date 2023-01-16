import 'package:dukka_finance/features/auth/app/state/auth_state_notifier.dart';
import 'package:dukka_finance/features/auth/data/models/app_user.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/services/app_user_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  AppUser user = AppUserManager.user;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Logged In User:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Text(
                    user.fullName,
                    style: const TextStyle(fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
              SizedBox(
                height: 200.0.h,
              ),
              AppButton(
                onPressed: () {
                  ref.read(authStateProvider.notifier).signOut();
                },
                text: 'Sign Out',
              ),
              SizedBox(
                height: 100.0.h,
              )
            ],
          ),
        ),
      );
    });
  }
}
