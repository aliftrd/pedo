import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class InputValidation {
  static Widget error(String message) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        message,
        style: primaryTextStyle.copyWith(color: colorDanger),
      ),
    );
  }
}
