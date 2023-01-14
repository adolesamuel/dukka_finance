import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  const AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 345.w,
      height: height ?? 56.h,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            //Elevation based on states
            elevation: MaterialStateProperty.resolveWith<double>((states) {
              if (states.contains(MaterialState.pressed)) {
                return 0;
              }
              return 4;
            }),
            //Border
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
              return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0));
            }),
          ),
          child: Text(
            text ?? '',
            style: const TextStyle(fontSize: 18.0),
          )),
    );
  }
}

class SmallButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Function()? onPressed;

  const SmallButton({
    Key? key,
    this.text = '',
    this.width,
    this.height,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: width ?? 140.w,
      height: height ?? 43.h,
      borderRadius: 5.0,
      text: text,
      onPressed: onPressed,
    );
  }
}

class VerySmallButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final Color? color;
  final Color? textColor;

  const VerySmallButton({
    Key? key,
    this.text = '',
    this.onPressed,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      width: 70.w,
      height: 43.h,
      borderRadius: 5.0,
      text: text,
      color: color,
      textColor: textColor,
      onPressed: onPressed,
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  final String text;
  const CustomOutlineButton(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 13.0,
          ),
          child: SizedBox(
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                ),
                const SizedBox(width: 5.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
