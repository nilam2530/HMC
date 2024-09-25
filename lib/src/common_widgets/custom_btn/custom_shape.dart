import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/common_widgets/paint_custom/paint.dart';
class CustomShapeWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  const CustomShapeWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height), // Set the size of the CustomPaint
      painter: MyPainter(backgroundColor),
    );
  }
}


