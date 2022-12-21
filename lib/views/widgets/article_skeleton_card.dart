import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class ArticleSkeletonCard extends StatelessWidget {
  bool? isHome;

  ArticleSkeletonCard({super.key, this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      margin: EdgeInsets.only(
        left: isHome! ? 0 : 10,
        // right: isHome! ? 0 : defaultMargin,
        bottom: isHome! ? 0 : 15,
      ),
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
              height: 124.18,
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
            width: 100,
            color: colorHint,
          ),
        ],
      ),
    );
  }
}
