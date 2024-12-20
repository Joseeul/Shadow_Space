import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/auth.dart';
// import 'package:shadow_space/helper/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    _passwordVisible = false;
  }

  String? errorMessage = '';
  bool isLogin = true;
  bool _passwordVisible = false;

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Succesfully login',
          ),
        ),
      );
      Navigator.popAndPushNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Wrong Email or Password',
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //LOGO
              Image.asset(
                'lib/assets/Logo.png',
                width: screenWidth * 0.5,
                height: screenHeight * 0.25,
              ),

              // EMAIL
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
                  cursorColor: Colors.white,
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding: EdgeInsets.only(
                      left: 15,
                      bottom: 15,
                    ),
                    fillColor: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'j-medium',
                  ),
                  obscureText: !_passwordVisible,
                ),
              ),

              SizedBox(
                height: screenHeight * 0.03,
              ),

              // BUTTON LOGIN
              ElevatedButton(
                onPressed: () {
                  signInWithEmailAndPassword();
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
                  'Log in',
                  style: TextStyle(
                    fontFamily: 'j-medium',
                  ),
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),

              Text(
                'or log in with',
                style: TextStyle(
                  color: Color(0xFFB5B5B5),
                  fontFamily: 'j-reg',
                ),
              ),

              SizedBox(
                height: screenHeight * 0.02,
              ),

              //GOOGLE BUTTON
              ElevatedButton(
                onPressed: () async {
                  try {
                    await Auth().signInWithGoogle();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Successfully login',
                        ),
                      ),
                    );
                    Navigator.popAndPushNamed(context, '/home_page');
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to login with Google'),
                      ),
                    );
                    print(e);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/assets/ui_icon/Google.png',
                      height: 17,
                      width: 17,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontFamily: 'j-medium',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
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
                  Navigator.popAndPushNamed(context, '/register');
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'j-reg',
                    ),
                    children: <TextSpan>[
                      TextSpan(text: 'Don\'t have account? '),
                      TextSpan(
                        text: 'Sign up',
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
