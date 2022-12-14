import 'package:cmsc23_project_villavicencio/providers/auth_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/notification_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/todo_provider.dart';
import 'package:cmsc23_project_villavicencio/providers/user_provider.dart';
import 'package:cmsc23_project_villavicencio/screens/friends_page.dart';
import 'package:cmsc23_project_villavicencio/screens/login_page.dart';
import 'package:cmsc23_project_villavicencio/screens/todo_page.dart';
import 'package:cmsc23_project_villavicencio/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: ((context) => UsersProvider())),
      ChangeNotifierProvider(create: ((context) => TodoListProvider())),
      ChangeNotifierProvider(create: ((context) => AuthProvider())),
      ChangeNotifierProvider(create: ((context) => NotificationsProvider())),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared Todo',
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthWrapper(),
        '/todo': (context) => TodoPage(),
        '/friends': (context) => FriendsPage(),
      },
      theme: ThemeData.dark(
          // displayColor: Colors.white,
          ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthProvider>().isAuthenticated) {
      String userUid = context.watch<AuthProvider>().user!.uid;
      return ProfilePage(uid: userUid);
    } else {
      return const LoginPage();
    }
  }
}
