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
          width: 150,
          height: screenHeight * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 8),
              ],
              widget.mWidget ??
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
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
  final Color backgroundColor;

  MyPainter(this.backgroundColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(10, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 10)
      ..lineTo(size.width - 10, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, 10)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
