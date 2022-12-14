/*
  Created by: Sebastian M. Villavicencio
  Section: D5L
  Date: 25 November 2022
  Description: Flutter mobile application composed of a sign in, sign-up and a shared todo list features with a user’s friends. 
*/

import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  // page where users can create a new account
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // required fields have validators og the input
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController birthdayController = TextEditingController();

    final firstName = TextFormField(
      key: const Key("firstNameField"),
      controller: firstNameController,
      decoration: InputDecoration(
        labelText: 'First Name',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'First name is required';
        }
      },
    );

    final lastName = TextFormField(
      key: const Key("lastNameField"),
      controller: lastNameController,
      decoration: InputDecoration(
        labelText: 'Last Name',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Last name is required';
        }
      },
    );

    final userName = TextFormField(
      key: const Key("userName"),
      controller: usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Username is required';
        }
      },
    );

    final email = TextFormField(
      key: const Key("emailField"),
      controller: emailController,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
      },
    );

    final birthday = TextFormField(
      controller: birthdayController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.today),
        labelText: "Birthday",
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
      readOnly: true,
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: birthdayController.text == ""
              ? DateTime.now()
              : DateTime.parse(birthdayController.text),
          firstDate: DateTime(1901),
          lastDate: DateTime.now(),
        ).then((value) {
          if (value != null) {
            birthdayController.text = DateFormat('yyyy-MM-dd').format(value);
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Birthday is required';
        }
      },
    );

    final location = TextFormField(
        key: const Key("locationField"),
        controller: locationController,
        decoration: InputDecoration(
          labelText: 'Location',
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
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Locatuon is required';
          }
        });

    final password = TextFormField(
        key: const Key("pwField"),
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
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
          focusedBorder: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(25.0),
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        validator: (value) {
          RegExp regex = RegExp(
              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (!regex.hasMatch(value)) {
            return 'Enter a valid password';
          }
        });

    final signUpButton = Padding(
      key: const Key("signUpButton"),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          fixedSize: Size(100, 40),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            print("Signing up...");
            //call the auth provider here
            String? message = await context.read<AuthProvider>().signUp(
                emailController.text,
                passwordController.text,
                firstNameController.text,
                lastNameController.text,
                usernameController.text,
                birthdayController.text,
                locationController.text);
            if (message == "Successfully signed up!") {
              Navigator.pop(context);
            }
            // show message as a flutter toast, may be error or success messages
            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 5,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: message == "Successfully signed up!"
                  ? Colors.teal
                  : Colors.pink,
              webBgColor: message == "Successfully signed up!"
                  ? "linear-gradient(to right, #4caf4f, #4caf4f)"
                  : "linear-gradient(to right, #dc1c13, #dc1c13)",
              textColor: Colors.white,
              fontSize: 14,
            );
          }
        },
        child: const Text(
          'Sign up',
        ),
      ),
    );

    final backButton = Padding(
      key: const Key("backButton"),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          fixedSize: Size(100, 40),
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text(
          'Back',
        ),
      ),
    );

    Widget signUpForm = Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(10), child: firstName),
            Padding(padding: EdgeInsets.all(10), child: lastName),
            Padding(padding: EdgeInsets.all(10), child: userName),
            Padding(padding: EdgeInsets.all(10), child: birthday),
            Padding(padding: EdgeInsets.all(10), child: location),
            Padding(padding: EdgeInsets.all(10), child: email),
            Padding(padding: EdgeInsets.all(10), child: password),
            signUpButton,
            backButton
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              signUpForm
            ],
          ),
        ),
      ),
    );
  }
}
