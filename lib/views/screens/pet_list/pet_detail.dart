import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:pedo/views/screens/pet_list/pet_list.dart';

class petDetail extends StatefulWidget {
  static String route = '/petDetail';
  const petDetail({super.key});

  @override
  State<petDetail> createState() => _petDetailState();
}

class _petDetailState extends State<petDetail> {
  List images = [
    'assets/images/kucing.png',
    'assets/images/kucing.png',
    'assets/images/kucing.png',
  ];

  @override
  Widget build(BuildContext context) {
    Widget detailPet() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: images
                .map(
                  (
                    image,
                  ) =>
                      Image.asset(
                    image,
                    width: MediaQuery.of(context).size.width,
                    height: 375,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(),
          ),
          SizedBox(height: 15),
          Text(
            'Anggora Kampung Coklat',
            style: subtitleTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Rp 350.000',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: semibold,
            ),
          )
        ],
      );
    }

    Widget DetailPetMid() {
      return Row(
        children: [
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/images/kucing.png',
                  width: 40,
                  height: 40,
                ),
              )
            ],
          )
        ],
      );
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Pet',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: defaultMargin),
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorDark,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: detailPet(),
                  ),
                  DetailPetMid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
