import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class SpotlightCard extends StatelessWidget {
  late String image, title;

  SpotlightCard({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2 - 16 - 8,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: colorLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 18,
                color: colorSubtitle,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "10/09/2022",
                style: subtitleTextStyle,
              )
            ],
          )
        ],
      ),
    );
  }
}
