import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_provider.dart';


class PositionedTextAndButton extends StatelessWidget {
  final List<String> texts;
  final List<String> subTitle;
  final List<VoidCallback> buttonCallbacks;


  PositionedTextAndButton({
    required this.texts,
    required this.buttonCallbacks, required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<CarouselProvider>().currentIndex;

    return Positioned(
      bottom: 80,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            texts[currentIndex],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subTitle[currentIndex],
            style:  TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            width: 110,
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.white),
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12),bottomRight: Radius.circular(12))
            ),
            child: const Center(child: Text("VIEW MORE",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),)),
          )
        ],
      ),
    );
  }
}
