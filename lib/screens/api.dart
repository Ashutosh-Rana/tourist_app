import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String res = "Please try again";

Future<Album> createAlbum(String txt) async {
  final response = await http.post(
    Uri.parse('https://sore-jade-nematode-shoe.cyclic.app/get_result'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'text': txt,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // print(response.body);
    Map<String, dynamic> data = jsonDecode(response.body);
    res = data['data'];
    // print(res);
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception(
        'Failed to create album. \nStatus code: ${response.statusCode}\nError message: ${response.body}');
  }
}

class Album {
  // final int id;
  final String text;

  Album({required this.text});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      // id: json['id'],
      text: json['text'],
    );
  }
}

class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() {
    return _ApiState();
  }
}

class _ApiState extends State<Api> {
  // final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Data Example'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureAlbum == null) ? buildColumn() : buildFutureBuilder(),
      ),
    );
  }

  Column buildColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // TextField(
        //   controller: _controller,
        //   decoration: const InputDecoration(hintText: 'Enter Title'),
        // ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _futureAlbum =
                  createAlbum("Plan a trip from Patna to Delhi for 2 days");
            });
          },
          child: const Text('Create Data'),
        ),
      ],
    );
  }

  FutureBuilder<Album> buildFutureBuilder() {
    return FutureBuilder<Album>(
      future: _futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
              child: Text(res.replaceAll('\\n', '\n'),
                  style: TextStyle(fontSize: 20)));
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
