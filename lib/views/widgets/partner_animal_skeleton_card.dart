import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class PartnerAnimalSkeletonCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  const PartnerAnimalSkeletonCard({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: colorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
            child: Container(
              height: 125,
              width: 125,
              color: colorHint,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 22,
                    width: MediaQuery.of(context).size.width / 2,
                    color: colorHint,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 22,
                    width: 80,
                    color: colorHint,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 20,
                    width: 120,
                    color: colorHint,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
