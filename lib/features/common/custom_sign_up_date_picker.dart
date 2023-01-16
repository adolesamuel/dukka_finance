import 'package:dukka_finance/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSignUpDatePicker extends StatelessWidget {
  final Function()? press;
  final String buttonText;
  final Widget? iconWidget;
  final double? width;
  const CustomSignUpDatePicker({
    Key? key,
    required this.press,
    required this.buttonText,
    this.iconWidget,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: press,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => const Color(0xFFF5F5F5)),
        elevation: MaterialStateProperty.resolveWith<double>((states) => 0),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) => const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: SizedBox(
        height: 50,
        width: width ?? 350.0.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconWidget ?? const SizedBox.shrink(),
            if (iconWidget != null) const SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(buttonText,
                  style: const TextStyle(
                    color: AppColors.authAppBarBgColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
