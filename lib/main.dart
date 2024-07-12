import 'package:flutter/material.dart';
import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.black54)
        ),
      ),
      initialRoute: welcomeScreen.id,
      routes: {
        welcomeScreen.id:(context) => welcomeScreen(),
        loginScreen.id:(context) => loginScreen(),
        registrationScreen.id:(context) => registrationScreen(),
        chatScreen.id:(context) => chatScreen(),
      },
    );
  }
}
