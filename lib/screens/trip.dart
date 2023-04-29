import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  final _formKey = GlobalKey<FormState>();
  final startTripController = TextEditingController();
  final endTripController = TextEditingController();
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
                controller: startTripController,
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
                controller: endTripController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter ending point';
                  }
                  return null;
                },
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
