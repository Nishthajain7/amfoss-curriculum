import 'package:flutter/material.dart';
import 'package:pokodex/trade.dart';
import 'pokemon_list.dart';
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
  bool _isLoggedIn =false;
  String _name = '';

  void _loggedIn(bool loggedIn, [String name = '']) {
    setState(() {_isLoggedIn = loggedIn;
    if (loggedIn && name.isNotEmpty) {
        _name = name;
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
    TradeScreen(isLoggedIn: _isLoggedIn, loggedIn: _loggedIn, name: _name,),
    Center(child: Text('Capture Page')),
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
