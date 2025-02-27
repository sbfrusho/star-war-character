import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:star_war_character/views/character_list_scren.dart';
import '../views/character_detail_view.dart';
import '../views/about_view.dart';
import '../views/settings_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',  // Ensures app starts at home
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => CharacterListScreen(),
      ),
      GoRoute(
        path: '/character/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return CharacterDetailView(characterId: id);
        },
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => AboutView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => SettingsView(),
      ),
    ],
  );
}
