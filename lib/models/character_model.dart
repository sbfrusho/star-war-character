
class Character {
  final String name;
  final String? height; // Nullable
  final String? mass;   // Nullable
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? gender;
  final String? homeworld;
  final int id;
  final List<String>? films;
  
  Character({
    required this.name,
    this.height,
    this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.gender,
    this.homeworld,
    this.films,
    required this.id,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: int.parse(json['url'].split('/').reversed.skip(1).first), 
      name: json['name'] ?? 'Unknown',
      height: json['height']?.toString() ?? 'N/A', 
      mass: json['mass']?.toString() ?? 'N/A',
      hairColor: json['hair_color'] ?? 'Unknown',
      skinColor: json['skin_color'] ?? 'Unknown',
      eyeColor: json['eye_color'] ?? 'Unknown',
      birthYear: json['birth_year'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      homeworld: json['homeworld'] ?? 'Unknown',
      films: (json['films'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
