import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:screen_record_app/services/local_storage/local_storage_keys.dart';

import '../../model/entities/local_game_model.dart';

class LocalStorage {

  static init() async {
    // log("access token 1 "+LocalStorage.readJson(key: LocalStorageKeys.accessToken).toString());
     await GetStorage.init();
    // log("access token 2 "+LocalStorage.readJson(key: LocalStorageKeys.accessToken).toString());
  }

  static saveJson({required String key, required String value}) {
    final getStorage = GetStorage();
    var res = getStorage.write(key, value);
   // print("check after save : ${ readJson(key: key)}");
    return res;
  }

  static readJson({required String key}) {
    final getStorage = GetStorage();
    var res = getStorage.read(key);
    return res;
  }

  static deleteJson({required key}) {
    final getStorage = GetStorage();
    var res = getStorage.remove("$key");
    return res;
  }



  List<LocalGameModel> getSavedGames() {
    final getStorage = GetStorage();

    final List<dynamic> raw = getStorage.read(LocalStorageKeys.saveGame) ?? [];
    log("saved games "+raw.toString());
    return raw.map((e) => LocalGameModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> saveGameLocally(LocalGameModel game) async {
    final getStorage = GetStorage();

    final games = getSavedGames();
    games.add(game);
    await getStorage.write(LocalStorageKeys.saveGame, games.map((e) => e.toJson()).toList());
  }

  Future<void> updateGameLocally(LocalGameModel updatedGame) async {

    final getStorage = GetStorage();

    final games = getSavedGames();
    final index = games.indexWhere((g) => g.id == updatedGame.id);
    if (index != -1) {
      games[index] = updatedGame;
      await getStorage.write(LocalStorageKeys.saveGame, games.map((e) => e.toJson()).toList());
    }
  }

  Future<void> deleteGameLocally(String gameId) async {
    final getStorage = GetStorage();

    final games = getSavedGames();
    games.removeWhere((g) => g.id == gameId);
    await getStorage.write(LocalStorageKeys.saveGame, games.map((e) => e.toJson()).toList());
  }

}