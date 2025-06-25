import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          return ListView.builder(
            itemCount: loginController.accountTypeModel.value.programs?.length,
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
          );
        }),
      ),
      bottomNavigationBar: CustomButton(
        onTap: () {
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
      ).paddingSymmetric(horizontal: 20.w,vertical: 20.h),
    );
  }
}
