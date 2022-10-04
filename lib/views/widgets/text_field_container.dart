import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class TextInputContainer extends StatelessWidget {
  const TextInputContainer({
    Key? key,
    required this.label,
    required this.textFormField,
    required this.icons,
    this.margin,
  }) : super(key: key);

  final EdgeInsets? margin;
  final TextFormField textFormField;
  final Icon icons;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: primaryTextStyle.copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColorInput,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                children: [
                  icons,
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: textFormField,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
