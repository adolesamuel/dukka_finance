import 'package:dukka_finance/constants/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40.0,
      width: 40.0,
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 1.0,
        backgroundColor: Color(AppColors.appThemeColor),
      ),
    );
  }
}
