import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'topbar.dart';

class TradeScreen extends StatefulWidget {
  final bool isLoggedIn;
  final Function(bool, String) loggedIn;
  final String name;
  const TradeScreen({super.key, required this.isLoggedIn, required this.loggedIn, required this.name});
  @override
  TradeScreenState createState() => TradeScreenState();
}

class TradeScreenState extends State<TradeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<Pokemon> pokemonList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokodex',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: TopBar(
        isLoggedIn: widget.isLoggedIn,
        loggedIn: widget.loggedIn,
        usernameController: _usernameController,
        passwordController: _passwordController,
      ),
      body: Center(
        child: Text(
            widget.isLoggedIn ? "Welcome to the Trade Screen, ${widget.name}!" : "Please log in to trade.",
            style: const TextStyle(fontSize: 18),
          ),
      ),
    ));
  }
}
