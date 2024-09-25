import 'package:flutter/material.dart';

import '../app_configs/app_colors.dart';

class SummaryCard extends StatelessWidget {
  final String imagePath;
  final String value;
  final String label;
  final Color backgroundColor;
  final double imageSize;
  final TextStyle? valueTextStyle;
  final TextStyle? labelTextStyle;
  final Color iconBackgroundColor;
  final Image? bgImg;
  final double opacity;

  const SummaryCard({
    super.key,
    required this.imagePath,
    required this.value,
    required this.label,
    this.backgroundColor = Colors.white,
    this.imageSize = 20.0,
    this.valueTextStyle,
    this.labelTextStyle,
    required this.iconBackgroundColor,
    this.bgImg,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Opacity(
        opacity: opacity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth < 200
                ? constraints.maxWidth * 0.9
                : 272.0; // Fixed width for larger screens
            const cardHeight = 110.0;

            return Container(
              width: 220,
              height: cardHeight + 10,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Icon with background color
                        Container(
                          width: imageSize + 10,
                          height: imageSize + 10,
                          decoration: BoxDecoration(
                            color: iconBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(
                              imagePath,
                              height: imageSize,
                              width: imageSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Value text
                        Text(
                          value,
                          style: _textStyle(
                            constraints,
                            valueTextStyle,
                            isLabel: false,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        // Label text
                        Text(
                          label,
                          textAlign: TextAlign.center,
                          style: _textStyle(
                            constraints,
                            labelTextStyle,
                            isLabel: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Background image, if provided
                  if (bgImg != null)
                    Positioned(
                      right: 4,
                      top: 2,
                      child: bgImg!,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle _textStyle(BoxConstraints constraints, TextStyle? style,
      {required bool isLabel}) {
    final baseFontSize = isLabel
        ? (constraints.maxWidth > 600 ? 16.0 : 14.0)
        : (constraints.maxWidth > 600 ? 20.0 : 18.0);
    return (style ?? TextStyle()).copyWith(
      fontSize: baseFontSize,
      fontWeight: isLabel ? FontWeight.w500 : FontWeight.bold,
      color: AppColors.darBlack,
    );
  }
}
