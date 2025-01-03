import 'package:flutter/material.dart';
import 'pokemon.dart';

class PokemonDetailsScreen extends StatelessWidget {
  final Pokemon pokemon;
  PokemonDetailsScreen({super.key, required this.pokemon});
  @override
  Widget build(BuildContext context) {
    final content = [
          Center(child: Image.network(pokemon.getImageUrl("hires") ?? 'https://via.placeholder.com/150',)),
          // const SizedBox(height: 8.0,),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('    Profile', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            SizedBox( height: 15),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: 20,),
              _buildProfileCard(Icons.height, 'Height', pokemon.profile.height, Colors.pink.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.scale, 'Weight', pokemon.profile.weight, Colors.pink.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.people_alt_outlined, 'Gender', pokemon.profile.gender, Colors.pink.shade200),
            ]),
            SizedBox( height: 15),

            Text('    Base', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            SizedBox( height: 15),

            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(width: 20,),
              _buildProfileCard(Icons.favorite, 'HP', '${pokemon.base.hp}', Colors.blue.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.flash_on, 'Attack', '${pokemon.base.attack}', Colors.blue.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.shield, 'Defense', '${pokemon.base.defense}', Colors.blue.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.whatshot, 'Sp. Attack', '${pokemon.base.spAttack}', Colors.blue.shade200),
              SizedBox(width: 20,),
              _buildProfileCard(Icons.security, 'Sp. Defense', '${pokemon.base.spDefense}', Colors.blue.shade200),              
            ]),
            SizedBox(height: 15,),

            Text('    Ability', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
            SizedBox( height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              ...pokemon.profile.ability.map<Widget>((ability) {
                bool isActive = ability[1] == 'true';
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade200, 
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isActive ? Icons.check_circle : Icons.close,
                          color: isActive ? Colors.green : Colors.red,
                        ),
                        SizedBox(height: 10),
                        Text(
                          ability[0],
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),            
            ])
      ];
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name['english'] ?? 'Name unknown'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1000) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: content,
            );
          } else {
            return SingleChildScrollView(
              child:Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: content,
            )
            );
          }
        },
      ),
    );
  }

  Widget _buildProfileCard(IconData icon, String label, String value, Color backgroundColor) {
    return Container(width: 100, height: 100, decoration: BoxDecoration(color: backgroundColor,borderRadius: BorderRadius.circular(15),),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon, color: Colors.black),
          SizedBox(height: 10),
          Text(label, style: const TextStyle(color: Colors.black)),
          Text(value,style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        ],
      ),
    );
  }
}
