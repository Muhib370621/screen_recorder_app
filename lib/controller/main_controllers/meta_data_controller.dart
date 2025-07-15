import 'package:get/get.dart';

class MetaDataController extends GetxController{

  RxString selectedSeason= "".obs;


  Future<dynamic> saveGame() async {
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


}