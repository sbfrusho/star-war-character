import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/character_model.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  Character? character;
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchCharacterDetails(String id) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await Dio().get('https://swapi.dev/api/people/$id/');

      if (response.statusCode == 200) {
        character = Character.fromJson(response.data);
      } else {
        errorMessage = "API returned status code ${response.statusCode}";
      }
    } catch (e) {
      errorMessage = "Failed to load character details";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
