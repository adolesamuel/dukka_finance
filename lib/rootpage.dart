import 'package:dukka_finance/features/dashboard/dashboard.dart';
import 'package:dukka_finance/features/debtors/app/page/list_of_debtors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/navigator.dart';
import 'features/auth/app/pages/login_screen.dart';

class RootPage extends StatefulWidget {
  // final AuthCredential? cred;
  const RootPage({
    super.key,
    // required this.cred,
  });

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder(
            // initialData: widget.cred,
            // stream: ,
            builder: (context, credSnapshot) {
              //This makes sure all screens are removed after
              //user is logged out.
              if (credSnapshot.data == null) {
                //Pop all possible logged in pages if
                //no user exists
                Future.delayed(const Duration(milliseconds: 300), () {
                  recursivePopAll(context);
                });
              }

              return const AnimatedSwitcher(
                  duration: Duration(
                    milliseconds: 500,
                  ),
                  child:
                      // credSnapshot.hasData ?
                      DebtorListPage()
                  // : const LoginScreen(),
                  );
            },
          ),
          // Consumer(
          //   builder: (context, ref, child) {
          //     // final authState = ref.watch(authStateProvider);
          //     if (authState is LogOutLoading) {
          //       return Container(
          //         color: Colors.black54,
          //         height: MediaQuery.of(context).size.height,
          //         width: MediaQuery.of(context).size.width,
          //         child: const Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     } else {
          //       return const SizedBox.shrink();
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}
