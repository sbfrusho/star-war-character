import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../view_models/character_detail_view_model.dart';

class CharacterDetailView extends StatelessWidget {
  final String characterId;

  const CharacterDetailView({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CharacterDetailViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Character Details'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop(); // ✅ Safe pop if possible
            } else {
              context.go('/'); // ✅ Go back to home screen
            }
          },
        ),
      ),
      body: FutureBuilder(
        future: viewModel.fetchCharacterDetails(characterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading character details'));
          } else {
            final character = viewModel.character;
            return character == null
                ? Center(child: Text('Character not found'))
                : Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          character.name,
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text("Height: ${character.height} cm"),
                        Text("Mass: ${character.mass} kg"),
                        Text("Birth Year: ${character.birthYear}"),
                        Text("Gender: ${character.gender}"),
                      ],
                    ),
                  );
          }
        },
      ),
    );
  }
}
