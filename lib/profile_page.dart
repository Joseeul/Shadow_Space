import 'package:flutter/material.dart';

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
        title: Text('Profile Page'),
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
    );
  }
}
