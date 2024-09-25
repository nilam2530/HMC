import 'package:flutter/material.dart';

class MyCustomButton extends StatefulWidget {
  final String name;
  final Color btnColor;
  final Color textColor;
  final Widget? mWidget;
  final VoidCallback onTap;
  final Image? icon;

  const MyCustomButton({
    Key? key,
    required this.name,
    required this.textColor,
    required this.btnColor,
    required this.onTap,
    this.mWidget,
    this.icon,
  }) : super(key: key);

  @override
  State<MyCustomButton> createState() => _MyCustomButtonState();
}

class _MyCustomButtonState extends State<MyCustomButton> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return CustomPaint(
      painter: MyPainter(widget.btnColor), // Pass btnColor here
      child: GestureDetector(
        onTap: widget.onTap,
        child: SizedBox(
          width: 200,
          height: screenHeight * 0.08,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the content
            children: [
              if (widget.icon != null) ...[
                // Display the icon if provided
                widget.icon!,
                const SizedBox(width: 8), // Space between icon and text
              ],
              widget.mWidget ??
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: widget.textColor,
                      fontFamily: "OpenSansBold",
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color backgroundColor; // Store the background color

  MyPainter(this.backgroundColor); // Constructor to receive the color

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor // Use the passed color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(16, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 16)
      ..lineTo(size.width - 16, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 16)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Consider refining this for performance
  }
}
