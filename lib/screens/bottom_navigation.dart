import 'package:flutter/material.dart';
import 'package:tourist_app/screens/train.dart';
import 'package:tourist_app/screens/trip.dart';

import 'hotel.dart';

var selectedIndex = 0;
final List<Widget> children = [    Trains(),    Trips(),    Hotels(),  ];
final List<String> l = [    "Trains",    "Trips",    "Hotels"  ];
String ttl="Trains";

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  
  @override
  void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        ttl=l[index];
      });
    }
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.train,size: 30,),
          label: 'Trains'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_rental,size: 30,),
          label: 'Trips'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.hotel,size: 30,),
          label: 'Hotels'
        ),
      ],
      
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      selectedItemColor: Colors.purple[800],
      onTap: onItemTapped,
    );

    
  }
}