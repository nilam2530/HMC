import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

import '../../app_configs/app_colors.dart';

class CustomAnimatedDropdown<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T) itemAsString;
  final String? hintText;
  final void Function(T?)? onChanged;

  const CustomAnimatedDropdown({
    super.key,
    required this.items,
    required this.itemAsString,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1,color: AppColors.outlineBorderColor),
        borderRadius: BorderRadius.circular(8), // Optional: Rounded corners

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomDropdown<T>.search(
          hintText: hintText ?? '--Please Select --',
          items: items,
          excludeSelected: false,
          onChanged: onChanged,
          decoration: const CustomDropdownDecoration(
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColors.darBlack,
            ),
          ),
        ),
      ),
    );
  }
}
