import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function(bool, String, String) registered;
  const Register({required this.registered, super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  void _register() {
    if (_formKey.currentState!.validate()) {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    widget.registered(true, username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: SizedBox(
                      width: 500,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    )),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: SizedBox(
                            width: 500,
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ))),
                    SizedBox(
                      height: 65,
                      width: 360,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ElevatedButton(
                          onPressed: _register,
                          child: Text('Register',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    Center( 
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, 
                        children: [ 
                          Padding(padding: EdgeInsets.symmetric(vertical: 15), 
                            child: Text('Already have an account? ')),
                          GestureDetector(
                        onTap:() {Navigator.pop(context);},
                        child: const Text('Login',style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ), 
                        ], 
                      ), 
                    ),
                  ],
                )),
          ));
  }
}