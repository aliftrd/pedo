import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/core/providers/auth_provider.dart';
import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/screens/pet_list/pet_list.dart';
import 'package:pedo/views/screens/more_page.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() {
    return Provider.of<ArticleProvider>(context, listen: false).getArticles();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);

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
        child: articleProvider.isLoading
            ? const Center(
                child: Text('Loading...'),
              )
            : articleProvider.articles.length < 1
                ? Center(
                    child: Text('Tidak ada artikel', style: subtitleTextStyle),
                  )
                : ListView.separated(
                    // shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, _) => const SizedBox(width: 10),
                    itemCount: articleProvider.articles.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(
                        article: articleProvider.articles[index],
                        margin: EdgeInsets.only(
                          left: index == 0 ? defaultMargin : 0,
                          right: index == articleProvider.articles.length - 1
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
                Navigator.pushNamed(context, petList.route);
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => loadData(),
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
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          MorePage.route,
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: authProvider.getUser?.image != null
                                  ? Image.network(
                                      authProvider.getUser!.image,
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )
                                  : const Text('No Image'),
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
                                  "${authProvider.getUser?.name} 👋",
                                  style: primaryTextStyle.copyWith(
                                    fontWeight: semibold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
                leading: null,
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
      ),
    );
  }
}
