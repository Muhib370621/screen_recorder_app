import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/controller/auth/login_controller.dart';
import 'package:screen_record_app/core/utils/app_text_styles.dart';
import 'package:screen_record_app/views/components/custom_button.dart';
import 'package:screen_record_app/views/components/custom_text_field.dart';

import '../../../core/utils/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.h.verticalSpace,
                Text("Login", style: AppTextStyles.w500Style(20.sp)),
                10.h.verticalSpace,
                CustomTextField(hintText: "Enter Email"),
                loginController.isExpanded.value
                    ? Column(
                      children: [
                        SizedBox(
                          height: 0.52.sh,
                          child: ListView.builder(
                            itemCount: loginController.accountTypeList.length,
                            itemBuilder: (context, index) {
                              final item = loginController.accountTypeList[index];
                              return RadioListTile<bool>(
                                dense: true,
                                title: Text(item.title),
                                value: true,
                                groupValue: item.isSelected,
                                onChanged:
                                    (val) => loginController.selectAccount(index),
                                selected: item.isSelected,
                              );
                            },
                          ),
                        ),
                        10.h.verticalSpace,
                        CustomTextField(hintText: "Enter Password"),

                      ],
                    )
                    : SizedBox.shrink(),
                10.h.verticalSpace,
                loginController.isExpanded.value?CustomButton(
                  onTap: () {
                    // loginController.isExpanded.value=true;
                  },
                  buttonText: "Login",
                  backgroundColor: Colors.orange,
                  icon: Icon(Icons.exit_to_app_sharp, color: AppColors.pureWhite),
                ):CustomButton(
                  onTap: () {
                    loginController.isExpanded.value=true;
                  },
                  buttonText: "Continue",
                  backgroundColor: Colors.orange,
                  icon: Icon(Icons.exit_to_app_sharp, color: AppColors.pureWhite),
                ),
              ],
            ),
          );
        }).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
