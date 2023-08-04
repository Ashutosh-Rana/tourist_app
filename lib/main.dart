import 'package:flutter/material.dart';
import 'package:tourist_app/screens/api.dart';
import 'package:tourist_app/screens/home.dart';
import 'package:tourist_app/screens/signin.dart';
import 'package:tourist_app/screens/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SigninScreen(),
      routes: {
        "/signup": (context)=> SignupScreen(),
        "/home": (context)=> HomeScreen(),
        "/signin": (context)=> SigninScreen(),
        "/api": (context)=> Api(),
      },
    );
  }
}
