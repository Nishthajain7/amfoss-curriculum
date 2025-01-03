import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'superhero_details.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      home: const PokemonListScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});
  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {
  List<Pokemon> pokemonList = [];
  @override
  void initState() {
    super.initState();
    _loadPokemonData();
  }

  Future<void> _loadPokemonData() async {
    final String jsonString = await rootBundle.loadString('assets/pokodex.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    setState(() {
      pokemonList = jsonData.map((item) => Pokemon.fromJson(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokodex',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Pokodex',
            ),
          ),
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 150, // Adjust column count
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
                  MaterialPageRoute(
                      builder: (context) =>
                          PokemonDetailsScreen(pokemon: pokemon)),
                );
              },
              child: Center(
                child: Card(
                  color: Color(0xFF141218),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        img,
                        Text(
                          pokemon.name['english'] ?? 'Name unknown',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.currency_exchange,
              ),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.catching_pokemon,
              ),
              label: 'Capture',
            ),
          ],
        ),
      ),
    );
  }
}
