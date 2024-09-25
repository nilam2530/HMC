import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_configs/app_colors.dart';
import 'custom_text_field_provider.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final Function(String?) onSaved;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputAction textInputAction;
  final String? initialValue;
  final bool isDarkThemed;
  final Widget? suffix;
  final bool? enabled;
  final Color? passIconColor;
  final GlobalKey<CustomTextFieldState>? fieldKey;
  final int maxLines;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.onSaved,
    this.onChanged,
    this.isDarkThemed = false,
    this.suffix,
    this.validator,
    this.isPassword = false,
    this.textInputAction = TextInputAction.next,
    this.initialValue,
    this.enabled,
    this.passIconColor,
    this.fieldKey,
    this.maxLines = 1,
    this.controller,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create a new one with the initial value
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If initialValue or controller changes, update the text in the controller
    if (widget.controller == null && widget.initialValue != oldWidget.initialValue) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    // Only dispose of the controller if it was created internally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void clearText() {
    _controller.clear();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double padding = 8.0;
        double borderRadius = 5.0;

        if (constraints.maxWidth > 1200) {
          padding = 16.0;
          borderRadius = 10.0;
        } else if (constraints.maxWidth > 600) {
          padding = 12.0;
          borderRadius = 8.0;
        }

        return ChangeNotifierProvider(
          create: (context) => CustomTextFieldProvider(
            initialValue: widget.initialValue,
            onValueChanged: widget.onChanged,
          ),
          child: Consumer<CustomTextFieldProvider>(
            builder: (context, provider, child) {
              return TextFormField(
                controller: _controller,
                textInputAction: widget.textInputAction,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.validator,
                enabled: widget.enabled ?? true,
                obscureText: widget.isPassword && !_isPasswordVisible,
                onChanged: (value) {
                  provider.onChanged(value);
                  widget.onChanged?.call(value);
                },
                onSaved: widget.onSaved,
                maxLines: widget.maxLines,
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  filled: true,
                  fillColor: widget.isDarkThemed
                      ? const Color(0xFF034634)
                      : Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: BorderSide(
                      color: widget.isDarkThemed
                          ? AppColors.outlineBorderColor
                          : AppColors.outlineBorderColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(
                      color: AppColors.outlineBorderColor,
                      width: 1.0,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(color: Colors.red, width: 0.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                    borderSide: const BorderSide(color: Colors.red, width: 0.5),
                  ),
                  suffixIcon: widget.suffix ??
                      (widget.isPassword
                          ? GestureDetector(
                        onTap: togglePasswordVisibility,
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: widget.passIconColor ?? AppColors.secondaryTextColor,
                        ),
                      )
                          : null),
                  hintText: widget.labelText,
                  hintStyle: const TextStyle(color: AppColors.secondaryTextColor),
                ),
                style: TextStyle(
                  color: widget.isDarkThemed ? Colors.white : AppColors.secondaryTextColor,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
