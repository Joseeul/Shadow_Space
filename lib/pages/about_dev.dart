import 'package:flutter/material.dart';

class AboutDev extends StatelessWidget {
  const AboutDev({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'About Developer',
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
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      100), // Sama dengan border container
                  child: Image.asset(
                    'lib/assets/jose.png',
                    fit: BoxFit
                        .cover, // Gambar akan menyesuaikan bentuk container
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '2702233583 - Jose Andreas',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'j-bold',
                  fontSize: screenWidth * 0.05,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      100), // Sama dengan border container
                  child: Image.asset(
                    'lib/assets/mpin.jpg',
                    fit: BoxFit
                        .cover, // Gambar akan menyesuaikan bentuk container
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '2702256271 - Calvin Virya Yunardy',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'j-bold',
                  fontSize: screenWidth * 0.05,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
