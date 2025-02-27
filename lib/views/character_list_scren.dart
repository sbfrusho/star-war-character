import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_war_character/view_models/character_list_view_model.dart';
import '../widgets/character_card.dart';
import '../widgets/drawer_menu.dart'; // Import the DrawerMenu

class CharacterListScreen extends StatefulWidget {
  @override
  _CharacterListScreenState createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharacterListViewModel>(context, listen: false).fetchCharacters();
    });
  }

  void _onScroll() {
    final viewModel = Provider.of<CharacterListViewModel>(context, listen: false);
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      viewModel.fetchCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Star Wars Characters")),
      drawer: DrawerMenu(), // Use the extracted DrawerMenu
      body: Consumer<CharacterListViewModel>(
        builder: (context, viewModel, child) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: viewModel.characters.length + 1,
            itemBuilder: (context, index) {
              if (index < viewModel.characters.length) {
                return CharacterCard(character: viewModel.characters[index]);
              } else if (viewModel.hasMore) {
                return Center(child: CircularProgressIndicator());
              } else {
                return SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
