import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/article_model.dart';
import 'package:pedo/core/providers/article_provider.dart';
import 'package:pedo/views/screens/article/article_detail_page.dart';
import 'package:provider/provider.dart';

class ArticleCard extends StatelessWidget {
  final int articleId;
  final EdgeInsetsGeometry? margin;

  const ArticleCard({
    super.key,
    required this.articleId,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    ArticleModel article =
        Provider.of<ArticleProvider>(context).findById(articleId);

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ArticleDetailPage.route, arguments: articleId);
      },
      child: Container(
        width: 315,
        margin: margin,
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
              child: Image.network(
                article.thumbnail,
                height: 125,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: colorSubtitle,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(article.createdAt),
                  style: subtitleTextStyle,
                ),
              ],
            ),
            Text(
              article.title,
              overflow: TextOverflow.ellipsis,
              style: primaryTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
