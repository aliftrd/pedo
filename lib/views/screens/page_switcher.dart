import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/home_page.dart';
import 'package:pedo/views/screens/more_page.dart';
import 'package:provider/provider.dart';

class PageSwitcher extends StatefulWidget {
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
        MorePage(),
      ][_currentIndex];
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        unselectedLabelStyle: primaryTextStyle.copyWith(
          fontSize: 10,
        ),
        selectedLabelStyle: primaryTextStyle.copyWith(
          fontSize: 10,
        ),
        selectedItemColor: colorDark,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icon/home.png',
              width: 24,
            ),
            label: 'Home',
            activeIcon: Image.asset(
              'assets/images/icon/home-active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icon/more.png',
              width: 24,
            ),
            label: 'More',
            activeIcon: Image.asset(
              'assets/images/icon/more-active.png',
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
