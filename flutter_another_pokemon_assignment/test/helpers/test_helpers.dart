import 'package:flutter_another_pokemon_assignment/models/models.dart';
import 'package:flutter_another_pokemon_assignment/models/local_pokemon.dart';

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

class TestLocalPokemonFactory {
  static List<LocalPokemon> createLocalPokemonList(int count, {int startId = 1}) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      count,
      (index) => LocalPokemon(
        id: '${startId + index}',
        name: 'pokemon-${startId + index}',
        imageURL: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${startId + index}.png',
        isFavorite: true,
        created: now + index * 1000, // 每個 Pokemon 間隔 1 秒
      ),
    );
  }
}
