import 'package:flutter/material.dart';

class ArabicText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final TextAlign align;
  const ArabicText(this.text, {super.key, this.fontSize, this.align = TextAlign.center});

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.displayMedium!;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SelectableText(
        text,
        textAlign: align,
        style: base.copyWith(
          fontFamily: 'Amiri',
          fontSize: fontSize ?? base.fontSize,
          height: 1.8,
        ),
      ),
    );
  }
}
