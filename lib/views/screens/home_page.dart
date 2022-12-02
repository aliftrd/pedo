import 'package:flutter/material.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/core/providers/user_provider.dart';
import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  @override
  Widget build(BuildContext context) {
    ArticleHomeProvider homeProvider =
        Provider.of<ArticleHomeProvider>(context);
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    Widget articleHeader() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Artikel 📖',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ArticlePage.route);
              },
              child: Badge(
                text: 'Lihat Semua',
                borderColor: colorSubtitle,
                textColor: colorLight,
              ),
            ),
          ],
        ),
      );
    }

    Widget articleItem() {
      return Container(
        height: 200,
        child: homeProvider.isLoading
            ? const Center(
                child: Text('Loading...'),
              )
            : ListView.separated(
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, _) => const SizedBox(width: 10),
                itemCount: homeProvider.articles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: homeProvider.articles[index],
                    margin: EdgeInsets.only(
                      left: index == 0 ? defaultMargin : 0,
                      right: index == homeProvider.articles.length - 1
                          ? defaultMargin
                          : 0,
                    ),
                  );
                },
              ),
      );
    }

    Widget animalHeader() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Populer 🔥',
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, ArticlePage.route);
              },
              child: Badge(
                text: 'Lihat Semua',
                borderColor: colorSubtitle,
                textColor: colorLight,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      // appBar: AppBar(
      // ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              toolbarHeight: 60,
              backgroundColor: background,
              floating: true,
              elevation: 0,
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              IMAGES_PATH + "/kucing.png",
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: subtitleTextStyle.copyWith(
                                fontWeight: semibold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${userProvider.user!.name!} 👋",
                              style: primaryTextStyle.copyWith(
                                fontWeight: semibold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications,
                        color: colorSubtitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  articleHeader(),
                  articleItem(),
                  animalHeader(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        crossAxisSpacing: 20,
                        childAspectRatio: 3 / 4.35,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: 9,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: colorLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.asset(
                                  'assets/images/kucing.png',
                                  width: 129,
                                  height: 129,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Kucing Kampung Turunan Persia dasdasddasdas',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: subtitleTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Rp 350.000',
                                maxLines: 1,
                                style: primaryTextStyle.copyWith(
                                  fontWeight: semibold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: colorSubtitle,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Jember',
                                    style: subtitleTextStyle.copyWith(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
