import 'package:flutter/material.dart';
import 'topbar.dart';
import 'pokemon.dart';
import 'details.dart';

class PokemonListScreen extends StatefulWidget {
  final bool isLoggedIn;
  final Function(bool, String, List<Map<String, dynamic>>, String) loggedIn;
  const PokemonListScreen({super.key, required this.isLoggedIn, required this.loggedIn});
  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {
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
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokodex',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: TopBar(isLoggedIn: widget.isLoggedIn, loggedIn: widget.loggedIn,),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10, childAspectRatio: 2 / 3,
          ),
          itemCount: pokemonList.length,
          itemBuilder: (context, index) {
            final pokemon = pokemonList[index];
            final img = Image.network(pokemon.getImageUrl("thumbnail") ?? 'https://via.placeholder.com/150',);
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PokemonDetailsScreen(pokemon: pokemon)),);
              },
              child: Center(
                child: Card(
                  color: Color(0xFF141218),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        img,
                        Text(pokemon.name['english'] ?? 'Name unknown', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}