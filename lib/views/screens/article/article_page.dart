import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:pedo/views/widgets/article_skeleton_card.dart';
import 'package:pedo/views/widgets/errors.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  static String route = '/articles';

  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    ArticleProvider articleProvider = Provider.of<ArticleProvider>(context);

    Widget buildArticleCard() {
      return SliverToBoxAdapter(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, _) => const SizedBox(height: 15),
          itemCount: articleProvider.articles.length,
          itemBuilder: (context, index) => ArticleCard(
            articleId: articleProvider.articles[index].id,
            margin: EdgeInsets.only(
                left: defaultMargin,
                right: defaultMargin,
                bottom: index == articleProvider.articles.length - 1 ? 20 : 0),
          ),
        ),
      );
    }

    void onBackHandle() async {
      Navigator.pop(context);
      articleProvider.getArticles();
    }

    return WillPopScope(
      onWillPop: () async {
        onBackHandle();
        return true;
      },
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => articleProvider.getArticles(
              isHome: false,
              isRefresh: true,
            ),
            child: CustomScrollView(
              controller: articleProvider.onScrollEvent(),
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: background,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    'Artikel',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(left: defaultMargin),
                    child: IconButton(
                      onPressed: onBackHandle,
                      icon: Icon(
                        Icons.arrow_back,
                        color: colorDark,
                      ),
                    ),
                  ),
                ),
                articleProvider.isLoading && articleProvider.articles.isEmpty
                    ? SliverToBoxAdapter(
                        child: Column(
                          children: List.generate(
                            3,
                            (index) => ArticleSkeletonCard(
                              margin: EdgeInsets.only(
                                left: defaultMargin,
                                right: defaultMargin,
                                bottom: 20,
                              ),
                            ),
                          ),
                        ),
                      )
                    : articleProvider.articles.isEmpty
                        ? SliverFillRemaining(
                            child: Errors.noDataFound(),
                          )
                        : buildArticleCard()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
