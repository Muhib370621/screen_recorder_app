import 'dart:developer';

import 'package:get/get.dart';
import 'package:screen_record_app/services/api_services/hoopsalytic_services.dart';

import '../../core/utils/prompts.dart';

class MetaDataController extends GetxController{

  RxString selectedSeason= "".obs;
  RxString videPath= "".obs;
  RxBool isLoading = false.obs;


  Future<dynamic> saveGame(
      String email,
      String password,
      String programID,
      String seasonID,
      String levelID,
      String gameDate,
      String gameStartTime,
      String isPractice,
      String homeTeamID,
      String visitorTeamID,
      String newHomeTeamName,
      String newVisitorTeamName,
      String homeTeamColor,
      String visitorTeamColor,
      String scorebookPhotoUrl,
      String videoUrl,
      String location,
      String scoringRulesID,
      String isNeutralSite,
      String selfScore,
      ) async {
    // try {
    isLoading.value = true;
    var result = await HoopsylaticServices().saveGame(
        email,
        password,
        programID,
        seasonID,
        levelID,
        gameDate,
        gameStartTime,
        isPractice,
        homeTeamID,
        visitorTeamID,
        newHomeTeamName,
        newVisitorTeamName,
        homeTeamColor,
        visitorTeamColor,
        scorebookPhotoUrl,
        videoUrl,
        location,
        scoringRulesID,
        isNeutralSite,
        selfScore);
    log(result.toString());
    if (result.success == 0) {
      Prompts.errorSnackBar(result.toJson().toString());
    } else {
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


}