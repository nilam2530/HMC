import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final Color btnColor;
  final Color borderColor;
  final double widthFactor;  // Factor of screen width to use
  final double heightFactor; // Factor of screen height to use

  const CustomContainer({
    Key? key,
    required this.btnColor,
    required this.borderColor,
    required this.widthFactor,
    required this.heightFactor,
  }) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    // Get screen size for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return ClipPath(
      clipper: MyClipper(), // Custom clipper to match the shape
      child: CustomPaint(
        painter: MyPainter(widget.btnColor, widget.borderColor), // Custom painting with background and border color
        child: SizedBox(
          width: screenWidth * widget.widthFactor,   // Responsive width
          height: screenHeight * widget.heightFactor, // Responsive height
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(16, 0) // Move to the top left corner, with a 16 offset
      ..lineTo(size.width, 0) // Draw to the top right corner
      ..lineTo(size.width, size.height - 16) // Draw to bottom right, with a 16 offset
      ..lineTo(size.width - 16, size.height) // Draw to the bottom corner with a 16 offset
      ..lineTo(0, size.height) // Draw to bottom left corner
      ..lineTo(0, 16) // Draw to the top left corner, with a 16 offset
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // Return true if you want to reclip when state changes
  }
}

class MyPainter extends CustomPainter {
  final Color backgroundColor; // Background color of the container
  final Color borderColor;      // Border color of the container

  MyPainter(this.backgroundColor, this.borderColor); // Constructor to receive colors

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the background color
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // Define the shape path (matching the clipper's path)
    final path = Path()
      ..moveTo(16, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 16)
      ..lineTo(size.width - 16, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 16)
      ..close();

    // Draw the background
    canvas.drawPath(path, paint);

    // Paint for the border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2; // Define the thickness of the border

    // Draw the border around the shape
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
