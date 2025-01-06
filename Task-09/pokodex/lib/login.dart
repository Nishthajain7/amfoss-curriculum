import 'package:flutter/material.dart';
import 'package:pokodex/register.dart';
import 'topbar.dart';

class Login extends StatefulWidget {
  final Function(bool, String) loggedIn;
  const Login({required this.loggedIn, super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isRegistering = false;

  @override
  void initState() {
    super.initState();
  }

  Map<String, String> users = {};

  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    if(users.containsKey(username)){
      if(users[username]==password){
        widget.loggedIn(true, username);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect password')));
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User $username does not exist')));
    }
  }

  void _navigatetoregister() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Register(
        registered: (registered, username, password) {
          if(registered){
            if(users.containsKey(username)){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User $username already exists')));  
            } else {
            users[username]=password;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User $username registered successfully. You can now login')));  
            }
          }
        },
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: TopBar(
        isLoggedIn: false, // Change this based on your actual state
        loggedIn: widget.loggedIn,
        usernameController: _usernameController,
        passwordController: _passwordController,
      ),
          body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
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
                    ),
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
                          onPressed: _login,
                          child: Text('Log in',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),

                    Center( 
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, 
                        children: [ 
                          Padding(padding: EdgeInsets.symmetric(vertical: 15), 
                            child: Text('Don\'t have an account yet? ')),
                          GestureDetector(
                        onTap: _navigatetoregister ,
                        child: const Text('Register',style: TextStyle(fontSize: 14, color: Colors.blue),
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

