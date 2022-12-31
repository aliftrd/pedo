import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/animal_model.dart';
import 'package:pedo/core/providers/partner_post_provider.dart';
import 'package:pedo/core/providers/partner_provider.dart';
import 'package:pedo/utils/currency.dart';
import 'package:pedo/views/screens/animal/animal_detail_page.dart';
import 'package:pedo/views/screens/partner/partner_post_page.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:provider/provider.dart';

class PartnerAnimalCard extends StatelessWidget {
  final int animalId;
  final EdgeInsetsGeometry? margin;
  final String status;
  const PartnerAnimalCard({
    super.key,
    required this.animalId,
    required this.status,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    PartnerProvider partnerProvider = Provider.of<PartnerProvider>(context);
    AnimalModel animals = partnerProvider.findById(animalId);

    void adoptedHandle() async {
      await Provider.of<PartnerPostProvider>(context, listen: false)
          .updateAdoptAnimal(
        animalId: animalId.toString(),
      );
      partnerProvider.getPartnerAnimal(status: status, isRefresh: true);
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: colorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return AnimalDetailPage(
                  animalDetail: animals,
                );
              }));
            },
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
          status != 'adopted'
              ? SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PartnerPostPage(
                                  animal: animals,
                                  status: status,
                                );
                              },
                            ));
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: const Center(
                              child: Text('Edit'),
                            ),
                          ),
                        ),
                      ),
                      status == 'pending'
                          ? const SizedBox()
                          : const VerticalDivider(
                              width: 2,
                            ),
                      status == 'pending'
                          ? const SizedBox()
                          : Expanded(
                              child: InkWell(
                                onTap: adoptedHandle,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Center(
                                    child: Text('Teradopsi'),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
