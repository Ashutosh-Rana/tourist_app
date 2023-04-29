import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  final _formKey = GlobalKey<FormState>();
  final startHotelController = TextEditingController();
  final endHotelController = TextEditingController();
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
                  hintText: 'Location',
                ),
                style: TextStyle(
                  color: Colors.black, // Set the text color here
                ),
                controller: startHotelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Location';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 6,
                      color: Colors.red, // Set the border color here
                    ),
                  ),
                  hintText: 'Days',
                ),
                style: TextStyle(
                  color: Colors.black, // Set the text color here
                ),
                controller: endHotelController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 6,
                      color: Colors.red, // Set the border color here
                    ),
                  ),
                  hintText: 'Price in Rs',
                ),
                style: TextStyle(
                  color: Colors.black, // Set the text color here
                ),
                controller: endHotelController,
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
