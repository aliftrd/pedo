import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:pedo/views/widgets/html_viewer.dart';
import 'package:provider/provider.dart';

class ArticleDetailPage extends StatelessWidget {
  static String route = '/article-detail';

  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final articleId = ModalRoute.of(context)?.settings.arguments;
    final articleDetail =
        Provider.of<ArticleProvider>(context).findById(articleId);

    Widget article() {
      int categoryIndex = -1;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            articleDetail.title,
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: bold,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              articleDetail.thumbnail,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: articleDetail.categories.map((category) {
              categoryIndex++;
              return Badge(
                text: category.title,
                borderColor: colorPrimary,
                margin: EdgeInsets.only(
                  top: 10,
                  right: categoryIndex < articleDetail.categories.length - 1
                      ? 10
                      : 0,
                ),
              );
            }).toList(),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              vertical: articleDetail.categories.length < 1 ? 20 : 10,
            ),
            child: HtmlViewer(articleDetail.description),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
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
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: article(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
