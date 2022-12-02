import 'package:flutter/cupertino.dart';
import 'package:pedo/constant/themes.dart';

class Badge extends StatelessWidget {
  final String text;
  EdgeInsetsGeometry? margin;
  Color? borderColor, textColor;

  Badge({required this.text, this.margin, this.borderColor, this.textColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
