import 'package:flutter/material.dart';
import '../app_configs/app_colors.dart';
import '../app_configs/app_images.dart';

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
    this.bgImg, // Made optional
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
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
                      imagePath, // Use imagePath for flexibility
                      height: imageSize,
                      width: imageSize,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Value text
                Text(
                  value,
                  style: valueTextStyle ??
                      const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darBlack,
                      ),
                ),
                const SizedBox(height: 6),

                // Label text
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: labelTextStyle ??
                      const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darBlack,
                      ),
                ),
              ],
            ),
          ),
          // Background image, if provided
          if (bgImg != null)
            Positioned(
              right: 0,
              top: 0,
              child: bgImg!,
            ),
        ],
      ),
    );
  }
}
