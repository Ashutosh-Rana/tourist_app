import 'package:flutter/material.dart';
import 'package:tourist_app/screens/bottom_navigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
      body: SingleChildScrollView(
        child: Column(children: [

        ],),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}