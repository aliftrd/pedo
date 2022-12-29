import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/animal_provider.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/screens/article/article_page.dart';
import 'package:pedo/views/screens/animal/animal_page.dart';
import 'package:pedo/views/widgets/animal_skeleton_card.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:pedo/views/widgets/article_skeleton_card.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:pedo/views/widgets/custom_appbar.dart';
import 'package:pedo/views/widgets/animal_card.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);
    AnimalProvider animalProvider = Provider.of<AnimalProvider>(context);

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
                articleProvider.getArticles();
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
      return !articleProvider.isLoading && articleProvider.articles.isEmpty
          ? const Center(
              child: Text('Belum ada artikel'),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: articleProvider.isLoading
                    ? List.generate(
                        3,
                        (index) => ArticleSkeletonCard(
                          width: width * 2.3 / 3,
                          margin: EdgeInsets.only(
                            left: index == 0 ? defaultMargin : 20,
                            right: index == 2 ? defaultMargin : 0,
                          ),
                        ),
                      )
                    : articleProvider.articles.map((article) {
                        return ArticleCard(
                          articleId: article.id,
                          margin: EdgeInsets.only(
                            left: article == articleProvider.articles.first
                                ? defaultMargin
                                : 20,
                            right: article == articleProvider.articles.last
                                ? defaultMargin
                                : 0,
                          ),
                        );
                      }).toList(),
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
                animalProvider.getAnimals();
                Navigator.pushNamed(context, AnimalPage.route);
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

    Widget animalItem() {
      return !animalProvider.isLoading && animalProvider.animals.isEmpty
          ? const Center(
              child: Text('Belum ada hewan'),
            )
          : articleProvider.isLoading
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      3,
                      (index) => AnimalSkeletonCard(
                        margin: index.bitLength == 2
                            ? EdgeInsets.only(bottom: defaultMargin)
                            : null,
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: StaggeredGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: List.generate(
                      animalProvider.animals.length,
                      (index) => AnimalCard(
                        animalId: animalProvider.animals[index].id,
                        margin: animalProvider.animals[index] ==
                                animalProvider.animals.last
                            ? EdgeInsets.only(bottom: defaultMargin)
                            : null,
                      ),
                    ),
                  ),
                );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            articleProvider.getArticles();
            animalProvider.getAnimals();
            return Future.delayed(const Duration(seconds: 1));
          },
          child: CustomScrollView(
            controller: animalProvider.onScrollEvent(),
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              CustomAppBar(),
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      articleHeader(),
                      articleItem(),
                      animalHeader(),
                      animalItem(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
