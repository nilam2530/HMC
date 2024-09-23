import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_responsive_flutter/src/app_configs/app_images.dart';
import 'package:web_responsive_flutter/src/common_widgets/custom_drawer/custom_drawer.dart';
import 'package:web_responsive_flutter/src/features/dashboard/provider/dashboard_controller.dart';
import 'package:web_responsive_flutter/src/features/view_request/view_request_screen.dart';
import '../../app_configs/app_colors.dart';
import '../../common_widgets/custom_appbar/custom_appBar.dart';
import '../../utils/responsive.dart';

class ViewRequestScreen extends StatefulWidget {
  const ViewRequestScreen({super.key});

  @override
  State<ViewRequestScreen> createState() => _ViewRequestScreenState();
}

class _ViewRequestScreenState extends State<ViewRequestScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewRequestPage();
  }
}

