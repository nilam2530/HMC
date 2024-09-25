import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Color backgroundColor; // Store the background color

  MyPainter(this.backgroundColor); // Constructor to receive the color

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor // Use the passed color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(16, 0) // Move to the top left corner, with a 16 offset
      ..lineTo(size.width, 0) // Draw to the top right corner
      ..lineTo(size.width, size.height - 16) // Draw to bottom right, with a 16 offset
      ..lineTo(size.width - 16, size.height) // Draw to the bottom corner with a 16 offset
      ..lineTo(0, size.height) // Draw to bottom left corner
      ..lineTo(0, 16) // Draw to the top left corner, with a 16 offset
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Consider refining this for performance
  }
}
