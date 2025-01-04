import 'package:flutter/material.dart';
import 'package:shadow_space/helper/auth.dart';
import 'package:shadow_space/helper/user_service.dart';

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
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            //gambar profile
            Row(
              spacing: screenWidth * 0.05,
              children: [
                Image.asset(
                  'lib/assets/ui_icon/account.png',
                  width: screenWidth * 0.15,
                  height: screenHeight * 0.15,
                ),
                Text(
                  UserService.loggedUser!.username.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'j-bold',
                    fontSize: screenWidth * 0.08,
                  ),
                ),
              ],
            ),

            //2 tombol
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 38, 38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  overlayColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/about_dev');
                },
                child: Text(
                  'About Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'j-medium',
                  ),
                ),
              ),
            ),
            Divider(
              color: Color(0xFF353535),
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'UserID: ${UserService.loggedUser!.userId}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'j-reg',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Color(0xFFAC0909),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    overlayColor: Color(0xFFAC0909),
                  ),
                  onPressed: () {
                    Auth().signOut();
                    Auth().signOutGoogle();
                    Navigator.pop(context);
                    Navigator.popAndPushNamed(context, '/');
                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      color: Color(0xFFAC0909),
                      fontFamily: 'j-medium',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
