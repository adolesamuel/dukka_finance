import 'package:dukka_finance/constants/app_colors.dart';
import 'package:dukka_finance/constants/helpful_functions.dart';
import 'package:dukka_finance/features/auth/app/state/auth_state.dart';
import 'package:dukka_finance/features/auth/app/state/auth_state_notifier.dart';
import 'package:dukka_finance/features/common/app_snackbar.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/common/textfield_widgets.dart';
import 'package:dukka_finance/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const route = ScreenPaths.loginScreen;
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = kDebugMode
      ? TextEditingController(text: 'adolesamuel@yahoo.com')
      : TextEditingController();

  TextEditingController passwordTextController = kDebugMode
      ? TextEditingController(text: '123456')
      : TextEditingController();

  bool isPasswordHidden = true;

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      ref.read(authStateProvider.notifier).login(
          email: emailTextController.text,
          password: passwordTextController.text);
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    ref.listen(authStateProvider, (prev, next) {
      if (next is LogInFailureState) {
        AppSnackbar(
          context,
          text: next.failure.message,
          isError: true,
        ).show();
      } else if (next is LogInSuccessState) {
        Navigator.pop(context);
      }
    });
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
                textInputAction: TextInputAction.next,
                validator: (value) => validator(value, Validator.email),
              ),
              TextFieldUnderline(
                controller: passwordTextController,
                obscureText: isPasswordHidden,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hintText: 'Enter Password',
                normalTextColor: AppColors.authFontColor,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.password),
                onEditingComplete: _handleSignIn,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    isPasswordHidden = !isPasswordHidden;
                  }),
                  child: isPasswordHidden
                      ? const Icon(
                          Icons.visibility,
                          color: AppColors.authFontColor,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: AppColors.authFontColor,
                        ),
                ),
              ),
              if (authState is LogInLoadingState)
                const LoadingWidget()
              else
                AppButton(
                  onPressed: _handleSignIn,
                  text: 'Sign In',
                )
            ],
          ),
        ),
      ),
    );
  }
}
