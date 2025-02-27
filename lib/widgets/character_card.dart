import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Navigating to Character Details: ${character.name} (ID: ${character.id})");
        context.go('/character/${character.id}');  // ✅ Pass ID instead of name
      },
      child: Card(
        child: ListTile(
          title: Text(character.name),
          subtitle: Text("Birth Year: ${character.birthYear ?? 'N/A'}"),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
