import 'package:dukka_finance/features/common/profile_icon.dart';
import 'package:dukka_finance/features/common/search_icon.dart';
import 'package:dukka_finance/features/dashboard/app/dashboard_content.dart';
import 'package:dukka_finance/features/settings/settings.dart';
import 'package:flutter/material.dart';

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
        actions: const [
          SearchIcon(),
        ],
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
          SizedBox(
            child: Text('Payments'),
          ),
          SettingsPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        // iconSize: 40,
        // showSelectedLabels: false,
        // showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Debts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
