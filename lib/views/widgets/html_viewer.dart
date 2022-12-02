import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pedo/constant/themes.dart';

class HtmlViewer extends StatelessWidget {
  final String html;

  HtmlViewer(this.html);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: html,
      style: {
        '*': Style(
          margin: EdgeInsets.symmetric(horizontal: 0),
          color: colorDark,
        ),
        'p': Style(
          fontSize: const FontSize(16),
          textAlign: TextAlign.justify,
          letterSpacing: 1.0,
          wordSpacing: 1.5,
        ),
      },
    );
  }
}
