import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/home/home.dart';
import 'package:pro_mobile/ui/settings/settings_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    SettingsPage(title: "Home"),
    SettingsPage(title: "Events"),
    SettingsPage(title: "Settings"),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFEDEFF1),
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.tinGrey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Add Goals',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
