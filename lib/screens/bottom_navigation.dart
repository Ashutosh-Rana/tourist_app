import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var _selectedIndex = 0;
  @override
  void onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.train,size: 30,),
          label: 'Train'
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
      
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      selectedItemColor: Colors.purple[800],
      onTap: onItemTapped,
    );

    
  }
}