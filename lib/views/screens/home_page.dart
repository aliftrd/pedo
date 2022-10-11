import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/about_page.dart';
import 'package:pedo/views/screens/login_page.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:pedo/views/widgets/pet_card.dart';
import 'package:pedo/views/widgets/spotlight_card.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Widget header() {
      return Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: defaultMargin, vertical: defaultMargin),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/home_hero.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PEDO",
                  style: primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      tooltip: "Profil",
                      onPressed: () {
                        Navigator.pushNamed(context, AboutPage.route);
                      },
                      icon: const Icon(
                        Icons.account_circle,
                        size: 24,
                      ),
                    ),
                    IconButton(
                      tooltip: "Notifikasi",
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications,
                        size: 24,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: screenHeight / 33),
            Consumer<AuthProvider>(
              builder: (context, auth, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📍 Bondowoso",
                    style: primaryTextStyle.copyWith(
                      color: colorLight,
                      fontWeight: medium,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "${auth.user.name}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: primaryTextStyle.copyWith(
                      color: colorLight,
                      fontWeight: medium,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    "${auth.user.level}",
                    style: primaryTextStyle.copyWith(
                      color: colorLight,
                      fontWeight: medium,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget spotlightTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: defaultMargin,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Spotlight 🔥',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
      );
    }

    Widget spotlightItem() {
      return Container(
        margin: const EdgeInsets.only(top: 9),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: defaultMargin),
              SpotlightCard(
                image: 'assets/images/post.png',
                title: 'Kucing Tetangga Anggora',
              ),
              SpotlightCard(
                image: 'assets/images/kucing.png',
                title: 'Kucing Stress',
              ),
            ],
          ),
        ),
      );
    }

    Widget popularTitle() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Text(
          'Popular 🔥',
          style: primaryTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semibold,
          ),
        ),
      );
    }

    var items = [
      PetCard(
        image: 'assets/images/kucing.png',
        title: 'Kucing Arab',
        description: 'Kucing',
      ),
      PetCard(
        image: 'assets/images/post.png',
        title: 'Kucing Mesir',
        description: 'Kucing',
      ),
      PetCard(
        image: 'assets/images/kucing.png',
        title: 'Kucing Madinah',
        description: 'Kucing',
      ),
      PetCard(
        image: 'assets/images/post.png',
        title: 'Kucing Alaska',
        description: 'Kucing',
      ),
    ];
    Widget popularItem() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        margin: EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 20,
            runSpacing: 15,
            direction: Axis.horizontal,
            children: items.map((item) {
              return item;
            }).toList(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            spotlightTitle(),
            spotlightItem(),
            popularTitle(),
            popularItem(),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
