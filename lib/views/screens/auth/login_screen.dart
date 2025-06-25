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
                Form(
                  key: loginController.formKey.value,
                  child: CustomTextField(
                    controller: loginController.emailController.value,
                    hintText: "Enter Email",
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ) {
                        // loginController.isValidEmail.value = false;
                        return 'Enter a valid email';
                      } else {
                        // loginController.isValidEmail.value = true;
                      }
                      return null;
                    },
                  ),
                ),
                 Form(
                   key: loginController.formKey2.value,
                   child: CustomTextField(
                     controller: loginController.passwordController.value,
                     hintText: "Enter Password",
                     validator: (value) {
                       if (value == null || value.isEmpty) {
                         // loginController.isValidEmail.value = false;
                         return 'Password cant be empty';
                       } else {
                         // loginController.isValidEmail.value = true;
                       }
                       return null;
                     },
                   ),
                 )
                    ,
                10.h.verticalSpace,
                CustomButton(
                      onTap: () {
                        if (loginController.formKey.value.currentState!
                            .validate() &&
                            loginController.formKey2.value.currentState!
                                .validate()) {
                          loginController.login();
                        }
                      },
                      buttonText: "Continue",
                      backgroundColor: Colors.orange,
                      icon: Icon(
                        Icons.exit_to_app_sharp,
                        color: AppColors.pureWhite,
                      ),
                    ),
              ],
            ),
          );
        }).paddingSymmetric(horizontal: 20.w),
      ),
    );
  }
}
