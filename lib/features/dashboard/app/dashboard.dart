import 'package:dukka_finance/configs/navigator.dart';
import 'package:dukka_finance/features/common/profile_icon.dart';
import 'package:dukka_finance/features/dashboard/app/dashboard_content.dart';
import 'package:dukka_finance/features/debtors/app/page/create_debt_page.dart';
import 'package:dukka_finance/features/debtors/app/page/list_of_debtors.dart';
import 'package:dukka_finance/features/settings/settings.dart';
import 'package:dukka_finance/features/transactions/app/pages/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  PageController pageController = PageController();

  void _onNavItemTapped(int index) {
    _selectedIndex = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: ProfileIcon(
          onPressed: () {
            _onNavItemTapped(2);
          },
        ),
        title: const Text(
          'Finance Tracker',
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: const [
          DashboardContent(),
          DebtorListPage(),
          SettingsPage(),
        ],
      ),
      floatingActionButton: SpeedDial(
        overlayColor: Colors.black12,
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
              onTap: () {
                navigate(context, const AddTransactionPage());
              },
              label: 'Add Transaction',
              child: const Icon(Icons.add)),
          SpeedDialChild(
              onTap: () {
                navigate(context, const CreateDebtPage());
              },
              label: 'Add Debtors',
              child: const Icon(Icons.add)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Debts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
