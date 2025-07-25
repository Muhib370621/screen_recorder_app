class LocalGameModel {
  String id; // You can use timestamp or UUID
  String email;
  String password;
  String programID;
  String seasonID;
  String levelID;
  String gameDate;
  String gameStartTime;
  String isPractice;
  String homeTeamID;
  String visitorTeamID;
  String newHomeTeamName;
  String newVisitorTeamName;
  String homeTeamColor;
  String visitorTeamColor;
  String scorebookPhotoUrl;
  String videoUrl;
  String location;
  String scoringRulesID;
  String isNeutralSite;
  String selfScore;

  LocalGameModel({
    required this.id,
    required this.email,
    required this.password,
    required this.programID,
    required this.seasonID,
    required this.levelID,
    required this.gameDate,
    required this.gameStartTime,
    required this.isPractice,
    required this.homeTeamID,
    required this.visitorTeamID,
    required this.newHomeTeamName,
    required this.newVisitorTeamName,
    required this.homeTeamColor,
    required this.visitorTeamColor,
    required this.scorebookPhotoUrl,
    required this.videoUrl,
    required this.location,
    required this.scoringRulesID,
    required this.isNeutralSite,
    required this.selfScore,
  });

  factory LocalGameModel.fromJson(Map<String, dynamic> json) {
    return LocalGameModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      programID: json['programID'],
      seasonID: json['seasonID'],
      levelID: json['levelID'],
      gameDate: json['gameDate'],
      gameStartTime: json['gameStartTime'],
      isPractice: json['isPractice'],
      homeTeamID: json['homeTeamID'],
      visitorTeamID: json['visitorTeamID'],
      newHomeTeamName: json['newHomeTeamName'],
      newVisitorTeamName: json['newVisitorTeamName'],
      homeTeamColor: json['homeTeamColor'],
      visitorTeamColor: json['visitorTeamColor'],
      scorebookPhotoUrl: json['scorebookPhotoUrl'],
      videoUrl: json['videoUrl'],
      location: json['location'],
      scoringRulesID: json['scoringRulesID'],
      isNeutralSite: json['isNeutralSite'],
      selfScore: json['selfScore'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'programID': programID,
    'seasonID': seasonID,
    'levelID': levelID,
    'gameDate': gameDate,
    'gameStartTime': gameStartTime,
    'isPractice': isPractice,
    'homeTeamID': homeTeamID,
    'visitorTeamID': visitorTeamID,
    'newHomeTeamName': newHomeTeamName,
    'newVisitorTeamName': newVisitorTeamName,
    'homeTeamColor': homeTeamColor,
    'visitorTeamColor': visitorTeamColor,
    'scorebookPhotoUrl': scorebookPhotoUrl,
    'videoUrl': videoUrl,
    'location': location,
    'scoringRulesID': scoringRulesID,
    'isNeutralSite': isNeutralSite,
    'selfScore': selfScore,
  };
}
