import 'package:dukka_finance/configs/navigator.dart';
import 'package:dukka_finance/constants/asset_strings.dart';
import 'package:dukka_finance/features/common/button_widget.dart';
import 'package:dukka_finance/features/common/looping_video_widget.dart';
import 'package:dukka_finance/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthSwitchScreen extends StatefulWidget {
  static const route = '/auth_switch_screen';
  const AuthSwitchScreen({super.key});

  @override
  State<AuthSwitchScreen> createState() => _AuthSwitchScreenState();
}

class _AuthSwitchScreenState extends State<AuthSwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Transform.scale(
              scale: 1.25,
              child: const LoopingVideoWidget(
                  fileUrl: AssetStrings.introVideoUrl)),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black26,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: SizedBox(
              height: 200.0.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Dukka',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'Debt Tracker',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  AppButton(
                    onPressed: () {
                      navigateName(context, ScreenPaths.loginScreen);
                    },
                    text: 'Sign In',
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      navigateName(context, ScreenPaths.signUpScreen);
                    },
                    child: const Text(
                      'Create account',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
