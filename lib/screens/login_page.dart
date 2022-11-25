/*
  Created by: Sebastian M. Villavicencio
  Date: 24 November 2022
  Description: Todo app with authentication
*/
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
// import 'package:exer7_villavicencio/providers/auth_provider.dart';
// import 'package:exer7_villavicencio/screens/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    Widget email = TextFormField(
      key: const Key('emailField'),
      controller: emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Enter your email';
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'Email',
        errorStyle: TextStyle(color: Colors.white),
      ),
    );

    Widget password = TextFormField(
      key: const Key('pwField'),
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your password";
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'Password',
        errorStyle: TextStyle(color: Colors.white),
      ),
    );

    Widget loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xFF5F18C5) // background
            ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            // String? message = await context
            //     .read<AuthProvider>()
            //     .signIn(emailController.text, passwordController.text);

            // Fluttertoast.showToast(
            //   msg: message,
            //   timeInSecForIosWeb: 5,
            //   toastLength: Toast.LENGTH_LONG,
            //   gravity: ToastGravity.BOTTOM,
            //   backgroundColor:
            //       message == "Logging in..." ? Colors.green : Colors.red,
            //   webBgColor: message == "Logging in..."
            //       ? "linear-gradient(to right, #4caf4f, #4caf4f)"
            //       : "linear-gradient(to right, #dc1c13, #dc1c13)",
            //   textColor: Colors.white,
            //   fontSize: 14,
            // );
            print("Logging in...");
          }
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xFF5F18C5) // background
            ),
        onPressed: () async {
          print("Going to sign up");
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => const SignupPage(),
          //   ),
          // );
        },
        child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );

    Widget loginForm = Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            email,
            password,
            loginButton,
            signUpButton,
          ],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7E36C5),
                Color(0xFFF220F6),
              ]),
        ),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              loginForm,
            ],
          ),
        ),
      ),
    );
  }
}
