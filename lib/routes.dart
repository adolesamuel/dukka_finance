import 'package:dukka_finance/rootpage.dart';
import 'package:flutter/material.dart';

import 'features/auth/app/pages/login_screen.dart';

const String homeRoute = '/home';

class ScreenPaths {
  static const String loginScreen = '/login_screen';
}

Map<String, WidgetBuilder> routes(
    // {required AuthCredential? credential}
    ) {
  return <String, WidgetBuilder>{
    //if user is logged in return dashboard with user, else return loginpage

    '/': (context) => const RootPage(),
    LoginScreen.route: (context) => const LoginScreen(),
  };
}

Route<dynamic>? generateRoutes(RouteSettings settings) {
  //This feature only works on androidd currently,
  // if (settings.name!.startsWith('/Reset')) {
  //   return MaterialPageRoute(
  //       builder: (context) => PasswordResetPage(
  //             slug: settings.name!.split('/').last,
  //           ));
  // } else {
  //   return MaterialPageRoute(builder: (context) => const UnknownPage());
  // }

  // switch (settings.name) {
  //   case AverageWeightOnPickupDayScreen.route:
  //     {
  //       final batch = settings.arguments as Batch;

  //       return CupertinoPageRoute(
  //         settings: RouteSettings(
  //           name: ScreenPaths.averageWeightOnPickupDayScreen,
  //           arguments: batch,
  //         ),
  //         builder: (context) => AverageWeightOnPickupDayScreen(batch: batch),
  //       );
  //     }

  //   default:
  //     return CupertinoPageRoute(
  //       builder: (context) => const UnknownScreen(),
  //     );
  // }
}
