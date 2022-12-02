import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class Toast {
  static showSuccess(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorSuccess,
        content: Text(text),
      ),
    );
  }

  static showError(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: colorDanger,
        content: Text(text),
      ),
    );
  }
}
