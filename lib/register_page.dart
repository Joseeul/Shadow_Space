import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Logo.png',
                width: screenWidth * 0.5,
                height: screenHeight * 0.25,
              ),
              // USERNAME
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF353535),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 15,
                    ),
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // Email
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF353535),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 15,
                    ),
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              // PASSWORD
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF353535),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 15,
                    ),
                    fillColor: Colors.white,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              // BUTTON LOGIN
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Sign up'),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Container(
                width: double.infinity,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'By clicking Continue, you agree to Shadow Space’s '),
                      TextSpan(
                        text: 'User Agreement',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ', '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ', and '),
                      TextSpan(
                        text: 'Cookie Policy',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/');
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.white),
                    children: <TextSpan>[
                      TextSpan(text: 'Already have account? '),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
