import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import '../../../common_widgets/custom_carousel/custom_carousel.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final dashBoardController = Provider.of<DashBoardController>(context);
    return Scaffold(
      body: SizedBox(
        height: 300,
        width: 800,
        child: CustomCarousel(
          images: dashBoardController.images,
          texts: dashBoardController.texts,
          subTitle: dashBoardController.subTitle,
          buttonCallbacks: dashBoardController.buttonCallbacks,
        ),
      ),
    );
  }
}
