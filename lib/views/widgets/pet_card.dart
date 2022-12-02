import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class PetCard extends StatelessWidget {
  final String image, title, description;

  const PetCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: colorDark,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              width: 129,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: primaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: semibold,
            ),
          ),
          Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: subtitleTextStyle.copyWith(
              fontSize: 10,
              fontWeight: regular,
            ),
          )
        ],
      ),
    );
  }
}
