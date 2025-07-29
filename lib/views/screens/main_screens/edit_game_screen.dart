import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:screen_record_app/controller/auth/login_controller.dart';
import 'package:screen_record_app/controller/main_controllers/meta_data_controller.dart';
import 'package:screen_record_app/services/local_storage/local_storage.dart';
import 'package:screen_record_app/services/local_storage/local_storage_keys.dart';
import '../../../core/utils/app_colors.dart';
import '../../../model/entities/local_game_model.dart';
import '../../components/custom_button.dart';

class EditGameForm extends StatefulWidget {
  final LocalGameModel game;
  final Function(LocalGameModel updatedGame) onUpdate;

  const EditGameForm({super.key, required this.game, required this.onUpdate});

  @override
  State<EditGameForm> createState() => _EditGameFormState();
}

class _EditGameFormState extends State<EditGameForm> {
  final _formKey = GlobalKey<FormState>();
  final loginController = Get.put(LoginController());
  final metDataController = Get.put(MetaDataController());

  late TextEditingController dateController;
  late TextEditingController timeController;
  late TextEditingController locationController;

  String scoreType = "game";
  String sameLevel = '';
  String homeTeam = '';
  String visitorTeam = '';
  String scoringRules = '';
  String scorerOption = 'hoopsalytics';
  String uploadOption = 'youtube';

  Color homeTeamColor = Colors.white;
  Color visitorTeamColor = Colors.black;

  bool isNeutralSite = false;
  Map<String, bool> gameTypes = {
    'Pre-Season': false,
    'League': false,
    'Division': false,
    'Tournament': false,
    'Playoff': false,
    'Scrimmage': false,
  };

  @override
  void initState() {
    super.initState();
    dateController = TextEditingController(text: widget.game.gameDate);
    timeController = TextEditingController(text: widget.game.gameStartTime);
    locationController = TextEditingController(text: widget.game.location);

    homeTeam = widget.game.homeTeamID;
    visitorTeam = widget.game.visitorTeamID;
    sameLevel = widget.game.levelID;
    scoringRules = widget.game.scoringRulesID;
    isNeutralSite = widget.game.isNeutralSite == "1";
    homeTeamColor = Colors.white; // Replace with color from string if stored
    visitorTeamColor = Colors.black;
    setState(() {

    });// Replace with color from string if stored
  }

  void _showColorPicker(bool isHome) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a Team Color'),
          content: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Colors.white,
              Colors.black,
              Colors.blue,
              Colors.red,
              Colors.green,
              Colors.orange,
              Colors.purple,
              Colors.grey,
            ].map((color) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isHome) {
                      homeTeamColor = color;
                    } else {
                      visitorTeamColor = color;
                    }
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: color, border: Border.all()),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void updateGame() {
    final updatedGame = LocalGameModel(
      id: widget.game.id,
      email: widget.game.email,
      password: widget.game.password,
      programID: widget.game.programID,
      seasonID: metDataController.selectedSeason.value,
      levelID: sameLevel,
      gameDate: dateController.text,
      gameStartTime: timeController.text,
      isPractice: scoreType == 'practice' ? "1" : "0",
      homeTeamID: homeTeam,
      visitorTeamID: visitorTeam,
      newHomeTeamName: widget.game.newHomeTeamName,
      newVisitorTeamName: widget.game.newVisitorTeamName,
      homeTeamColor: homeTeamColor.toString(),
      visitorTeamColor: visitorTeamColor.toString(),
      scorebookPhotoUrl: widget.game.scorebookPhotoUrl,
      videoUrl: widget.game.videoUrl,
      location: locationController.text,
      scoringRulesID: scoringRules,
      isNeutralSite: isNeutralSite ? "1" : "0",
      selfScore: widget.game.selfScore,
    );

    // List games = GetStorage().read("local_games") ?? [];
    // final index = games.indexWhere((g) => g['id'] == updatedGame.id);
    // if (index != -1) {
    //   games[index] = updatedGame.toJson();
    //   GetStorage().write("local_games", games);
    // }

    widget.onUpdate(updatedGame);

    Get.back();
    Get.snackbar("Success", "Game Edited Successfully",
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Game")),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: widget.game.seasonID,
                  items: loginController.getSeasons().map((e) => DropdownMenuItem(
                    value: e.seasonId,
                    child: Text(e.seasonName ?? ""),
                  )).toList(),
                  onChanged: (v) => metDataController.selectedSeason.value = v!,
                  decoration: const InputDecoration(labelText: "Season"),
                ),
                DropdownButtonFormField<String>(
                  // value: sameLevel,
                  items: loginController.getTeams().map((e) => DropdownMenuItem(
                    value: e.name,
                    child: Text(e.name ?? ""),
                  )).toList(),
                  onChanged: (v) => setState(() => sameLevel = v!),
                  decoration: const InputDecoration(labelText: "Same Level as"),
                ),
                DropdownButtonFormField<String>(
                  // value: homeTeam,
                  items: loginController.getTeams().map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name ?? ""),
                  )).toList(),
                  onChanged: (v) => setState(() => homeTeam = v!),
                  decoration: const InputDecoration(labelText: "Home Team"),
                ),
                Row(
                  children: [
                    Container(width: 30, height: 30, color: homeTeamColor),
                    TextButton(
                      onPressed: () => _showColorPicker(true),
                      child: const Text("Change Color"),
                    )
                  ],
                ),
                DropdownButtonFormField<String>(
                  // value: visitorTeam,
                  items: loginController.getTeams().map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name ?? ""),
                  )).toList(),
                  onChanged: (v) => setState(() => visitorTeam = v!),
                  decoration: const InputDecoration(labelText: "Visitor Team"),
                ),
                Row(
                  children: [
                    Container(width: 30, height: 30, color: visitorTeamColor),
                    TextButton(
                      onPressed: () => _showColorPicker(false),
                      child: const Text("Change Color"),
                    )
                  ],
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
                CheckboxListTile(
                  title: const Text("Neutral Site"),
                  value: isNeutralSite,
                  onChanged: (val) => setState(() => isNeutralSite = val!),
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Game Date"),
                ),
                TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: "Game Time"),
                ),
                DropdownButtonFormField<String>(
                  value: scoringRules,
                  items: loginController.getScoringRules().map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name ?? ""),
                  )).toList(),
                  onChanged: (v) => setState(() => scoringRules = v!),
                  decoration: const InputDecoration(labelText: "Scoring Rules"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateGame,
                  child: const Text("Save Changes"),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
