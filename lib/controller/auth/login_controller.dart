import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/model/api_models/account_type_model.dart';
import 'package:screen_record_app/model/entities/login_account_type_model.dart';
import 'package:screen_record_app/services/local_storage/local_storage.dart';
import 'package:screen_record_app/services/local_storage/local_storage_keys.dart';
import 'package:screen_record_app/views/screens/auth/select_account_type_screen.dart';
import 'package:screen_record_app/views/screens/main_screens/dashboard_screen.dart';

import '../../core/utils/prompts.dart';
import '../../services/api_services/auth_services.dart';
import '../main_controllers/meta_data_controller.dart';

class LoginController extends GetxController {
  RxBool isExpanded = false.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>().obs;
  final formKey2 = GlobalKey<FormState>().obs;
  Rx<TextEditingController> emailController =
      TextEditingController(text: "bill+test1@dettering.com").obs;
  Rx<TextEditingController> passwordController =
      TextEditingController(text: "pass9999").obs;
  Rx<AccountType> accountTypeModel = AccountType().obs;
  final metDataController = Get.put(MetaDataController());


  // RxList<LoginAccountTypeModel> accountTypeList =
  //     <LoginAccountTypeModel>[
  //       LoginAccountTypeModel(title: "ACMS", isSelected: true),
  //       LoginAccountTypeModel(title: "BasketBall Super league (Pro) 2024", isSelected: false),
  //       LoginAccountTypeModel(title: "Bay City Warriors", isSelected: false),
  //       LoginAccountTypeModel(title: "Branson Girls", isSelected: false),
  //       LoginAccountTypeModel(title: "Cerebo Sports", isSelected: false),
  //       LoginAccountTypeModel(title: "Cerebo Sports Demo", isSelected: false),
  //       LoginAccountTypeModel(title: "Esports Clube Pinheiros", isSelected: false),
  //       LoginAccountTypeModel(title: "Florida Gators Demo", isSelected: false),
  //       LoginAccountTypeModel(title: "GASO - Galvani (NBA Div)", isSelected: false),
  //       LoginAccountTypeModel(title: "GASO - Houston (NBA Div)", isSelected: false),
  //       LoginAccountTypeModel(title: "HMB Demo", isSelected: false),
  //       LoginAccountTypeModel(title: "Liga Demo 2024", isSelected: false),
  //       LoginAccountTypeModel(title: "Lonestar Shootout - U17", isSelected: false),
  //       LoginAccountTypeModel(title: "NYLA - Spring Extravaganza - 16U", isSelected: false),
  //       LoginAccountTypeModel(title: "NYLA - Swish n Dish - 17u", isSelected: false),
  //       LoginAccountTypeModel(title: "Scoring Portal", isSelected: false),
  //       LoginAccountTypeModel(title: "St. Johns University Basketball", isSelected: false),
  //       LoginAccountTypeModel(title: "Swarthmore - Centennial POC", isSelected: false),
  //       LoginAccountTypeModel(title: "TEST Only", isSelected: false),
  //       LoginAccountTypeModel(title: "University High School (5F)", isSelected: false),
  //     ].obs;

  void selectAccount(int index) {
    final metDataController = Get.put(MetaDataController());

    for (int i = 0; i < accountTypeModel.value.programs!.length; i++) {
      accountTypeModel.value.programs![i].isSelected = i == index;
      LocalStorage.saveJson(
        key: LocalStorageKeys.programID,
        value: accountTypeModel.value.programs![i].id.toString(),
      );
      LocalStorage.saveJson(
        key: LocalStorageKeys.programName,
        value: accountTypeModel.value.programs![i].name.toString(),
      );
      metDataController.selectedSeason.value =
          accountTypeModel.value.programs![i].id.toString();
    }

    accountTypeModel.refresh();
  }

  Future<AccountType> login() async {
    // try {
    isLoading.value = true;
    var result = await AuthServices().login(
      emailController.value.text,
      passwordController.value.text,
    );
    log(result.toJson().toString());
    if (result.success == 0) {
      Prompts.errorSnackBar(result.toJson().toString());
    } else {
      accountTypeModel.value = result;
      accountTypeModel.value.programs?.first.isSelected = true;
      metDataController.selectedSeason.value =
          accountTypeModel.value.programs!.first.seasons!

              .first.seasonId.toString();

      Prompts.successSnackBar("User Logged in successfully!");
      LocalStorage.saveJson(
        key: LocalStorageKeys.programID,
        value: accountTypeModel.value.programs!.first.id.toString(),
      );

      LocalStorage.saveJson(
        key: LocalStorageKeys.programName,
        value: accountTypeModel.value.programs!.first.name.toString(),
      );
      if (accountTypeModel.value.programs!.length == 1 ||
          accountTypeModel.value.programs!.isEmpty) {
        Get.offAll(() => DashboardScreen());
      } else {
        Get.offAll(() => SelectAccountTypeScreen());
      }
    }

    isLoading.value = false;
    return result;
    // } on SocketException {
    //   isLoading.value = false;
    //   Prompts.errorSnackBar("Internet Connection Not Available!");
    // } catch (e) {
    //   Prompts.errorSnackBar(e.toString());
    //
    //   isLoading.value = false;
    // }
  }

  List<Season> getSeasons() {
    int foundIndex = accountTypeModel.value.programs!.indexWhere((element) {
      return element.id ==
          LocalStorage.readJson(key: LocalStorageKeys.programID);
    });

    return accountTypeModel.value.programs![foundIndex].seasons ?? [];
  }
  List<ScoringRule> getScoringRules() {

    return accountTypeModel.value.scoringRules ?? [];
  }

  List<Team> getTeams() {
    int foundIndex = accountTypeModel.value.programs!.indexWhere((element) {
      return element.id ==
          LocalStorage.readJson(key: LocalStorageKeys.programID);
    });
    if( metDataController.selectedSeason.value.isNotEmpty) {
      int foundIndex2 = accountTypeModel.value.programs![foundIndex].seasons!
          .indexWhere((element) {
        log("element id "+element.seasonId.toString());
        log("selected  "+metDataController.selectedSeason.value.toString());

        return element.seasonId == metDataController.selectedSeason.value
        ;
      });
      return accountTypeModel.value.programs![foundIndex].seasons?[foundIndex2].teams ?? [];

    }
    else{
      return [];
    }

  }
}
