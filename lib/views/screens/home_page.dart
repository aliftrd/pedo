import 'package:flutter/material.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:pedo/views/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              onTap: () => Navigator.pushNamed(context, ArticlePage.route),
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
      return SizedBox(
        height: 200,
        child: articleProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: colorPrimary,
                ),
              )
            : articleProvider.articles.isEmpty
                ? Center(
                    child: Text('Tidak ada artikel', style: subtitleTextStyle),
                  )
                : ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, _) => const SizedBox(width: 10),
                    itemCount: articleProvider.articles.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(
                        articleId: articleProvider.articles[index].id,
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
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => articleProvider.getArticles(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              CustomAppBar(),
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
                        itemCount: 8,
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
                                    '$imagesPath/kucing.png',
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
