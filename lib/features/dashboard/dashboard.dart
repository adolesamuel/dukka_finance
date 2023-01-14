//Show recently added debts
//show next due debts

import 'package:dukka_finance/features/common/profile_icon.dart';
import 'package:dukka_finance/features/common/search_icon.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const ProfileIcon(),
        title: const Text(
          'Finance Tracker',
        ),
        actions: const [
          SearchIcon(),
        ],
      ),
      body: SizedBox.expand(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Text('Current Balance'),
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
                  itemBuilder: ((context, index) => const ListTile(
                        title: Text('Expense'),
                      )))),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Debts'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings')
        ],
      ),
    );
  }
}
