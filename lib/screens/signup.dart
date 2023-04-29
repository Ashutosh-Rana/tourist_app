import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscured = true;
  bool _isLoading = false;
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
              child: Align(alignment: Alignment.topLeft,
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
                        onPressed: _isLoading ? null : submit,
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

  void submit() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pushNamed("/home");
      _isLoading = false;
      // Perform signup API call here
      // Once the call is complete, navigate to the next screen
    }
  }
}
