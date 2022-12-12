import 'package:flutter/material.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/widgets/errors.dart';

class PageSwitcher extends StatefulWidget {
  static String route = '/page-switcher';

  const PageSwitcher({super.key});

  @override
  State<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _currentIndex = 0;

  void _onItemTapped(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      return [
        HomePage(),
        Scaffold(
          body: SafeArea(
            child: Errors.maintenance(),
          ),
        ),
      ][_currentIndex];
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        unselectedLabelStyle: primaryTextStyle.copyWith(
          fontSize: 10,
        ),
        selectedLabelStyle: primaryTextStyle.copyWith(
          fontSize: 10,
        ),
        selectedItemColor: colorDark,
        backgroundColor: colorLight,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              '$iconsPath/home.png',
              width: 24,
            ),
            label: 'Beranda',
            activeIcon: Image.asset(
              '$iconsPath/home-active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              '$iconsPath/pets.png',
              width: 24,
            ),
            label: 'Kemitraan',
            activeIcon: Image.asset(
              '$iconsPath/pets-active.png',
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
