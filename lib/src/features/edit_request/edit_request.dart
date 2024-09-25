import 'package:flutter/material.dart';
import 'package:web_responsive_flutter/src/features/tables/InboundDesktop.dart';
import 'package:web_responsive_flutter/src/features/tables/InboundMobile.dart';

class EditRequestScreen extends StatefulWidget {
  const EditRequestScreen({super.key});

  @override
  State<EditRequestScreen> createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            return const InboundDesktop();
          } else {
            return const InboundMobile();
          }
        },
      ),
    );
  }
}


