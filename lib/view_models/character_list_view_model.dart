import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/character_model.dart';

class CharacterListViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  final List<Character> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true; // To check if more data is available

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchCharacters() async {
    if (_isLoading || !_hasMore) return; // Stop fetching if already loading or no more data

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get("https://swapi.dev/api/people/?page=$_currentPage");
      if (response.statusCode == 200) {
        final data = json.decode(response.toString());

        List<Character> newCharacters = (data['results'] as List)
            .map((json) => Character.fromJson(json))
            .toList();

        _characters.addAll(newCharacters);
        _currentPage++;

        // Check if more pages are available
        _hasMore = data['next'] != null;
      }
    } catch (e) {
      print("Error fetching characters: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
