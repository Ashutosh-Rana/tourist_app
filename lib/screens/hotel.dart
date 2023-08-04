import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


String  query3_res = "hello";
Future createAlbum(String location,String sublocation,String days) async {
  final response = await http.post(
    Uri.parse('https://sore-jade-nematode-shoe.cyclic.app/get_result'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    // query1 =
    // "List of trains from {$startTrainController} to {$endTrainController} with arrival and departure time on {$_selectedWeekday}";
    body: jsonEncode(<String, String>{
      'text':
          "List of hotels near {$sublocation} in {$location} for {$days} days with price",
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    query3_res = data['data'];
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


class Hotels extends StatefulWidget {
  const Hotels({super.key});

  @override
  State<Hotels> createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  final _formKey = GlobalKey<FormState>();
  final location = TextEditingController();
  final sublocation = TextEditingController();
  final days = TextEditingController();
  final price = TextEditingController();
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
                    hintText: 'Location',
                  ),
                  style: TextStyle(
                    color: Colors.black, // Set the text color here
                  ),
                  controller: location,
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 6,
                        color: Colors.red, // Set the border color here
                      ),
                    ),
                    hintText: 'Sub Location',
                  ),
                  style: TextStyle(
                    color: Colors.black, // Set the text color here
                  ),
                  controller: sublocation,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Sub Location';
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
                  controller: days,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter Price';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 20,),
                // TextFormField(
                //   keyboardType: TextInputType.number,
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(
                //       borderSide: BorderSide(
                //         width: 6,
                //         color: Colors.red, // Set the border color here
                //       ),
                //     ),
                //     hintText: 'Price in Rs',
                //   ),
                //   style: TextStyle(
                //     color: Colors.black, // Set the text color here
                //   ),
                //   controller: price,
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter ending point';
                //     }
                //     return null;
                //   },
                // ),
                // SizedBox(height: 20,),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width * .4,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('jello');
                        setState(() {
                          createAlbum(
                              location.text.toString(),
                              sublocation.text.toString(),
                              days.text.toString(),
                              // price.text.toString()
                              );
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
                Text(query3_res)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
