import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class Errors {
  static Widget maintenance() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 273,
            height: 273,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/maintenance.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            "Halaman Sedang\nDalam Perbaikan",
            style: primaryTextStyle.copyWith(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  static Widget noDataFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 273,
          height: 273,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/no_data_found.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          "Sayang sekali, belum ada data\nyang bisa kami temukan",
          textAlign: TextAlign.center,
          style: subtitleTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
