import 'package:flutter_another_pokemon_assignment/models/models.dart';

class TestPokemonFactory {
  static List<Pokemon> createPokemonList(int count, {int startId = 1}) {
    return List.generate(
      count,
      (index) => Pokemon(
        name: 'pokemon-${startId + index}',
        id: '${startId + index}',
        imageURL: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$startId.png',
      ),
    );
  }
}
