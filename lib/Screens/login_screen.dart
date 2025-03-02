import 'package:currency_converter/Screens/RegisterScreen.dart';
import 'package:currency_converter/Screens/home.dart';
import 'package:currency_converter/widgets/customButton.dart';
import 'package:currency_converter/widgets/customTextField.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      if (email.isEmpty || password.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter both email and password')),
          );
        }
        return;
      }

      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
      } catch (e) {
        print('Error: $e');

        String errorMessage = 'Failed to sign in. Please try again later.';
        if (e is FirebaseAuthException) {
          if (e.code == 'user-not-found') {
            errorMessage = 'No user found with this email.';
          } else if (e.code == 'wrong-password') {
            errorMessage = 'Incorrect password.';
          } else if (e.code == 'invalid-email') {
            errorMessage = 'The email address is not valid.';
          }
        }
        // Show appropriate error message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 93, 177, 246),
              Color(0xff145996),
            ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 70,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    'assets/Sign in.png',
                    height: 250,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          child: CustomTextFieldForAuth(
                            hintTitle: 'Email',
                            onchanged: (value) => email = value,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 0),
                          child: CustomTextFieldForAuth(
                            hintTitle: 'Password',
                            obscureText: true,
                            onchanged: (value) => password = value,
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  CustomButton(
                    text: 'Login',
                    onTap: signIn,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()),
                          );
                        },
                        child: Text(
                          " Sign Up",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 2, 35, 62),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
