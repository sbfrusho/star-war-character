import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character_model.dart';

class ApiService {
  static const String baseUrl = "https://swapi.dev/api/people";

  Future<List<Character>> fetchCharacters() async {
    try {
      print("Fetching characters from API...");
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("Response received: ${data['results']}");

        List<Character> characters = (data['results'] as List)
            .map((char) => Character.fromJson(char))
            .toList();

        return characters;
      } else {
        print("Error: API returned status code ${response.statusCode}");
        throw Exception("Failed to load characters");
      }
    } catch (e) {
      print("Error fetching characters: $e");
      throw Exception("Failed to load characters");
    }
  }

  Future<Character> fetchCharacterById(String id) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/$id/"));

      if (response.statusCode == 200) {
        print("Character details fetched successfully!");
        final data = json.decode(response.body);
        return Character.fromJson(data);
      } else {
        print("Error: API returned status code ${response.statusCode}");
        throw Exception("Failed to load character details");
      }
    } catch (e) {
      print("Error fetching character details: $e");
      throw Exception("Failed to load character details");
    }
  }
}
