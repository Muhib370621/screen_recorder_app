class AccountType {
  final int? success;
  final List<ScoringRule>? scoringRules;
  final List<Program>? programs;

  AccountType({this.success, this.scoringRules, this.programs});

  factory AccountType.fromJson(Map<String, dynamic> json) {
    return AccountType(
      success: json['success'],
      scoringRules: (json['scoring_rules'] as List?)
          ?.map((e) => ScoringRule.fromJson(e))
          .toList(),
      programs: (json['programs'] as List?)
          ?.map((e) => Program.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'scoring_rules': scoringRules?.map((e) => e.toJson()).toList(),
    'programs': programs?.map((e) => e.toJson()).toList(),
  };
}

class ScoringRule {
  final String? id;
  final String? name;
  final String? level;

  ScoringRule({this.id, this.name, this.level});

  factory ScoringRule.fromJson(Map<String, dynamic> json) {
    return ScoringRule(
      id: json['id'],
      name: json['name'],
      level: json['level'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'level': level,
  };
}

class Program {
  final String? id;
  final String? name;
  final String? defaultSeasonId;
  final String? scoringRulesLevel;
  final int? weScoreBalance;
  final List<Season>? seasons;
   bool? isSelected;

  Program({
    this.id,
    this.name,
    this.defaultSeasonId,
    this.scoringRulesLevel,
    this.weScoreBalance,
    this.seasons,
    this.isSelected,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'],
      name: json['name'],
      defaultSeasonId: json['default_season_id'],
      scoringRulesLevel: json['scoring_rules_level'],
      weScoreBalance: json['we_score_balance'],
      seasons: (json['seasons'] as List?)
          ?.map((e) => Season.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'default_season_id': defaultSeasonId,
    'scoring_rules_level': scoringRulesLevel,
    'we_score_balance': weScoreBalance,
    'seasons': seasons?.map((e) => e.toJson()).toList(),
  };
}

class Season {
  final String? seasonId;
  final String? seasonName;
  final List<Team>? teams;

  Season({this.seasonId, this.seasonName, this.teams});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      seasonId: json['season_id'],
      seasonName: json['season_name'],
      teams:
      (json['teams'] as List?)?.map((e) => Team.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'season_id': seasonId,
    'season_name': seasonName,
    'teams': teams?.map((e) => e.toJson()).toList(),
  };
}

class Team {
  final String? id;
  final String? shortName;
  final String? name;
  final String? myTeam;
  final String? sameLevelAs;

  Team({
    this.id,
    this.shortName,
    this.name,
    this.myTeam,
    this.sameLevelAs,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      shortName: json['short_name'],
      name: json['name'],
      myTeam: json['my_team'],
      sameLevelAs: json['same_level_as'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'short_name': shortName,
    'name': name,
    'my_team': myTeam,
    'same_level_as': sameLevelAs,
  };
}
