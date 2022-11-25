import 'package:cmsc23_project_villavicencio/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      // MultiProvider(
      //   providers: [
      //     // ChangeNotifierProvider(create: ((context) => TodoListProvider())),
      //     // ChangeNotifierProvider(create: ((context) => AuthProvider())),
      //   ],
      const MyApp()
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
