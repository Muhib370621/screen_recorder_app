import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/model/entities/login_account_type_model.dart';

import '../../core/utils/prompts.dart';
import '../../services/api_services/auth_services.dart';

class LoginController extends GetxController {

  RxBool isExpanded = false.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>().obs;
  final formKey2 = GlobalKey<FormState>().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;



  RxList<LoginAccountTypeModel> accountTypeList =
      <LoginAccountTypeModel>[
        LoginAccountTypeModel(title: "ACMS", isSelected: true),
        LoginAccountTypeModel(title: "BasketBall Super league (Pro) 2024", isSelected: false),
        LoginAccountTypeModel(title: "Bay City Warriors", isSelected: false),
        LoginAccountTypeModel(title: "Branson Girls", isSelected: false),
        LoginAccountTypeModel(title: "Cerebo Sports", isSelected: false),
        LoginAccountTypeModel(title: "Cerebo Sports Demo", isSelected: false),
        LoginAccountTypeModel(title: "Esports Clube Pinheiros", isSelected: false),
        LoginAccountTypeModel(title: "Florida Gators Demo", isSelected: false),
        LoginAccountTypeModel(title: "GASO - Galvani (NBA Div)", isSelected: false),
        LoginAccountTypeModel(title: "GASO - Houston (NBA Div)", isSelected: false),
        LoginAccountTypeModel(title: "HMB Demo", isSelected: false),
        LoginAccountTypeModel(title: "Liga Demo 2024", isSelected: false),
        LoginAccountTypeModel(title: "Lonestar Shootout - U17", isSelected: false),
        LoginAccountTypeModel(title: "NYLA - Spring Extravaganza - 16U", isSelected: false),
        LoginAccountTypeModel(title: "NYLA - Swish n Dish - 17u", isSelected: false),
        LoginAccountTypeModel(title: "Scoring Portal", isSelected: false),
        LoginAccountTypeModel(title: "St. Johns University Basketball", isSelected: false),
        LoginAccountTypeModel(title: "Swarthmore - Centennial POC", isSelected: false),
        LoginAccountTypeModel(title: "TEST Only", isSelected: false),
        LoginAccountTypeModel(title: "University High School (5F)", isSelected: false),
      ].obs;

  void selectAccount(int index) {
        for (int i = 0; i < accountTypeList.length; i++) {
              accountTypeList[i].isSelected = i == index;
        }
        accountTypeList.refresh();
  }

  login() async {
    // try {
      isLoading.value = true;
      var result = await AuthServices().login(
        emailController.value.text,
        passwordController.value.text,
      );
      log(result.toString());
      if(result['success']==0){
        Prompts.errorSnackBar(result['error']);
      }

      isLoading.value = false;
      return true;
    // } on SocketException {
    //   isLoading.value = false;
    //   Prompts.errorSnackBar("Internet Connection Not Available!");
    // } catch (e) {
    //   Prompts.errorSnackBar(e.toString());
    //
    //   isLoading.value = false;
    // }
  }

}
