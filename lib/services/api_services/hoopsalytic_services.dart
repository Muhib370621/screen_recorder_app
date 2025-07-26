import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:screen_record_app/services/local_storage/local_storage.dart';

import '../../model/entities/local_game_model.dart';
import '../core/api_helper.dart';
import '../core/app_urls.dart';

class HoopsylaticServices {

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
    // url
    String url = AppUrls.saveGame();

    final localGame = LocalGameModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      password: password,
      programID: programID,
      seasonID: seasonID,
      levelID: levelID,
      gameDate: gameDate,
      gameStartTime: gameStartTime,
      isPractice: isPractice,
      homeTeamID: homeTeamID,
      visitorTeamID: visitorTeamID,
      newHomeTeamName: newHomeTeamName,
      newVisitorTeamName: newVisitorTeamName,
      homeTeamColor: homeTeamColor,
      visitorTeamColor: visitorTeamColor,
      scorebookPhotoUrl: scorebookPhotoUrl,
      videoUrl: videoUrl,
      location: location,
      scoringRulesID: scoringRulesID,
      isNeutralSite: isNeutralSite,
      selfScore: selfScore,
    );

// Save locally
    await LocalStorage().saveGameLocally(localGame);

    // //header
    // var header = AppHeaders.getOnlyBearerHeaders(
    //   LocalStorage.readJson(
    //     key: LocalStorageKeys.accessToken,
    //   ),
    // );

    //body
    // Map<String, dynamic> data = {
    //   'login': email,
    //   'password': password,
    //   'program_id': programID,
    //   'season_id': seasonID,
    //   'level_id': homeTeamID,
    //   'game_date': gameDate,
    //   'game_start_time': gameStartTime,
    //   'is_practice': isPractice, // 1 = practice, 0 = game
    //   'home_team_id': homeTeamID, // 0 if using new_home_team_name
    //   'visitor_team_id': visitorTeamID, // 0 if using new_visitor_team_name
    //   'new_home_team_name': newHomeTeamName,
    //   'new_visitor_team_name': newVisitorTeamName,
    //   'home_team_color': homeTeamColor,
    //   'visitor_team_color': visitorTeamColor,
    //   'scorebook_photo_url': scorebookPhotoUrl, // optional
    //   'video_url': videoUrl,
    //   'location': location,
    //   'scoring_rules_id': scoringRulesID,
    //   'is_neutral_site': isNeutralSite, // 0 or 1
    //   'self_score': selfScore // 0 or 1
    // };

    var response = await http.get(
      Uri.parse(url),

      // body: data,
    );
    if (kDebugMode) {
      log("Called API: $url");
      print("Status Code: ${response.statusCode}");
      // print("Sent Body: ${data.toString()}");
      print("Response Body: ${response.body}");
      // print("HEADERS: $header");
    }
    return (ApiHelper.returnResponse(response));
  }
}
