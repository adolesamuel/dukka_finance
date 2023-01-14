import 'package:dukka_finance/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSnackbar extends StatelessWidget {
  final String? text;
  final BuildContext context;
  final bool isError;
  const AppSnackbar(this.context, {super.key, this.text, this.isError = false});

  void show() {
    final snackbar = SnackBar(
        backgroundColor: isError
            ? AppColors.snackbarErrorColor
            : AppColors.snackbarSuccessColor,
        content: Text(
          text ?? '',
        ));
    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
