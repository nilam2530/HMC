import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_provider.dart';

class PageViewCarousel extends StatelessWidget {
  final List<String> images;
  final PageController pageController;

  const PageViewCarousel({
    super.key,
    required this.images,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CarouselProvider>(context, listen: false);
    return PageView.builder(
      controller: pageController,
      itemCount: images.length,
      onPageChanged: (index) {
        provider.updateIndex(index);
      },
      itemBuilder: (context, index) {
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
