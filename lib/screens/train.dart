import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';


String query1 = "", query1_res = "hello";

Future createAlbum(String startTrainController, String endTrainController,
    String _selectedWeekday) async {
  final response = await http.post(
    Uri.parse('https://sore-jade-nematode-shoe.cyclic.app/get_result'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // query1 =
    // "List of trains from {$startTrainController} to {$endTrainController} with arrival and departure time on {$_selectedWeekday}";
    body: jsonEncode(<String, String>{
      'text':
          "List of trains from {$startTrainController} to {$endTrainController} on {$_selectedWeekday} with their timings",
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    query1_res = data['data'];
    print(query1_res);
    print("ashu");
    // return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to create album. \nStatus code: ${response.statusCode}\nError message: ${response.body}');
  }
}

// class Album {
//   // final int id;
//   final String text;

//   Album({required this.text});

//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       // id: json['id'],
//       text: json['text'],
//     );
//   }
// }

class Trains extends StatefulWidget {
  const Trains({super.key});

  @override
  State<Trains> createState() => _TrainsState();
}

class _TrainsState extends State<Trains> {
  // Trains(String startTrainController, String endTrainController,
  //     String _selectedWeekday) {
  //   String query =
  //       "List of trains from {$startTrainController} to {$endTrainController} with arrival and departure time on {$_selectedWeekday}";
  // }

  final _formKey = GlobalKey<FormState>();
  final startTrainController = TextEditingController();
  final endTrainController = TextEditingController();
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
                  controller: startTrainController,
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
                  controller: endTrainController,
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .4,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('jello');
                        setState(() {
                          createAlbum(
                              startTrainController.text.toString(),
                              endTrainController.text.toString(),
                              _selectedWeekday);
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
                Text(query1_res)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
