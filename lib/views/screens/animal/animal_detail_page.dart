import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/models/animal_model.dart';
import 'package:pedo/utils/currency.dart';
import 'package:pedo/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimalDetailPage extends StatelessWidget {
  static String route = '/animal-detail';
  final AnimalModel animalDetail;
  const AnimalDetailPage({super.key, required this.animalDetail});

  @override
  Widget build(BuildContext context) {
    void launchWhatsApp({required String phone}) async {
      String phoneNumberID = phone.replaceAll(RegExp(r'^0'), '62');
      String url() {
        if (Platform.isIOS) {
          return "whatsapp://wa.me/$phoneNumberID/?text=Halo+Apa+Hewan+Ini+Masih+Ada?";
        } else {
          return "whatsapp://send?phone=$phoneNumberID&text=Halo+Apa+Hewan+Ini+Masih+Ada?";
        }
      }

      await canLaunch(url())
          ? launch(url())
          : Toast.showError(context, 'Your doesn\'t have WhatsApp installed');
    }

    Widget carouselImage() {
      return CarouselSlider(
        items: animalDetail.images.map((image) {
          return Image.network(
            image.path,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          );
        }).toList(),
        options: CarouselOptions(),
      );
    }

    Widget headerDetail() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              animalDetail.title,
              style: subtitleTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              animalDetail.isPaid
                  ? Currency.rupiah(value: animalDetail.price, withRp: true)
                  : 'Free',
              style: primaryTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      );
    }

    Widget onwerSection() {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    animalDetail.userMeta.user.image,
                    width: 45,
                    height: 45,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        animalDetail.userMeta.user.name,
                        style: primaryTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: regular,
                        ),
                      ),
                      Text(
                        animalDetail.userMeta.village.name,
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
                InkWell(
                  onTap: () async =>
                      launchWhatsApp(phone: animalDetail.userMeta.phone),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: colorSuccess,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      size: 18,
                      Icons.phone,
                      color: colorLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget descriptionDetail() {
      return Container(
        margin: EdgeInsets.only(top: 20, bottom: defaultMargin),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                    const SizedBox(width: 2),
                    Text(
                      'Ras',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Gender',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Warna Primer',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      'Warna Sekunder',
                      style: subtitleTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    const SizedBox(width: 2),
                  ],
                ),
                const SizedBox(width: 120),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      animalDetail.type.title,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      animalDetail.breed.title,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      animalDetail.gender,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      animalDetail.primaryColor,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                    Text(
                      animalDetail.secondaryColor,
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 5),
            Column(
              children: [
                Text(
                  animalDetail.description,
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
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Detail Hewan',
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
              child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      carouselImage(),
                      headerDetail(),
                      onwerSection(),
                      descriptionDetail(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
