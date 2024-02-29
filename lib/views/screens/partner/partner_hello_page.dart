import 'package:flutter/material.dart';
import 'package:pedo/constant/assets_path.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/providers/partner_register_provider.dart';
import 'package:pedo/views/screens/partner/partner_register_page.dart';
import 'package:pedo/views/screens/partner/partner_thankyou_page.dart';
import 'package:pedo/views/widgets/button.dart';

class PartnerHelloPage extends StatelessWidget {
  static String route = '/partnership-register';
  const PartnerHelloPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Selamat Datang di PEDO',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(top: 34),
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  children: [
                    Image.asset(
                      '$imagesPath/partnership.png',
                      width: 200,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Untuk memulai memposting hewan, anda harus mendaftar sebagai mitra dengan melengkapi informasi yang diperlukan.",
                      textAlign: TextAlign.center,
                      style: primaryTextStyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Lanjutkan',
                      onPressed: () async {
                        var response =
                            await PartnerRegisterProvider().requestPending();

                        if (response['code'] == 200) {
                          Navigator.pushNamed(
                              context, PartnerRegisterPage.route);
                        } else {
                          Navigator.pushNamed(
                              context, PartnerThankyouPage.route);
                        }
                      },
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
