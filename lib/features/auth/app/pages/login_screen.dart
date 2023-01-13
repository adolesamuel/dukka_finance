import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/constants/helpful_functions.dart';
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
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = kDebugMode
      ? TextEditingController(text: 'adolesamuel@yahoo.com')
      : TextEditingController();

  TextEditingController passwordTextController = kDebugMode
      ? TextEditingController(text: '123456')
      : TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.authScaffoldBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.authAppBarBgColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30),
        child: Form(
          key: _formKey,
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
                controller: emailTextController,
                hintText: 'Enter Email',
                normalTextColor: AppColors.authFontColor,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.email),
              ),
              TextFieldUnderline(
                controller: passwordTextController,
                hintText: 'Enter Password',
                normalTextColor: AppColors.authFontColor,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.password),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
