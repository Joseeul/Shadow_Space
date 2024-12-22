import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/firebase_options.dart';
import 'package:shadow_space/helper/user_service.dart';
import 'package:shadow_space/models/get_user.dart';
import 'package:shadow_space/pages/for_you_comments.dart';
import 'package:shadow_space/pages/home_page.dart';
import 'package:shadow_space/pages/news_details.dart';
import 'package:shadow_space/pages/trending_comments.dart';
import 'package:shadow_space/pages/login_page.dart';
import 'package:shadow_space/pages/profile_page.dart';
import 'package:shadow_space/pages/register_page.dart';

void main() async{
  UserService.loggedUser = GetUser(email: '', username: '', userId: '');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        '/home_page': (context) => HomePage(),
        '/trending_comments_page': (context) => TrendingCommentsPage(),
        '/profile_page': (context) => ProfilePage(),
        '/for_you_comments_page': (context) => ForYouComments(),
        '/news_details_page': (context) => NewsDetails()
      },
    );
  }
}