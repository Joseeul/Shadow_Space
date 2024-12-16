import 'package:flutter/material.dart';
import 'package:shadow_space/home_page.dart';
import 'package:shadow_space/login_page.dart';
import 'package:shadow_space/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home_page': (context) => HomePage()
      },
    );
  }
}