//Show recently added debts
//show next due debts

import 'package:dukka_finance/features/common/profile_icon.dart';
import 'package:dukka_finance/features/common/search_icon.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ProfileIcon(
          onPressed: () {
            _onItemTapped(2);
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
        onTap: _onItemTapped,
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

class DashboardContent extends StatefulWidget {
  const DashboardContent({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox.expand(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        const Text('Current Balance'),
        //add Upcoming Debt Tracker.
        const Text(
          '10000.00',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) => const ListTile(
              title: Text('Expense'),
            ),
          ),
        ),
      ]),
    );
  }
}
