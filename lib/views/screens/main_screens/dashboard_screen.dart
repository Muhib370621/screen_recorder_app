import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/core/utils/app_text_styles.dart';
import 'package:screen_record_app/views/components/custom_button.dart';
import 'package:screen_record_app/views/screens/main_screens/record_video_screen.dart';

import '../../../core/utils/app_colors.dart';
import '../../../services/local_storage/local_storage.dart';
import '../../../services/local_storage/local_storage_keys.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RichText(
              overflow: TextOverflow.clip,
              textAlign: TextAlign.end,
              textDirection: TextDirection.rtl,
              softWrap: true,
              textScaler: TextScaler.linear(1),
              maxLines: 1,
              text: TextSpan(
                text: '',
                style: AppTextStyles.w600Style(20.sp),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        LocalStorage.readJson(
                          key: LocalStorageKeys.programName,
                        ).toString(),
                    style: AppTextStyles.w600Style(20.sp),
                  ),
                ],
              ),
            ),
            40.h.verticalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  onTap: () {
                    Get.to(()=> RecordVideoScreen());
                  },
                  backgroundColor: AppColors.primaryColor,
                  buttonText: "Start Recording",
                  icon: Icon(Icons.video_call_outlined, color: AppColors.pureWhite),
                ),
                10.h.verticalSpace,
                CustomButton(
                  backgroundColor: AppColors.primaryColor,

                  buttonText: "View Games      ",
                  icon: Icon(Icons.games, color: AppColors.pureWhite),
                ),
                10.h.verticalSpace,
                CustomButton(
                  backgroundColor: AppColors.primaryColor,

                  buttonText: "Logout               ",
                  icon: Icon(Icons.logout, color: AppColors.pureWhite),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w,),
          ],
        ),
      ),
    );
  }
}
