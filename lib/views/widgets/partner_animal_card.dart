import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/animal_model.dart';
import 'package:pedo/core/providers/partner_provider.dart';
import 'package:pedo/utils/currency.dart';
import 'package:pedo/views/screens/animal/animal_detail_page.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:provider/provider.dart';

class PartnerAnimalCard extends StatelessWidget {
  final int animalId;
  final EdgeInsetsGeometry? margin;
  const PartnerAnimalCard({super.key, required this.animalId, this.margin});

  @override
  Widget build(BuildContext context) {
    AnimalModel animals =
        Provider.of<PartnerProvider>(context).findById(animalId);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AnimalDetailPage(
            animalDetail: animals,
          );
        }));
      },
      child: Container(
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
              child: Image.network(
                animals.images[0].path,
                width: 120,
                fit: BoxFit.cover,
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
                    Text(
                      animals.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: primaryTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Badge(
                      text: animals.type.title,
                      borderColor: colorPrimary,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      animals.isPaid
                          ? Currency.rupiah(
                              value: animals.price,
                              withRp: true,
                            )
                          : 'Free',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: primaryTextStyle.copyWith(
                        fontWeight: semibold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
