import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web_responsive_flutter/src/app_configs/custom_style.dart';
class CustomeTextField extends StatefulWidget {
  final Color? enabledBorder;
  final String? textTitle;
  final String? textHint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;

  const CustomeTextField(
      {super.key,
      this.onSaved,
      //  required this.labelText,
      required this.controller,
      this.enabledBorder,
      required this.textTitle,
      required this.textHint,
      this.focusNode,
      this.onTap,
      this.validator,
      this.onChanged});

  @override
  State<CustomeTextField> createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textTitle!,
          style: CustomTextSty.style14Bold,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          onSaved: (value) {
            if (widget.onSaved != null) {
              widget.onSaved!(value!);
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: widget.controller,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
            //labelText: widget.labelText,
            hintText: widget.textHint,

            labelStyle: CustomTextSty.style14NTextColor,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1),
              borderRadius: BorderRadius.circular(4.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: const Color(0xffD2D5DC).withOpacity(0.6)),
              borderRadius: BorderRadius.circular(4.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(width: 1, color: Color(0xff666CFF)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.r),
              borderSide: const BorderSide(width: 1, color: Colors.red),
            ),

            // Add additional decoration properties as needed
          ),
        ),
      ],
    );
  }
}

class CustomTextFormField extends StatefulWidget {
  final String? textHint;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function()? onTap;

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSaved;
  TextInputType? textInputType;
  List<TextInputFormatter>? inputFormatters;

  Widget? suffixIcon;
  Widget? prefixIcon;

  CustomTextFormField({
    super.key,
    this.onSaved,
    this.textInputType,
    required this.controller,
    required this.textHint,
    this.focusNode,
    this.onTap,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode _focus = FocusNode();
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.textInputType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      maxLines: 1,
      style: CustomTextSty.style14Bold,
      onTap: widget.onTap,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.red.shade400),
        helperStyle: Theme.of(context).textTheme.titleMedium,
        hintStyle: CustomTextSty.style14TextColor600,
        hintText: widget.textHint,
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.r),
            borderSide: const BorderSide(width: 1)),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: const Color(0xffD2D5DC).withOpacity(0.6), width: 1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: const BorderSide(color: Color(0xff666CFF), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.r),
          borderSide: BorderSide(color: Colors.red.shade400, width: 1),
        ),
      ),
    );
  }
}
