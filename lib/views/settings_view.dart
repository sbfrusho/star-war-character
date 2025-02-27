import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../view_models/theme_provider.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Settings'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (GoRouter.of(context).canPop()) {
                  GoRouter.of(context).pop();
                } else {
                  context.go('/');
                }
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Dark Mode', style: TextStyle(fontSize: 18)),
                    Switch(
                      value: themeProvider.themeMode == ThemeMode.dark,
                      onChanged: (value) => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
