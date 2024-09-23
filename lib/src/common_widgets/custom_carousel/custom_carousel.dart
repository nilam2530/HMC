import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_carousel/page_view_carousel.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_carousel/positioned_indicator.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_carousel/positioned_text_button.dart';
import 'custom_provider.dart';

class CustomCarousel extends StatefulWidget {
  final List<String> images;
  final List<String> texts;
  final List<String> subTitle;
  final List<VoidCallback> buttonCallbacks;

  const CustomCarousel({
    super.key,
    required this.images,
    required this.texts,
    required this.buttonCallbacks,
    required this.subTitle,
  });

  @override
  CustomCarouselState createState() => CustomCarouselState();
}

class CustomCarouselState extends State<CustomCarousel> {
  late Timer _timer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      final provider = Provider.of<CarouselProvider>(context, listen: false);
      int nextIndex = provider.currentIndex + 1;
      if (nextIndex >= widget.images.length) {
        nextIndex = 0;
      }
      _pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      provider.updateIndex(nextIndex);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarouselProvider(),
      child: Stack(
        children: [
          PageViewCarousel(
            images: widget.images,
            pageController: _pageController,
          ),
          PositionedIndicator(imageCount: widget.images.length),
          PositionedTextAndButton(
            texts: widget.texts,
            buttonCallbacks: widget.buttonCallbacks,
            subTitle: widget.subTitle,
          ),
        ],
      ),
    );
  }
}
