import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/common_widgets/paint_custom/paint.dart';

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
          width: screenHeight * 0.08,
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


