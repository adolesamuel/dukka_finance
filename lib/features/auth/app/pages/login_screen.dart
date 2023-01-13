import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:dukka_finance/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const route = ScreenPaths.loginScreen;
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = kDebugMode
      ? TextEditingController(text: 'adolesamuel@yahoo.com')
      : TextEditingController();

  TextEditingController passwordTextController = kDebugMode
      ? TextEditingController(text: '123456')
      : TextEditingController();

  String? validator(String? value, String field) {
    if (value!.trim().isEmpty) {
      return "$field cannot be empty";
    } else if (field == 'Phone Number' &&
        !value.contains(RegExp(r'^[0-9]{11}$'))) {
      return "$field isn't valid";
    } else if (field == 'Password' && !(value.length > 4)) {
      return "$field isn't long enough";
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffoldBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.authAppBarBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Sign in to Dukka Debt Tracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextFieldUnderline(
              controller: controller,
              hintText: 'Enter Email',
              validator: validator,
            )
          ],
        ),
      ),
    );
  }
}
