import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'topbar.dart';
import 'details.dart';
import 'pokemon.dart';

class TradeScreen extends StatefulWidget {
  final bool isLoggedIn;
  final Function(bool, String, List<Map<String, dynamic>>, String) loggedIn;
  final String username;
  final String name;
  final List<Map<String, dynamic>> mypokemons;
  const TradeScreen(
      {super.key,
      required this.isLoggedIn,
      required this.loggedIn,
      required this.username,
      required this.name,
      required this.mypokemons});
  @override
  TradeScreenState createState() => TradeScreenState();
}

class TradeScreenState extends State<TradeScreen> {
  final TextEditingController _friendController = TextEditingController();
  final TextEditingController _pokemonNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  Pokemon? getPokemonByName(String name) {
  for (var dictionary in widget.mypokemons) {
    if (dictionary['pokemon']['name']['english'] == name) {
      return Pokemon.fromJson(dictionary['pokemon']);
    }
  } return null;
}
  void _sendpokemon() async{
    final friendName = _friendController.text.trim();
    final pokemonName = _pokemonNameController.text;
    final prefs = await SharedPreferences.getInstance();
    String? usersJson = prefs.getString('users');
    Map<String, dynamic> users = usersJson != null ? Map<String, dynamic>.from(jsonDecode(usersJson)) : {};
    List<Map<String, dynamic>> friendPokemons = List<Map<String, dynamic>>.from(users[friendName]['pokemon'] ?? []);
    Pokemon? sentPokemon = getPokemonByName(pokemonName);

    if (sentPokemon != null) {
      bool pokemonExistsForFriend = false;

      // add pokemon to into friend's account
      for (var dictionary in friendPokemons) {
        if (dictionary['pokemon']['name']['english'] == pokemonName) {
          pokemonExistsForFriend = true;
          dictionary['quantity'] += 1;
          break;
        }  
      }
      if (!pokemonExistsForFriend){
        friendPokemons.add({'pokemon': sentPokemon.toJson(), 'quantity': 1,});
      }

      // send pokemon from my account
      setState(() {
      for (var dictionary in widget.mypokemons) {
        if (dictionary['pokemon']['name']['english'] == pokemonName) {
          if (dictionary['quantity'] == 1) {
            widget.mypokemons.remove(dictionary);
          } else {
            dictionary['quantity'] -= 1;
          }
          break;
        }
      }
    });

      users[friendName]['pokemon'] = friendPokemons;
      users[widget.username]['pokemon'] = widget.mypokemons;
      await prefs.setString('users', jsonEncode(users));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$pokemonName sent to $friendName')));

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You do not own $pokemonName')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokodex',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: TopBar(isLoggedIn: widget.isLoggedIn, loggedIn: widget.loggedIn),
        body: widget.isLoggedIn? 
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: const EdgeInsets.only(left: 30.0), child: Text("Hello ${widget.name}! These are the Pokémon you own",style: const TextStyle(fontSize: 18))),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true, // takes only as much space as required
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: widget.mypokemons.length,
                itemBuilder: (context, index) {
                  final pokemonData = widget.mypokemons[index];
                  final pokemon = Pokemon.fromJson(pokemonData['pokemon']);
                  final quantity = pokemonData['quantity'];
                  final img = Image.network(pokemon.getImageUrl("thumbnail") ?? 'https://via.placeholder.com/150',);
                          
                  return GestureDetector(
                    onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) =>PokemonDetailsScreen(pokemon: pokemon)));},
                    child: Center(
                      child: Card(
                        color: Color(0xFF141218),
                        child: Padding(padding: const EdgeInsets.all(16.0),
                          child: Column(children: [
                            img,
                            Text(pokemon.name['english'] ?? 'Name unknown', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            Text('Quantity: $quantity', style: const TextStyle(fontSize: 14,color: Colors.white))
                          ]),
                        ),
                      ),
                    ),
                  );
                },
              ),                     
              const SizedBox(height: 8),

              Form(
                  key: _formKey,
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(children: [
                      Expanded(
                        child: TextFormField(
                          controller: _pokemonNameController,
                          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Pokémon Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Pokémon name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Center(child: Text("   to   ", style: const TextStyle(fontSize: 18))),
                      Expanded(
                        child: TextFormField(
                          controller: _friendController,
                          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Friend\'s Username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a username';
                              }
                            return null;
                          },
                        ),
                      ),
                      Padding(padding: const EdgeInsets.only(left: 16.0),
                        child: ElevatedButton(
                          onPressed: _sendpokemon,
                          child: const Text('Send'),
                        )
                      )
                    ],
                  )
                )
              )
            ],
          ) : const Center(child: Text("Please log in to trade.", style: TextStyle(fontSize: 18)))
      )
    );
  }
}
