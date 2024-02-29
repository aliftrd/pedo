import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class PrimaryButton extends StatelessWidget {
  String text;
  VoidCallback? onPressed;
  EdgeInsetsGeometry? margin;

  PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: primaryTextStyle.copyWith(
            color: colorDark,
            fontSize: 16,
            fontWeight: medium,
          ),
        ),
      ),
    );
  }
}
