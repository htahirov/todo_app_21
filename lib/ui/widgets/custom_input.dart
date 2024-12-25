import 'package:flutter/material.dart';

import '../../utils/constants/app_borders.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.isObsecure = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
  }) : assert(hintText == null || labelText == null);

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool isObsecure;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      enabled: enabled,
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        labelText: labelText,
        border: AppBorders.inputBorder,
        enabledBorder: AppBorders.inputBorder,
        focusedBorder: AppBorders.inputBorder,
        errorBorder: AppBorders.inputBorder
            .copyWith(borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder: AppBorders.inputBorder
            .copyWith(borderSide: const BorderSide(color: Colors.red)),
        disabledBorder: AppBorders.inputBorder
            .copyWith(borderSide: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }
}
