import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class AnimalSkeletonCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const AnimalSkeletonCard({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              height: 130,
              color: colorHint,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 22,
            color: colorHint,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 22,
            color: colorHint,
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Container(
                height: 15,
                width: 15,
                color: colorHint,
              ),
              const SizedBox(
                width: 5,
              ),
              Container(
                height: 15,
                width: 60,
                color: colorHint,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
