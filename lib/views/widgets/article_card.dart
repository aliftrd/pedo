import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/article_model.dart';
import 'package:pedo/views/screens/article/article_detail_page.dart';

class ArticleCard extends StatelessWidget {
  final ArticleModel article;
  final EdgeInsetsGeometry? margin;

  ArticleCard({
    super.key,
    required this.article,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ArticleDetailPage(article);
      })),
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
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  article.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                const Icon(
                  Icons.access_time,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(DateFormat('MMM dd, yyyy').format(article.createdAt)),
              ],
            ),
            Text(
              '${article.id} . ${article.title}',
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
