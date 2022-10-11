import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pedo/constant/themes.dart';

class LoadingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: colorDark,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Loading",
              style: primaryTextStyle.copyWith(
                color: colorDark,
                fontSize: 16,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
