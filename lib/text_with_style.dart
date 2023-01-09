import 'package:flutter/material.dart';

class TextWithStyle extends Text {

  TextWithStyle({super.key,
    required String data,
    Color color = Colors.black,
    double size = 18,
    weight = FontWeight.normal,
    style = FontStyle.normal,
    overflow = TextOverflow.ellipsis,
    maxLines = 1
  }): super(
      data,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        fontStyle: style,
        overflow: overflow,
      )
  );
}