import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/core/utils/app_text_styles.dart';
import 'package:screen_record_app/views/screens/main_screens/dashboard_screen.dart';
import '../../../controller/auth/login_controller.dart';
import '../../../core/utils/app_colors.dart';
import '../../components/custom_button.dart';

class SelectAccountTypeScreen extends StatelessWidget {
  const SelectAccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    log(loginController.accountTypeModel.value.programs!.length.toString());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Program",
                style: AppTextStyles.w600Style(20.sp),
              ).paddingOnly(left: 25.w),
              Expanded(
                child: ListView.builder(
                  itemCount:
                      loginController.accountTypeModel.value.programs?.length,
                  itemBuilder: (context, index) {
                    final item =
                        loginController.accountTypeModel.value.programs?[index];
                    return RadioListTile<bool>(
                      dense: true,
                      title: Text(item?.name ?? ""),
                      value: true,
                      groupValue: item?.isSelected,
                      onChanged: (val) => loginController.selectAccount(index),
                      selected: item?.isSelected ?? false,
                    );
                  },
                ),
              ),
            ],
          ).paddingSymmetric(vertical: 10.h);
        }),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
          Get.to(()=> DashboardScreen());
          // if (loginController.formKey.value.currentState!
          //     .validate() &&
          //     loginController.formKey2.value.currentState!
          //         .validate()) {
          //   loginController.login();
          // }
        },
        buttonText: "Login",
        backgroundColor: Colors.orange,
        icon: Icon(Icons.exit_to_app_sharp, color: AppColors.pureWhite),
      ).paddingSymmetric(horizontal: 20.w, vertical: 20.h),
    );
  }
}
