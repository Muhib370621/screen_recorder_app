import 'package:flutter/material.dart';

class GameSetupForm extends StatefulWidget {
  const GameSetupForm({super.key});

  @override
  State<GameSetupForm> createState() => _GameSetupFormState();
}

class _GameSetupFormState extends State<GameSetupForm> {
  String selectedSeason = '2023';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prepare Game/Practice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Season:'),
            DropdownButtonFormField<String>(
              value: selectedSeason,
              items: ['2023', '2024'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => selectedSeason = v!),
            ),
            const SizedBox(height: 16),

            _label('Same Level as:'),
            DropdownButtonFormField<String>(
              value: sameLevel,
              items: ['ACMS Girls', 'Other Level'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
              value: homeTeam,
              items: ['ACMS Girls', 'Another Team'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
                  onPressed: () {
                    // add color picker here if needed
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            _label('Visitor Team:'),
            DropdownButtonFormField<String>(
              value: visitorTeam,
              items: ['Carson Valley Girls 8th', 'Another Team'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
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
                  onPressed: () {
                    // add color picker here if needed
                  },
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
              children: gameTypes.keys.map((type) {
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
              value: scoringRules,
              items: ['High School (8 minute quarters)', 'College (20 minute halves)']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => scoringRules = v!),
            ),
            const SizedBox(height: 16),

            _label('Scorer:'),
            RadioListTile<String>(
              title: const Text('Hoopsalytics will score this game for me. (9 games remaining out of 10 allocated)'),
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
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
  );
}
