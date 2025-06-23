import 'package:get/get.dart';
import 'package:screen_record_app/model/entities/login_account_type_model.dart';

class LoginController extends GetxController {

  RxBool isExpanded = false.obs;


  RxList<LoginAccountTypeModel> accountTypeList =
      <LoginAccountTypeModel>[
        LoginAccountTypeModel(title: "ACMS", isSelected: false),
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
}
