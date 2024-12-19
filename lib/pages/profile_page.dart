import 'package:flutter/material.dart';
import 'package:shadow_space/helper/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Profile Page',
          style: TextStyle(
            fontFamily: 'j-medium',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.1,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.001),
          child: Container(
            color: Colors.white,
            height: screenHeight * 0.001,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(
            20,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Auth().signOut();
                    Auth().signOutGoogle();
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Text('Log out'),
                ),
              ],
            ),
          )),
    );
  }
}
