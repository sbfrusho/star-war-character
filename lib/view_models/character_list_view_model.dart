import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/character_model.dart';

class CharacterListViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  final List<Character> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;
  String _searchQuery = "";

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchCharacters({String searchQuery = ""}) async {
    if (_isLoading) return;

    // Reset pagination if it's a search query
    if (searchQuery.isNotEmpty && searchQuery != _searchQuery) {
      _characters.clear();
      _currentPage = 1;
      _hasMore = true;
    }

    _searchQuery = searchQuery;
    _isLoading = true;
    notifyListeners();

    try {
      String url = searchQuery.isNotEmpty
          ? "https://swapi.dev/api/people/?search=$searchQuery"
          : "https://swapi.dev/api/people/?page=$_currentPage";

      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.toString());

        List<Character> newCharacters = (data['results'] as List)
            .map((json) => Character.fromJson(json))
            .toList();

        if (_currentPage == 1) {
          _characters.clear(); // Clear list if it's a new search
        }

        _characters.addAll(newCharacters);
        _currentPage++;

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
