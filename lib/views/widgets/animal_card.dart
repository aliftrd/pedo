import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/animal_model.dart';
import 'package:pedo/core/providers/animal_provider.dart';
import 'package:pedo/utils/currency.dart';
import 'package:pedo/views/screens/animal/animal_detail_page.dart';
import 'package:provider/provider.dart';

class AnimalCard extends StatelessWidget {
  final int animalId;
  final EdgeInsetsGeometry? margin;

  const AnimalCard({
    super.key,
    required this.animalId,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    AnimalModel animalProvider =
        Provider.of<AnimalProvider>(context).findById(animalId);

    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return AnimalDetailPage(
              animalDetail: animalProvider,
            );
          },
        ));
      },
      child: Container(
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
                animalProvider.images[0].path,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              animalProvider.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            Text(
              animalProvider.isPaid
                  ? Currency.rupiah(value: animalProvider.price, withRp: true)
                  : 'Free',
              maxLines: 1,
              style: primaryTextStyle.copyWith(
                fontWeight: semibold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: colorSubtitle,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Jember',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
