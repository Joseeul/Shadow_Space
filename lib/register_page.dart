import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? errorMessage = '';
  bool isLogin = true;

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    print(_emailController.text);
    print(_passwordController.text);
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Register success, Please log in',
            style: TextStyle(
              fontFamily: 'j-bold',
            ),
          ),
        ),
      );
      Navigator.popAndPushNamed(context, '/');
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Register Failed',
          ),
        ),
      );
    }
  }

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
                'lib/assets/Logo.png',
                width: screenWidth * 0.5,
                height: screenHeight * 0.25,
              ),

              // USERNAME
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF353535),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Username',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                      fontFamily: 'j-medium',
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
                    fontFamily: 'j-medium',
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                      fontFamily: 'j-medium',
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
                    fontFamily: 'j-medium',
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
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Color(0xFFB5B5B5),
                      fontFamily: 'j-medium',
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
                    fontFamily: 'j-medium',
                  ),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.03,
              ),

              // BUTTON REGISTER
              ElevatedButton(
                onPressed: () {
                  createUserWithEmailAndPassword();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontFamily: 'j-medium',
                  ),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.03,
              ),

              //TEXT
              Container(
                width: double.infinity,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'j-reg',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              'By clicking Sign Up, you agree to Shadow Space’s '),
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

              //LOGIN TEXT
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/');
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'j-reg',
                    ),
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
