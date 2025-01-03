class Pokemon {
  final int id;
  final Map<String, String> name;
  final List<String> type;
  final Base base;
  final String species;
  final String description;
  final Profile profile;
  final Map<String, String> image;

  String? getImageUrl(String size) {
      return image[size] ?? 'https://via.placeholder.com/150';
  }

  Pokemon({
    required this.id,
    required this.name,
    required this.type,
    required this.base,
    required this.species,
    required this.description,
    required this.profile,
    required this.image,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] ?? '0',
      name: Map<String, String>.from(json['name']),
      type: List<String>.from(json['type']),
      base: json['base'] != null ? Base.fromJson(json['base']) : Base(hp: 0, attack: 0, defense: 0, spAttack: 0, spDefense: 0, speed: 0),
      species: json['species'],
      description: json['description'],
      profile: Profile.fromJson(json['profile']),
      image: Map<String, String>.from(json['image']),
    );
  }
}

class Profile {
  final String height;
  final String weight;
  final List<String> egg;
  final List<List<dynamic>> ability;
  final String gender;

  Profile({
    required this.height,
    required this.weight,
    required this.egg,
    required this.ability,
    required this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      height: json['height'],
      weight: json['weight'],
      egg: json['egg'] != null ? List<String>.from(json['egg']) : [],
      ability: List<List<dynamic>>.from(json['ability'].map((item) => List<dynamic>.from(item))),
      gender: json['gender'],
    );
  }
}

class Base {
  final int hp;
  final int attack;
  final int defense;
  final int spAttack;
  final int spDefense;
  final int speed;

  Base({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.spAttack,
    required this.spDefense,
    required this.speed,
  });

  factory Base.fromJson(Map<String, dynamic> json) {
    return Base(
      hp: json['HP'],
      attack: json['Attack'],
      defense: json['Defense'],
      spAttack: json['Sp. Attack'],
      spDefense: json['Sp. Defense'],
      speed: json['Speed']
    );
  }
}

