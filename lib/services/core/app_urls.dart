

class AppUrls {
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Base Urls~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  static String baseUrl = "https://hoopsalytics.com/api/mobile";

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Auth Urls~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

  static String loginUrl(String email, String password){
    return "$baseUrl/get-team-data.php?login=$email&password=$password";}

  static String saveGame(){
    return "http://dev.hoopsalytics.com/api/mobile/save-game.php?login=bill+test1@dettering.com&password=pass9999&&program_id=669&season_id=9&level_id=8224&home_team_id=8224&visitor_team_id=5918&game_date=2025-07-17&game_start_time=17:01&home_team_color=0&visitor_team_color=0&is_practice=0&video_url=s3.amazon.com&scoring_rules_id=1&is_neutral_site=0&self_score=0 ";}

}
