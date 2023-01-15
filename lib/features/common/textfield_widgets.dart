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
                      fillColor: fillColor,
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

// Reusable TextField used App Wide
class TextFieldBox extends StatelessWidget {
  final String? hintText;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? suffixColor;
  final Widget? prefixIcon;
  final bool? isCollapsed;
  final bool? isEnabled;
  final Function(String)? onChanged;
  final bool? autoFocus;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final bool? filled;
  final Color? fillColor;
  final int? maxLines;
  final FocusNode? focusNode;
  final Function()? onEditingComplete;

  const TextFieldBox({
    Key? key,
    this.hintText,
    this.height,
    this.width,
    this.controller,
    this.validator,
    this.textInputAction,
    this.obscureText,
    this.suffixColor,
    this.prefixIcon,
    this.isCollapsed,
    this.isEnabled,
    this.onChanged,
    this.autoFocus,
    this.suffixIcon,
    this.hintStyle,
    this.filled,
    this.fillColor,
    this.maxLines,
    this.focusNode,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 350.0.w,
      height: height,
      child: TextFormField(
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        maxLines: maxLines ?? 1,
        textInputAction: textInputAction,
        onEditingComplete: onEditingComplete,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontSize: 15, fontWeight: FontWeight.w400),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 17.5),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          fillColor: fillColor,
          filled: filled ?? true,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          hintText: hintText,
          hintStyle: hintStyle ?? const TextStyle(height: 0.5),
        ),
      ),
    );
  }
}
