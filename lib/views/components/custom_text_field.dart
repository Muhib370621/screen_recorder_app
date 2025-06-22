import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Color? borderColor;
  final Color? textColor;
  final bool? enabled;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextCapitalization? textCapitalization;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.validator,
    this.borderColor,
    this.keyboardType,
    this.controller,
    this.enabled,
    this.onChanged,
    this.textCapitalization,
    this.obscureText = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // textCapitalization: textCapitalization??TextCapitalization.none,
      onChanged: onChanged,
      keyboardType: keyboardType,
      enabled: enabled ?? true,
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        helperText: "",
        counterText: "",
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.kLightBlackBorder.withOpacity(
            0.55,
          ),
        ),
        filled: true,
        // fillColor: AppColors.purpleGradient.withOpacity(
        //   0.05,
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12.0),
        //   borderSide: const BorderSide(
        //     color: AppColors.kDarkRed,
        //     width: 1.5,
        //   ),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: borderColor ??
                  AppColors.kLightBlackBorder.withOpacity(
                    0.55,
                  ),
              width: 2.w),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: borderColor ??
                  AppColors.kLightBlackBorder.withOpacity(
                    0.55,
                  ),
              width: 2.w),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: borderColor ??
                  AppColors.kLightBlackBorder.withOpacity(
                    0.55,
                  ),
              width: 2.w),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: borderColor ??
                AppColors.kLightBlackBorder.withOpacity(
                  0.55,
                ),
          ),
        ),
      ),
      style: TextStyle(color: textColor ?? Colors.black),
    );
  }
}
