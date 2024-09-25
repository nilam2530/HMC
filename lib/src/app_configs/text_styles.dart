// Reusable TextStyle method
import 'package:flutter/material.dart';

TextStyle _textStyle() {
  return TextStyle(
    fontFamily: 'Gotham',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 18 / 14,
    // line-height calculated as a multiplier of font size
    color: Colors.white, // Adjust color as needed
  );
}
