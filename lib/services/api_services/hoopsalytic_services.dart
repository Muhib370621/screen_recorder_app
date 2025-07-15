class HoopsylaticServices {

  Future<dynamic>saveGame(
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
  String home_team_color
  String visitor_team_color
  String scorebook_photo_url (optional)
  String video_url
  String location
  String scoring_rules_id
  String is_neutral_site (0/1)
  String self_score (0/1)
      ) async {
    // url
    String url = AppUrls.loginUrl(email, password);

    // //header
    // var header = AppHeaders.getOnlyBearerHeaders(
    //   LocalStorage.readJson(
    //     key: LocalStorageKeys.accessToken,
    //   ),
    // );

    //body
    // var data = {"email": email, "password": password};
    var response = await http.post(
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
    return AccountType.fromJson(ApiHelper.returnResponse(response));
  }

}