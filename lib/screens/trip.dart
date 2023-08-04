import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

String  query2_res = "hello";
Future createAlbum(String startTripController,String viaTripController, String endTripController) async {
  final response = await http.post(
    Uri.parse('https://sore-jade-nematode-shoe.cyclic.app/get_result'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // query1 =
    // "List of trains from {$startTrainController} to {$endTrainController} with arrival and departure time on {$_selectedWeekday}";
    body: jsonEncode(<String, String>{
      'text':
          "Plan a roadtrip from {$startTripController} to {$endTripController} on {$viaTripController} with their timings",
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    query2_res = data['data'];
    // print(query2_res);
    print("ashu");
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to create album. \nStatus code: ${response.statusCode}\nError message: ${response.body}');
  }
}

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  final _formKey = GlobalKey<FormState>();
  final startTripController = TextEditingController();
  final endTripController = TextEditingController();
  final viaTripController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                    hintText: 'Via',
                  ),
                  style: TextStyle(
                    color: Colors.black, // Set the text color here
                  ),
                  controller: viaTripController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Via';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('jello');
                        setState(() {
                          createAlbum(
                              startTripController.text.toString(),
                              endTripController.text.toString(),
                              endTripController.text.toString());
                        });
                        // print("token ---{$token}");
                        // if (!token.isEmpty) {
                        //   Navigator.pushNamed(context, '/home');
                        // }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Results ...'),
                          ),
                        );
                        // _futureAlbum= buildFutureBuilder() as Future<Album>?;
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Text(query2_res)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
