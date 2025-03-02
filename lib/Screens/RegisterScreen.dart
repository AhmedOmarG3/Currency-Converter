import 'package:currency_converter/Screens/home.dart';
import 'package:currency_converter/Screens/login_screen.dart';
import 'package:currency_converter/widgets/customButton.dart';
import 'package:currency_converter/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String name = '';
  String username = '';
  String password = '';
  String confirmPassword = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      if (password == confirmPassword) {
        try {
          await _auth.createUserWithEmailAndPassword(
              email: username, password: password);

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        } catch (e) {
          print('Error: $e');

          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to register: $e')),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Passwords do not match')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 93, 177, 246),
              Color(0xff145996),
            ])),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Register',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Image.asset(
                      'assets/Sign in.png',
                      height: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: CustomTextFieldForAuth(
                        hintTitle: 'Name',
                        onchanged: (value) => name = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: CustomTextFieldForAuth(
                        hintTitle: 'Email',
                        onchanged: (value) => username = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      child: CustomTextFieldForAuth(
                        onchanged: (value) => password = value,
                        hintTitle: 'Password',
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 0),
                      child: CustomTextFieldForAuth(
                        hintTitle: 'Confirm Password',
                        obscureText: true,
                        onchanged: (value) => confirmPassword = value,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomButton(
                      text: 'Register',
                      onTap: register,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          " have an account?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            " Sign in",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 2, 35, 62),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
