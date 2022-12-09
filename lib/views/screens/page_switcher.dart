import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/screens/home_page.dart';

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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 273,
                    height: 273,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/maintenance.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Text(
                    "Halaman Sedang",
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: medium,
                    ),
                  ),
                  Text(
                    "Dalam Perbaikan",
                    style: primaryTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ][_currentIndex];
    }

    return Scaffold(
      body: body(),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
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
              'assets/icons/home.png',
              width: 24,
            ),
            label: 'Home',
            activeIcon: Image.asset(
              'assets/icons/home-active.png',
              width: 24,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/pets.png',
              width: 24,
            ),
            label: 'My Pets',
            activeIcon: Image.asset(
              'assets/icons/pets-active.png',
              width: 24,
            ),
          ),
        ],
      ),
    );
  }
}
