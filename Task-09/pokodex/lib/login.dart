import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokodex/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'topbar.dart';

class Login extends StatefulWidget {
  final Function(bool, String, List<Map<String, dynamic>>, String) loggedIn;
  const Login({required this.loggedIn, super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

// users = {
//   "user1": {
//     "password": "password1",
//     "name": "name1"
//   },
//   "user2": {
//     "password": "password2",
//     "name": "name2"
//   }
// }
//
// userjson = '{"user1": {"password": "password1", "name": "name1"}, "user2": {"password": "password2", "name": "name2"}}'


  void login() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text;
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    Map<String, dynamic> users = usersJson != null ? Map<String, dynamic>.from(jsonDecode(usersJson)) : {};
    if(users.containsKey(username)){
      if(users[username]['password'] == password){
        String name = users[username]['name'] ?? '';
        List<Map<String, dynamic>> mypokemons = List<Map<String, dynamic>>.from(users[username]['pokemon']);
        widget.loggedIn(true, name, mypokemons, username);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect password')));
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User $username does not exist')));
    }
  }

  void _navigatetoregister() async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    Map<String, dynamic> users = usersJson != null ? Map<String, dynamic>.from(jsonDecode(usersJson)) : {};
    Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => Register(
          registered: (registered, username, password, name, mypokemons) {
          if(registered){
            if(users.containsKey(username)){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User $username already exists')));  
            } else {
            users[username] = {'password': password, 'name': name, 'pokemon': mypokemons};
            prefs.setString('users', jsonEncode(users));
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
        isLoggedIn: false,
        loggedIn: widget.loggedIn,
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
                          onPressed: login,
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

