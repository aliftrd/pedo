import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/views/screens/page_switcher.dart';
import 'package:pedo/views/widgets/button.dart';

class PartnerThankyouPage extends StatelessWidget {
  static String route = '/partner-thankyou';
  const PartnerThankyouPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sabar Yaa',
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
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/on_review.png',
                width: 200,
              ),
              Text(
                'Terimakasih',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Permintaanmu sedang dalam tahap review, silahkan tunggu paling lambat 2x24jam',
                textAlign: TextAlign.center,
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              PrimaryButton(
                text: 'Kembali Ke Beranda',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PageSwitcher()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
