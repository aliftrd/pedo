import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/main.dart';
import 'package:pedo/views/widgets/badge.dart';
import 'package:pedo/views/screens/pet/pet_list.dart';

class PetDetail extends StatefulWidget {
  static String route = '/petDetail';
  const PetDetail({super.key});

  @override
  State<PetDetail> createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetail> {
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
          ),
        ],
      );
    }

    Widget detailPetMid() {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    'assets/images/kucing.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mahamatra',
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        'Jember',
                        style: subtitleTextStyle.copyWith(
                          fontSize: 11,
                          fontWeight: regular,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    size: 14,
                    Icons.message,
                    color: colorLight,
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: colorSuccess,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Icon(
                    size: 14,
                    Icons.location_on,
                    color: colorLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget detailHewan() {
      return Container(
        padding: EdgeInsets.only(
          top: 25,
          left: defaultMargin,
          right: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Ras',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Gender',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Warna Primer',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Warna Primer',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kucing',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      'Anggora',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      'Laki-Laki',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      'Kuning',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      'Putih',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: [
                Text(
                  'Deskripsi Hewan',
                  style: primaryTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semibold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Column(
              children: [
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa tincidunt arcu pulvinar etiam nibh risus. Venenatis mauris adipiscing in facilisis sit sed id a. Diam urna, proin faucibus aliquet lectus. Viverra amet justo bibendum tincidunt leo. Urna magna ac eget sodales purus est integer tellus eget. Tincidunt urna amet sed bibendum mattis nulla velit lacus. Neque, pretium, ligula varius imperdiet et et vivamus. Quam eget non consequat aliquam tempus suspendisse turpis mi tincidunt. Ante et nunc faucibus sed tellus malesuada fringilla elit. At id quis non suspendisse. Suspendisse luctus vel iaculis rhoncus, eu. In fringilla ut tempor, mi diam sed non vestibulum. Pellentesque sed vel nullam et. Blandit eu dui est sagittis, amet, nunc aliquet. Ut augue sodales quis at vitae eget mauris. Et mauris venenatis sed sagittis, et eu. Condimentum urna habitasse pellentesque hendrerit consequat viverra ut. ',
                  style: subtitleTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  ),
                ),
              ],
            ),
          ],
        ),
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
                  detailPetMid(),
                  detailHewan(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
