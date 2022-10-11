import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class PetCard extends StatelessWidget {
  late String image, title, description;

  PetCard({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
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
          const SizedBox(height: 4),
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
          ),
        ],
      ),
    );
  }
}
