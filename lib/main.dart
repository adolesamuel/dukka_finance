import 'package:dukka_finance/firebase_options.dart';
import 'package:dukka_finance/routes.dart';
import 'package:dukka_finance/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dukka Debt',
          theme: theme(),
          navigatorObservers: [
            routeObserver,
          ],
          initialRoute: '/',
          routes: routes(),
          onGenerateRoute: generateRoutes,
          scrollBehavior: const CupertinoScrollBehavior(),
        );
      },
    );
  }
}
