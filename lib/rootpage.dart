import 'package:dukka_finance/features/auth/app/pages/auth_switch_screen.dart';
import 'package:dukka_finance/features/auth/app/state/auth_state.dart';
import 'package:dukka_finance/features/auth/data/repository/auth_repository.dart';
import 'package:dukka_finance/features/common/loading_widget.dart';
import 'package:dukka_finance/features/dashboard/app/dashboard.dart';
import 'package:dukka_finance/features/debtors/app/page/list_of_debtors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'configs/navigator.dart';
import 'features/auth/app/pages/login_screen.dart';
import 'features/auth/app/state/auth_state_notifier.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({
    super.key,
  });

  @override
  ConsumerState<RootPage> createState() => _RootPageState();
}

class _RootPageState extends ConsumerState<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<User?>(
            stream: ref.watch(authStateChangesProvider.stream),
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

              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 500,
                ),
                child: credSnapshot.hasData
                    ? const DashboardScreen()
                    : const AuthSwitchScreen(),
              );
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authStateProvider);
              if (authState is LogOutLoading) {
                return Container(
                  color: Colors.black54,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
