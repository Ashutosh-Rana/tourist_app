import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Trains extends StatefulWidget {
  const Trains({super.key});

  @override
  State<Trains> createState() => _TrainsState();
}

class _TrainsState extends State<Trains> {
  final _formKey = GlobalKey<FormState>();
  final startController = TextEditingController();
  final endController = TextEditingController();
  String _selectedWeekday = "Monday";

  List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  // @override
  // void initState() {
  //   super.initState();
  //   _selectedWeekday = _weekdays[0];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 6,
                      color: Colors.red, // Set the border color here
                    ),
                  ),
                  hintText: 'Starting Point',
                ),
                style: TextStyle(
                  color: Colors.black, // Set the text color here
                ),
                controller: startController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter starting point';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 6,
                      color: Colors.red, // Set the border color here
                    ),
                  ),
                  hintText: 'Ending Point',
                ),
                style: TextStyle(
                  color: Colors.black, // Set the text color here
                ),
                controller: endController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter ending point';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey,
                ),
                child: DropdownButton<String>(
                  underline: Container(
                    height: 4,
                    color: Colors.green,
                  ),
                  iconEnabledColor: Colors.red,
                  iconDisabledColor: Colors.black,
                  focusColor: Colors.amber,
                  dropdownColor: Colors.blue,
                  value: _selectedWeekday,
                  onChanged: (value) {
                    setState(() {
                      _selectedWeekday = value.toString();
                    });
                  },
                  items: _weekdays.map((String weekday) {
                    return DropdownMenuItem<String>(
                      value: weekday,
                      child: Text(weekday),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width * .4,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
