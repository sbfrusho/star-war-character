import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_war_character/view_models/character_detail_view_model.dart';
import 'package:star_war_character/view_models/theme_provider.dart';
import 'navigation/app_router.dart';
import 'view_models/character_list_view_model.dart';

void main()  {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterListViewModel()),
        ChangeNotifierProvider(create: (_) => CharacterDetailViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // Make sure this is correct
    );
  }
}
