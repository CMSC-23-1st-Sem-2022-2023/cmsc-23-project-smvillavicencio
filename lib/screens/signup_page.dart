import 'package:flutter/material.dart';
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

    final firstName = TextField(
      key: const Key("firstNameField"),
      controller: firstNameController,
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'First Name',
      ),
    );

    final lastName = TextField(
      key: const Key("lastNameField"),
      controller: lastNameController,
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'Last Name',
      ),
    );

    final email = TextField(
      key: const Key("emailField"),
      controller: emailController,
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'Email',
      ),
    );

    final password = TextField(
      key: const Key("pwField"),
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        enabledBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF7E36C5)),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: Colors.white70,
        hintText: 'Password',
      ),
    );

    final SignupButton = Padding(
      key: const Key("signUpButton"),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xFF5F18C5) // background
            ),
        onPressed: () async {
          //call the auth provider here
          // String? message = await context.read<AuthProvider>().signUp(
          //     emailController.text,
          //     passwordController.text,
          //     firstNameController.text,
          //     lastNameController.text);
          // if (message == "Successfully signed up!") {
          //   Navigator.pop(context);
          // }

          // Fluttertoast.showToast(
          //   msg: message,
          //   timeInSecForIosWeb: 5,
          //   toastLength: Toast.LENGTH_LONG,
          //   gravity: ToastGravity.BOTTOM,
          //   backgroundColor: message == "Successfully signed up!"
          //       ? Colors.green
          //       : Colors.red,
          //   webBgColor: message == "Successfully signed up!"
          //       ? "linear-gradient(to right, #4caf4f, #4caf4f)"
          //       : "linear-gradient(to right, #dc1c13, #dc1c13)",
          //   textColor: Colors.white,
          //   fontSize: 14,
          // );
        },
        child: const Text('Sign up', style: TextStyle(color: Colors.white)),
      ),
    );

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Color(0xFF5F18C5) // background
            ),
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
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
                "Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              firstName,
              lastName,
              email,
              password,
              SignupButton,
              backButton
            ],
          ),
        ),
      ),
    );
  }
}
