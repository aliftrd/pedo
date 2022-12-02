import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/widgets/article_card.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatefulWidget {
  static String route = '/articles';

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(() {
      ArticlePageProvider provider =
          Provider.of<ArticlePageProvider>(context, listen: false);
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!provider.isLastPage) {
          provider.getArticles();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ArticlePageProvider articleProvider =
        Provider.of<ArticlePageProvider>(context);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => articleProvider.getArticles(isRefresh: true),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
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
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: colorDark,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: defaultMargin),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.filter_alt,
                        color: colorDark,
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, _) => const SizedBox(height: 15),
                  itemCount: !articleProvider.isLastPage
                      ? articleProvider.articles.length + 1
                      : articleProvider.articles.length,
                  itemBuilder: (context, index) =>
                      (index < articleProvider.articles.length)
                          ? Container(
                              height: 200,
                              margin: EdgeInsets.only(
                                  left: defaultMargin,
                                  right: defaultMargin,
                                  bottom: index ==
                                          articleProvider.articles.length - 1
                                      ? 20
                                      : 0),
                              child: ArticleCard(
                                article: articleProvider.articles[index],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(bottom: defaultMargin),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: colorPrimary,
                                ),
                              ),
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
