/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 24 November 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:cmsc23_project_villavicencio/screens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  // page where existing users can log in to their accounts
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
        labelText: 'Email',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.teal),
        ),
        errorStyle: TextStyle(color: Colors.pink),
        errorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedErrorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
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
        labelText: 'Pasword',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.teal),
        ),
        errorStyle: TextStyle(color: Colors.pink),
        errorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedErrorBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.pink),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
    );

    Widget loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          fixedSize: Size(100, 40),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            String? message = await context
                .read<AuthProvider>()
                .signIn(emailController.text, passwordController.text);
            // show message as a flutter toast, may be error or success messages
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 5,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor:
                  message == "Logging in..." ? Colors.teal : Colors.pink,
              webBgColor: message == "Logging in..."
                  ? "linear-gradient(to right, #4caf4f, #4caf4f)"
                  : "linear-gradient(to right, #dc1c13, #dc1c13)",
              textColor: Colors.white,
              fontSize: 14,
            );
          }
        },
        child: const Text(
          'Log In',
        ),
      ),
    );

    Widget signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          fixedSize: Size(100, 40),
        ),
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupPage(),
            ),
          );
        },
        child: const Text(
          'Sign Up',
        ),
      ),
    );

    Widget loginForm = Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10), child: email),
            Padding(padding: EdgeInsets.all(10), child: password),
            loginButton,
            signUpButton,
          ],
        ),
      ),
    );

    return Scaffold(
      body: Container(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            children: <Widget>[
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              loginForm,
            ],
          ),
        ),
      ),
    );
  }
}
