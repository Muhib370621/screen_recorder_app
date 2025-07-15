

class AppUrls {
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Base Urls~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//
  static String baseUrl = "https://hoopsalytics.com/api/mobile";

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Auth Urls~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~//

  static String loginUrl(String email, String password){
    return "$baseUrl/get-team-data.php?login=$email&password=$password";}

  static String saveGame(){
    return "$baseUrl/save-game.php";}

}
