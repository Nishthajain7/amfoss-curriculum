import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pokemon.dart';
import 'dart:math';

class CaptureScreen extends StatefulWidget {
  final bool isLoggedIn;
  final Function(bool, String, List<Map<String, dynamic>>, String) loggedIn;
  final List<Map<String, dynamic>> mypokemons;
  final String username;

  const CaptureScreen({super.key, required this.loggedIn, required this.mypokemons, required this.isLoggedIn, required this.username});

  @override
  CaptureScreenState createState() => CaptureScreenState();
}

class CaptureScreenState extends State<CaptureScreen> {
  final _guessController = TextEditingController();
  late Pokemon randomPokemon;
  bool _isCorrect = false;
  String _message = '';

  final PokemonData pokemonData = PokemonData();
  List<Pokemon> pokemonList= [];
  @override
  void initState() {
    super.initState();
    _loadPokemonData();
  }
  Future<void> _loadPokemonData() async {
    await pokemonData.loadPokemonData();
    setState(() {
      pokemonList = pokemonData.pokemonList;
      _generateRandomPokemon();
    });
  }

  // Generate a random Pokémon to guess
  void _generateRandomPokemon() {
    randomPokemon = pokemonList[Random().nextInt(pokemonList.length)];
  }

  // Check if the guess is correct
  void _checkGuess() {
    if (_guessController.text.trim().toLowerCase() == randomPokemon.name['english']?.toLowerCase()) {
      setState(() {
        _isCorrect = true;
        _message = 'Correct! You captured ${randomPokemon.name['english']}!';
        _addPokemonToCollection();
      });
    } else {
      setState(() {
        _message = 'Oops! That\'s not correct. Try again!';
      });
    }
  }

  void _addPokemonToCollection() async {
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    Map<String, dynamic> users = usersJson != null ? Map<String, dynamic>.from(jsonDecode(usersJson)) : {};
    // users[username] = {'password': password, 'name': name, 'pokemon': mypokemons};
    // mypokemons = [{'pokemon': randomPokemon.toJson(), 'quantity': 1,}]
    bool pokemonExists = false;

    for (var dictionary in widget.mypokemons) {
      if (dictionary['pokemon']['name']['english'] == randomPokemon.name['english']) {
        pokemonExists = true;
        dictionary['quantity'] += 1;
        break;
      }
    }
    if (!pokemonExists){
      widget.mypokemons.add({'pokemon': randomPokemon.toJson(), 'quantity': 1});
    }
    setState(() {
      users[widget.username]['pokemon']=widget.mypokemons;
      prefs.setString('users', jsonEncode(users));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Pokémon')),
      body: widget.isLoggedIn ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Guess the Pokémon!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Image.network(
              randomPokemon.getImageUrl('hires') ?? 'https://via.placeholder.com/150',
              height: 200,
              width: 200,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _guessController,
              decoration: InputDecoration(
                hintText: 'Enter Pokémon name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkGuess,
              child: const Text('Guess'),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 18, color: _isCorrect ? Colors.green : Colors.red),
            ),
            const SizedBox(height: 20),
            if (_isCorrect)
              ElevatedButton(
                onPressed: () {setState(() {
                  _isCorrect = false;
                  _message = '';
                  _guessController.clear(); // Clear the input field
                  _generateRandomPokemon(); // Generate a new random Pokémon
                  });
                },
                child: const Text('Guess again'),
              ),
          ],
        ) : const Center(child: Text("Please log in to trade.", style: TextStyle(fontSize: 18)))
      );
  }
}