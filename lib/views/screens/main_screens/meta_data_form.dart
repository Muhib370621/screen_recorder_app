import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/controller/auth/login_controller.dart';
import 'package:screen_record_app/controller/main_controllers/meta_data_controller.dart';
import 'package:screen_record_app/services/api_services/vimeo_services.dart';
import 'package:screen_record_app/services/local_storage/local_storage.dart';
import 'package:screen_record_app/services/local_storage/local_storage_keys.dart';
import '../../../core/utils/app_colors.dart';
import '../../components/custom_button.dart';

// Keep your imports unchanged

class GameSetupForm extends StatefulWidget {
  const GameSetupForm({super.key});

  @override
  State<GameSetupForm> createState() => _GameSetupFormState();
}

class _GameSetupFormState extends State<GameSetupForm> {
  final _formKey = GlobalKey<FormState>();

  String scoreType = "game";
  String sameLevel = '';
  String homeTeam = '';
  String visitorTeam = '';
  String location = '';
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

  final TextEditingController filmedByController = TextEditingController();
  final TextEditingController dateController = TextEditingController(text: '15/07/2025');
  final TextEditingController startTimeController = TextEditingController(text: '04:00 pm');
  final TextEditingController locationController = TextEditingController();

  final List<Color> colorOptions = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.brown,
    Colors.grey,
    Colors.green,
    Colors.red.shade900,
    Colors.indigo[900]!,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.yellow,
  ];

  final List<String> colorLabels = [
    "White",
    "Black",
    "Blue",
    "Brown",
    "Gray",
    "Green",
    "Maroon",
    "Navy",
    "Orange",
    "Pink",
    "Purple",
    "Red",
    "Yellow",
  ];

  void _showColorPicker(bool isHome) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a Team Color'),
          content: SizedBox(
            width: double.maxFinite,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(colorOptions.length, (index) {
                final color = colorOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isHome) {
                        homeTeamColor = color;
                      } else {
                        visitorTeamColor = color;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        colorLabels[index],
                        style: TextStyle(
                          color: color == Colors.black ? Colors.white : Colors.black,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginController = Get.put(LoginController());
    final metDataController = Get.put(MetaDataController());

    return Scaffold(
      appBar: AppBar(title: const Text('New Game or Practice')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Season:'),
                DropdownButtonFormField<String>(
                  items: loginController.getSeasons().map((e) {
                    return DropdownMenuItem(
                      value: e.seasonId,
                      child: Text(e.seasonName ?? ""),
                    );
                  }).toList(),
                  onChanged: (v) => metDataController.selectedSeason.value = v!,
                  validator: (value) => value == null ? 'Required' : null,
                ),

                const SizedBox(height: 16),
                _label('Same Level as:'),
                DropdownButtonFormField<String>(
                  items: loginController.getTeams().map((e) {
                    return DropdownMenuItem(value: e.name, child: Text(e.name ?? ""));
                  }).toList(),
                  onChanged: (v) => setState(() => sameLevel = v!),
                  validator: (value) => value == null ? 'Required' : null,
                ),

                const SizedBox(height: 8),
                _label('Score Option:'),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Score a Game'),
                        value: 'game',
                        groupValue: scoreType,
                        onChanged: (v) => setState(() => scoreType = v!),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text('Score a Practice'),
                        value: 'practice',
                        groupValue: scoreType,
                        onChanged: (v) => setState(() => scoreType = v!),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                if (scoreType == 'game') ...[
                  _label('*Home Team:'),
                  DropdownButtonFormField<String>(
                    items: loginController.getTeams().map((e) {
                      return DropdownMenuItem(value: e.id, child: Text(e.name ?? ""));
                    }).toList(),
                    onChanged: (v) => setState(() => homeTeam = v!),
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                  Row(
                    children: [
                      Container(width: 30, height: 30, color: homeTeamColor, margin: const EdgeInsets.only(right: 8)),
                      TextButton(child: const Text('change color'), onPressed: () => _showColorPicker(true)),
                    ],
                  ),

                  const SizedBox(height: 16),
                  _label('*Visitor Team:'),
                  DropdownButtonFormField<String>(
                    items: loginController.getTeams().map((e) {
                      return DropdownMenuItem(value: e.id, child: Text(e.name ?? ""));
                    }).toList(),
                    onChanged: (v) => setState(() => visitorTeam = v!),
                    validator: (value) => value == null ? 'Required' : null,
                  ),
                  Row(
                    children: [
                      Container(width: 30, height: 30, color: visitorTeamColor, margin: const EdgeInsets.only(right: 8)),
                      TextButton(child: const Text('change color'), onPressed: () => _showColorPicker(false)),
                    ],
                  ),

                  const SizedBox(height: 16),
                  _label('*Location:'),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(hintText: "where game is played"),
                    validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                  ),

                  CheckboxListTile(
                    value: isNeutralSite,
                    onChanged: (v) => setState(() => isNeutralSite = v!),
                    title: const Text('Neutral Site (Playoff or Tournament)'),
                  ),

                  const SizedBox(height: 16),
                  _label('Game Type:'),
                  Column(
                    children: gameTypes.keys.map((type) {
                      return CheckboxListTile(
                        value: gameTypes[type],
                        onChanged: (v) => setState(() => gameTypes[type] = v!),
                        title: Text(type),
                      );
                    }).toList(),
                  ),
                ],

                const SizedBox(height: 16),
                _label('*Date:'),
                TextFormField(
                  controller: dateController,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),

                const SizedBox(height: 16),
                _label('*Start Time:'),
                TextFormField(
                  controller: startTimeController,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                ),

                const SizedBox(height: 16),
                _label('*Scoring Rules:'),
                DropdownButtonFormField<String>(
                  items: loginController.getScoringRules().map((e) {
                    return DropdownMenuItem(value: e.id, child: Text(e.name ?? ""));
                  }).toList(),
                  onChanged: (v) => setState(() => scoringRules = v!),
                  validator: (value) => value == null ? 'Required' : null,
                ),

                const SizedBox(height: 16),
                _label('Filmed By:'),
                TextFormField(
                  controller: filmedByController,
                  decoration: const InputDecoration(hintText: 'name of camera operator (optional)'),
                ),

                const SizedBox(height: 16),
                _label('*Video Source:'),
                Column(
                  children: [
                    RadioListTile(value: 'cloud', groupValue: uploadOption, onChanged: (v) => setState(() => uploadOption = v!), title: const Text("Upload Video to Cloud Server")),
                    RadioListTile(value: 'youtube', groupValue: uploadOption, onChanged: (v) => setState(() => uploadOption = v!), title: const Text("YouTube URL")),
                    RadioListTile(value: 'url', groupValue: uploadOption, onChanged: (v) => setState(() => uploadOption = v!), title: const Text("Video URL (MP4 or MOV file)")),
                    RadioListTile(value: 'later', groupValue: uploadOption, onChanged: (v) => setState(() => uploadOption = v!), title: const Text("Scheduled (Upload Later)")),
                  ],
                ),

                const SizedBox(height: 16),
                _label('*Scorer:'),
                RadioListTile<String>(
                  title: const Text('Hoopsalytics will score this game for me.'),
                  value: 'hoopsalytics',
                  groupValue: scorerOption,
                  onChanged: (v) => setState(() => scorerOption = v!),
                ),
                RadioListTile<String>(
                  title: const Text('I will score the video myself'),
                  value: 'self',
                  groupValue: scorerOption,
                  onChanged: (v) => setState(() => scorerOption = v!),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return CustomButton(
          isLoading: metDataController.isLoading.value,
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              await metDataController.saveGame(
                loginController.emailController.value.text,
                loginController.passwordController.value.text,
                LocalStorage.readJson(key: LocalStorageKeys.programID),
                metDataController.selectedSeason.value,
                sameLevel,
                dateController.text,
                startTimeController.text,
                scorerOption == "self" ? "1" : "0",
                homeTeam,
                visitorTeam,
                "newHomeTeamName",
                "newVisitorTeamName",
                homeTeamColor.colorSpace.hashCode.toString(),
                visitorTeamColor.colorSpace.hashCode.toString(),
                "scorebookPhotoUrl",
                "videoUrl",
                locationController.text,
                scoringRules,
                isNeutralSite ? "1" : "0",
                "0",
              );
            } else {
              Get.snackbar("Validation Failed", "Please complete all required fields",
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          },
          buttonText: "Continue",
          backgroundColor: Colors.orange,
          icon: const Icon(Icons.arrow_forward, color: Colors.white),
        );
      }).paddingOnly(bottom: 10.h, top: 5.h),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

