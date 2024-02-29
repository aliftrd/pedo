import 'package:flutter/material.dart';
import 'package:pedo/constant/themes.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.widget,
    this.label,
    this.icons,
    this.margin,
    this.backgroundInputColor,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Color? backgroundInputColor;
  final Widget widget;
  final Icon? icons;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Text(
              label!,
              style: primaryTextStyle.copyWith(fontSize: 16),
            ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundInputColor ?? backgroundInput,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                children: [
                  icons != null ? icons! : const SizedBox(),
                  icons != null ? const SizedBox(width: 16) : const SizedBox(),
                  Expanded(
                    child: widget,
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
