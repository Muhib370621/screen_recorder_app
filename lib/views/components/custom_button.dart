import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.buttonText,
    this.isLoading,
    this.backgroundColor,
    this.icon,
    this.onTap,
  });

  final String buttonText;
  final bool? isLoading;
  final Color? backgroundColor;
  final Widget? icon;
  void Function()? onTap;

  // final double width

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: 0.85.sw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.r)),
          color: backgroundColor
        
        ),
        child: Center(
          child:
              isLoading ?? false
                  ? CircularProgressIndicator(color: AppColors.pureWhite,)
                  : icon!=null?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon ?? SizedBox(),
                      5.w.horizontalSpace,
                      Text(
                        buttonText,
                        style: AppTextStyles.w600Style(
                          15.sp,
                          fontColor: AppColors.pureWhite,
                        ),
                      ),
                    ],
                  ):Text(
                buttonText,
                style: AppTextStyles.w600Style(
                  15.sp,
                  fontColor: AppColors.pureWhite,
                ),
              ),
        ),
      ),
    );
  }
}
