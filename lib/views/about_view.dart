import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Star Wars Characters App",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
                "This app fetches data from the Star Wars API and displays information about characters."),
            SizedBox(height: 20),
            Text("Developed with Flutter & Provider",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
