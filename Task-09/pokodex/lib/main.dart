import 'package:flutter/material.dart';
import 'package:pokodex/trade.dart';
import 'home.dart';
import 'capture.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int _selectedIndex = 0;
  bool _isLoggedIn = false;
  String _name = '';
  String _username = '';
  List<Map<String, dynamic>> _mypokemons = [];

  void _loggedIn(bool loggedIn, String name, List<Map<String, dynamic>> mypokemons,String username) {
  setState(() {
    _isLoggedIn = loggedIn;
    if (loggedIn) {
      _name = name;
      _mypokemons = mypokemons;
      _username = username;
    }
  });

}

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
    PokemonListScreen(isLoggedIn: _isLoggedIn, loggedIn: _loggedIn),
    TradeScreen(isLoggedIn: _isLoggedIn, loggedIn: _loggedIn, name: _name, mypokemons: _mypokemons, username: _username,),
    CaptureScreen(isLoggedIn: _isLoggedIn, loggedIn: _loggedIn, mypokemons: _mypokemons, username: _username),
  ];
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.currency_exchange),
              label: 'Trade',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.catching_pokemon),
              label: 'Capture',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onTap,
        ),
      ),
    );
  }
}
