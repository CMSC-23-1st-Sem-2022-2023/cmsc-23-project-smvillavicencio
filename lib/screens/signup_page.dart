import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
// import 'package:exer7_villavicencio/providers/auth_provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      ),
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
      ),
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
      ),
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
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }
      },
    );

    final birthday = DateTimeFormField(
      key: const Key("birthdayField"),
      decoration: const InputDecoration(
        suffixIcon: Icon(Icons.event_note),
        labelText: 'Birthday',
      ),
      mode: DateTimeFieldPickerMode.date,
      validator: (value) {
        if (value == null) {
          return 'Birthday is required';
        }
      },
      onDateSelected: (value) {
        birthdayController.text = "${value.year.toString()}-${value.month.toString()}-${value.day.toString()}";
      },
    );

    final location = TextFormField(
      key: const Key("locationField"),
      controller: locationController,
      decoration: InputDecoration(
        labelText: 'Location',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Locatuon is required';
        }
      }
    );

    final password = TextFormField(
      key: const Key("pwField"),
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      validator: (value) {
        RegExp regex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
        if (value == null || value.isEmpty) {
          return 'Password is required';
        } else if (!regex.hasMatch(value)){
          return 'Enter a valid password';
        }
      }
    );

    final signUpButton = Padding(
      key: const Key("signUpButton"),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if(_formKey.currentState!.validate()){
            print("Signing up...");
            //call the auth provider here
            String? message = await context.read<AuthProvider>().signUp(
                emailController.text,
                passwordController.text,
                firstNameController.text,
                lastNameController.text,
                usernameController.text,
                birthdayController.text,
                locationController.text
            );
            if (message == "Successfully signed up!") {
              Navigator.pop(context);
            }

            Fluttertoast.showToast(
              msg: message,
              timeInSecForIosWeb: 5,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: message == "Successfully signed up!"
                  ? Colors.green
                  : Colors.red,
              webBgColor: message == "Successfully signed up!"
                  ? "linear-gradient(to right, #4caf4f, #4caf4f)"
                  : "linear-gradient(to right, #dc1c13, #dc1c13)",
              textColor: Colors.white,
              fontSize: 14,
            );
          }
        },
        child: const Text('Sign up',),
      ),
    );

    final backButton = Padding(
      key: const Key("backButton"),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back',),
      ),
    );

    Widget signUpForm = Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            firstName,
            lastName,
            userName,
            birthday,
            location,
            email,
            password,
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
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              signUpForm
            ],
          ),
        ),
      ),
    );
  }
}
