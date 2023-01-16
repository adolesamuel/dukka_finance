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

class SignUpScreen extends ConsumerStatefulWidget {
  static const route = ScreenPaths.signUpScreen;
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailTextController = kDebugMode
      ? TextEditingController(text: 'adolesamuel@yahoo.com')
      : TextEditingController();

  TextEditingController fullNameTextController = kDebugMode
      ? TextEditingController(text: 'Adole Samuel')
      : TextEditingController();

  TextEditingController passwordTextController = kDebugMode
      ? TextEditingController(text: '123456')
      : TextEditingController();

  TextEditingController confirmPasswordController = kDebugMode
      ? TextEditingController(text: '123456')
      : TextEditingController();

  bool isNewPasswordHidden = true;
  bool isConfirmPasswordHidden = true;

  void _handleSignup() {
    if (_formKey.currentState!.validate()) {
      ref.read(authStateProvider.notifier).createPassword(
            email: emailTextController.text,
            fullName: fullNameTextController.text,
            password: passwordTextController.text,
          );
    }
  }

  @override
  void dispose() {
    emailTextController.dispose();
    fullNameTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    ref.listen(authStateProvider, (previous, next) {
      if (next is CreatePasswordFailureState) {
        AppSnackbar(
          context,
          text: next.failure.message,
          isError: true,
        ).show();
      } else if (next is CreatePasswordSuccessState) {
        AppSnackbar(
          context,
          text: 'Account Created',
        ).show();
        Navigator.pop(context);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.authScaffoldBgColor,
      appBar: AppBar(
        foregroundColor: Colors.white,
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
                'Sign up to Dukka Debt Tracker',
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
                textInputAction: TextInputAction.next,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.email),
              ),
              TextFieldUnderline(
                controller: fullNameTextController,
                hintText: 'Enter Full Name',
                normalTextColor: AppColors.authFontColor,
                textInputAction: TextInputAction.next,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.normal),
              ),
              TextFieldUnderline(
                controller: passwordTextController,
                obscureText: isNewPasswordHidden,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                hintText: 'Enter Password',
                normalTextColor: AppColors.authFontColor,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(value, Validator.password),
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    isNewPasswordHidden = !isNewPasswordHidden;
                  }),
                  child: isNewPasswordHidden
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
              TextFieldUnderline(
                controller: confirmPasswordController,
                obscureText: isConfirmPasswordHidden,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                hintText: 'Confirm Password',
                normalTextColor: AppColors.authFontColor,
                hintTextColor: AppColors.authFontColor,
                validator: (value) => validator(
                  value,
                  Validator.confirmPassword,
                  passwordText: passwordTextController.text,
                ),
                suffixIcon: GestureDetector(
                  onTap: () => setState(() {
                    isConfirmPasswordHidden = !isConfirmPasswordHidden;
                  }),
                  child: isConfirmPasswordHidden
                      ? const Icon(
                          Icons.visibility,
                          color: AppColors.authFontColor,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: AppColors.authFontColor,
                        ),
                ),
                onEditingComplete: _handleSignup,
              ),
              if (authState is CreatePasswordLoadingState)
                const LoadingWidget()
              else
                AppButton(
                  onPressed: _handleSignup,
                  text: 'Submit',
                )
            ],
          ),
        ),
      ),
    );
  }
}
