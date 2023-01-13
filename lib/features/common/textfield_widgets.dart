import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldUnderline extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String> validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Color? fillColor;
  final TextInputType? keyboardType;
  final Color? normalBorderColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? hintTextColor;
  final Color? normalTextColor;
  final bool? autoFocus;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isCollapsed;
  final bool? isEnabled;
  final double? textSize;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;

  const TextFieldUnderline({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.textInputAction,
    this.obscureText,
    this.fillColor,
    this.keyboardType,
    this.normalBorderColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.hintTextColor,
    this.normalTextColor,
    this.autoFocus,
    this.suffixIcon,
    this.prefixIcon,
    this.isCollapsed = false,
    this.textSize,
    this.isEnabled,
    this.onChanged,
    this.focusNode,
    this.onEditingComplete,
  });

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.secondary;

    return SizedBox(
        height: 70.0.w,
        child: Stack(
          children: [
            TextFormField(
              onEditingComplete: onEditingComplete,
              focusNode: focusNode,
              cursorColor: accentColor,
              enabled: isEnabled,
              autofocus: autoFocus ?? false,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: textSize ?? 17.0,
                    color: normalTextColor,
                  ),
              obscureText: obscureText ?? false,
              controller: controller,
              validator: validator,
              textInputAction: textInputAction ?? TextInputAction.done,
              keyboardType: keyboardType ?? TextInputType.text,
              onChanged: onChanged,
              decoration: !isCollapsed
                  ? InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: prefixIcon != null ? 50 : 0,
                        right: suffixIcon != null ? 50 : 0,
                        top: 15,
                        bottom: 15,
                      ),
                      hintText: hintText,
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                fontSize: textSize ?? 15,
                                color: hintTextColor,
                              ),
                      errorStyle:
                          Theme.of(context).textTheme.bodyText1!.copyWith(
                                color: Colors.red,
                                fontSize: textSize ?? 12,
                                fontWeight: FontWeight.bold,
                              ),
                      filled: true,
                      fillColor: fillColor ?? Colors.white,
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(
                            color: normalBorderColor ?? Colors.white,
                          )),
                      enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(
                            color: enabledBorderColor ?? Colors.white,
                          )),
                      focusedBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: BorderSide(
                            color: focusedBorderColor ?? accentColor,
                          )),
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    )
                  : InputDecoration.collapsed(
                      hintText: hintText,
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                              fontSize: textSize ?? 15,
                              color: hintTextColor ?? Colors.white),
                      filled: true,
                      fillColor: fillColor ?? accentColor,
                    ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              heightFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15, top: 15),
                child: prefixIcon,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              heightFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, bottom: 15, top: 15),
                child: suffixIcon,
              ),
            ),
          ],
        ));
  }
}
