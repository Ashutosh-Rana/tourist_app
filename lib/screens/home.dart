import 'package:flutter/material.dart';
import 'package:tourist_app/screens/bottom_navigation.dart';
import 'package:tourist_app/screens/train.dart';
import 'package:tourist_app/screens/trip.dart';

import 'hotel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> children = [    Trains(),    Trips(),    Hotels(),  ];
  final List<String> l = [    "Trains",    "Trips",    "Hotels"  ];
  String ttl="Trains";
  @override
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      ttl = l[index];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(ttl),
        ),
        body: children[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.train,
                  size: 30,
                ),
                label: 'Trains'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.car_rental,
                  size: 30,
                ),
                label: 'Trips'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.hotel,
                  size: 30,
                ),
                label: 'Hotels'),
          ],
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          selectedItemColor: Colors.purple[800],
          onTap: onItemTapped,
        ));
  }
}
