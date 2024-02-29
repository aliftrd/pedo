import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class ArticleSkeletonCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final double? width;

  const ArticleSkeletonCard({super.key, this.margin, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
            child: Container(
              height: 125,
              color: colorHint,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 22,
                width: 24,
                color: colorHint,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 22,
                width: 100,
                color: colorHint,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 22,
            width: 150,
            color: colorHint,
          ),
        ],
      ),
    );
  }
}
