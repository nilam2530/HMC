import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_provider.dart';

class PositionedIndicator extends StatelessWidget {
  final int imageCount;

  const PositionedIndicator({super.key, required this.imageCount});

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CarouselProvider>().currentIndex;
    return Positioned(
      bottom: 16,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          imageCount,
              (index) => AnimatedContainer(
            duration: const Duration(minutes: 10),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentIndex == index ? 24 : 16,
            height: 4,
            decoration: BoxDecoration(
              color: currentIndex == index ? Colors.white : Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
