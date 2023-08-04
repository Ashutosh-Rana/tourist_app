import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tourist_app/screens/home.dart';

String token = "";

Future<Album> createAlbum(String name, String email, String password) async {
  final response = await http.post(
    Uri.parse(
        'https://energetic-lion-petticoat.cyclic.app/api/v1/auth/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'name': name, 'email': email, 'password': password}),
  );
  if (response.statusCode == 201) {
    Map<String, dynamic> data = jsonDecode(response.body);
    token = data['token'];
    print(token);
    // if(!token.isEmpty){
    //   Get.to(HomeScreen());
    // }
    // Navigator.pushNamed(context, '/home');
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
  final String name;
  final String email;
  final String password;

  Album({required this.name, required this.email, required this.password});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        // id: json['id'],
        name: json['name'],
        email: json['email'],
        password: json['password']);
  }
}

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isObscured = true;
  bool _isLoading = false;
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0,
        title: Text('SignUp'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * .45,
              width: double.infinity,
              color: Colors.blue,
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    "Create New \n      Account",
                    style: TextStyle(color: Colors.white, fontSize: 45),
                  ),
                ),
              ),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: NetworkImage(
              //           "https://images.unsplash.com/photo-1609920658906-8223bd289001?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=601&q=80",
              //         ),
              //         fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 6,
                            color: Colors.red, // Set the border color here
                          ),
                        ),
                        hintText: 'Name',
                      ),
                      // obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 6,
                            color: Colors.red, // Set the border color here
                          ),
                        ),
                        hintText: 'Email',
                      ),
                      style: TextStyle(
                        color: Colors.black, // Set the text color here
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!EmailValidator.validate(value)) {
                          return 'Invalid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 6,
                            color: Colors.red, // Set the border color here
                          ),
                        ),
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * .4,
                      child: ElevatedButton(
                        onPressed: (() {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              createAlbum(
                                  _nameController.text.toString(),
                                  _emailController.text.toString(),
                                  _passwordController.text.toString());
                            });
                            print("token ---{$token}");
                            if (!token.isEmpty) {
                              Navigator.pushNamed(context, '/home');
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Registration Successful'),
                              ),
                            );
                            // _futureAlbum= buildFutureBuilder() as Future<Album>?;
                          }
                        }),
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Sign Up',
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextButton(
                      child: Text(
                        'I already have Account',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/signin");
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FutureBuilder<Album> buildFutureBuilder() {
  //   return FutureBuilder<Album>(
  //     future: createAlbum(
  //         _nameController.text.toString(),
  //         _emailController.text.toString(),
  //         _passwordController.text.toString()),
  //     builder: (context, snapshot) {
  //       print("status: ${snapshot.hasData}");

  //       if (snapshot.hasData) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Registration Successful'),
  //           ),
  //         );
  //         // print("ashu");
  //         Navigator.pushNamed(context, '/home');
  //         return Text(token, style: TextStyle(fontSize: 20));
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }

  //       return const CircularProgressIndicator();
  //     },
  //   );
  // }
}
