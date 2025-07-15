import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/controller/auth/login_controller.dart';
import 'package:screen_record_app/controller/main_controllers/meta_data_controller.dart';

import '../../../core/utils/app_colors.dart';
import '../../components/custom_button.dart';

class GameSetupForm extends StatefulWidget {
  const GameSetupForm({super.key});

  @override
  State<GameSetupForm> createState() => _GameSetupFormState();
}

class _GameSetupFormState extends State<GameSetupForm> {
  String sameLevel = 'ACMS Girls';
  String homeTeam = 'ACMS Girls';
  String visitorTeam = 'Carson Valley Girls 8th';
  String location = 'ACMS';
  String scoringRules = 'High School (8 minute quarters)';
  String scorerOption = 'hoopsalytics';

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

  final List<Color> colorOptions = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.brown,
    Colors.grey,
    Colors.green,
    Colors.red.shade900,
    Colors.indigo[900]!, // Navy
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
                          color:
                              color == Colors.black
                                  ? Colors.white
                                  : Colors.black,
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
      appBar: AppBar(title: const Text('Prepare Game/Practice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label('Season:'),
              DropdownButtonFormField<String>(
                items:
                    loginController
                        .getSeasons()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.seasonId,
                            child: Text(e.seasonName ?? ""),
                          ),
                        )
                        .toList(),
                onChanged: (v) => metDataController.selectedSeason.value = v!,
              ),
              const SizedBox(height: 16),

              _label('Same Level as:'),
              DropdownButtonFormField<String>(
                value: sameLevel,
                items:
                    ['ACMS Girls', 'Other Level']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (v) => setState(() => sameLevel = v!),
              ),
              const SizedBox(height: 8),

              _label('Score Option:'),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Score a Game'),
                      value: 'game',
                      groupValue: 'game',
                      onChanged: (_) {},
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Score a Practice'),
                      value: 'practice',
                      groupValue: 'game',
                      onChanged: (_) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _label('Home Team:'),
              DropdownButtonFormField<String>(
                items:
                    loginController
                        .getTeams()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name ?? ""),
                          ),
                        )
                        .toList(),
                onChanged: (v) => setState(() => homeTeam = v!),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: homeTeamColor,
                    margin: const EdgeInsets.only(right: 8),
                  ),
                  TextButton(
                    child: const Text('Change color'),
                    onPressed: () => _showColorPicker(true),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _label('Visitor Team:'),
              DropdownButtonFormField<String>(
                // value: visitorTeam,
                items:
                    loginController
                        .getTeams()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name ?? ""),
                          ),
                        )
                        .toList(),
                onChanged: (v) => setState(() => visitorTeam = v!),
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    color: visitorTeamColor,
                    margin: const EdgeInsets.only(right: 8),
                  ),
                  TextButton(
                    child: const Text('Change color'),
                    onPressed: () => _showColorPicker(false),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              _label('Location:'),
              TextFormField(
                initialValue: location,
                onChanged: (v) => setState(() => location = v),
              ),
              CheckboxListTile(
                value: isNeutralSite,
                onChanged: (v) => setState(() => isNeutralSite = v!),
                title: const Text('Neutral Site (Playoff or Tournament)'),
              ),
              const SizedBox(height: 16),

              _label('Game Type:'),
              Column(
                children:
                    gameTypes.keys.map((type) {
                      return CheckboxListTile(
                        value: gameTypes[type],
                        onChanged: (v) => setState(() => gameTypes[type] = v!),
                        title: Text(type),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 16),

              _label('Scoring Rules:'),
              DropdownButtonFormField<String>(
                // value: scoringRules,
                items:
                    loginController
                        .getScoringRules()
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.id,
                            child: Text(e.name ?? ""),
                          ),
                        )
                        .toList(),
                onChanged: (v) => setState(() => scoringRules = v!),
              ),
              const SizedBox(height: 16),

              _label('Scorer:'),
              RadioListTile<String>(
                title: const Text(
                  'Hoopsalytics will score this game for me. (9 games remaining out of 10 allocated)',
                ),
                value: 'hoopsalytics',
                groupValue: scorerOption,
                onChanged: (v) => setState(() => scorerOption = v!),
              ),
              RadioListTile<String>(
                title: const Text('I will score it myself'),
                value: 'self',
                groupValue: scorerOption,
                onChanged: (v) => setState(() => scorerOption = v!),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: CustomButton(
        // isLoading: loginController.isLoading.value,
        // onTap: () {
        //   if (loginController.formKey.value.currentState!
        //       .validate() &&
        //       loginController.formKey2.value.currentState!
        //           .validate()) {
        //     loginController.login();
        //   }
        // },
        buttonText: "Save Game",
        backgroundColor: Colors.orange,
        icon: Icon(Icons.save, color: AppColors.pureWhite),
      ).paddingOnly(bottom: 10.h,top: 5.h),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
