import 'package:flutter/material.dart';
import 'package:shadow_space/helper/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'homepage trial slebew',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await Auth().signOutGoogle();
                  await Auth().signOut();
                  Navigator.popAndPushNamed(context, '/');
                } catch (e) {}
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
