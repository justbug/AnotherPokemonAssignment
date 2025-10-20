import 'package:flutter_another_pokemon_assignment/models/local_pokemon.dart';
import 'package:flutter_another_pokemon_assignment/models/models.dart';
import 'package:flutter_another_pokemon_assignment/services/local_pokemon_service_spec.dart';

class TestLocalPokemonFactory {
  static List<LocalPokemon> createLocalPokemonList(
    int count, {
    int startId = 1,
  }) {
    final now = DateTime.now().millisecondsSinceEpoch;
    return List.generate(
      count,
      (index) => LocalPokemon(
        id: '${startId + index}',
        name: 'pokemon-${startId + index}',
        imageURL:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${startId + index}.png',
        isFavorite: true,
        created: now + index * 1000, // 1 second interval between each Pokemon
      ),
    );
  }

  static List<Pokemon> createPokemonList(
    int count, {
    int startId = 1,
    bool isFavorite = false,
  }) {
    return List.generate(
      count,
      (index) => Pokemon(
        name: 'pokemon-${startId + index}',
        id: '${startId + index}',
        imageURL:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${startId + index}.png',
        isFavorite: isFavorite,
      ),
    );
  }
}

class InMemoryLocalPokemonService implements LocalPokemonServiceSpec {
  final Map<String, LocalPokemon> _storage = <String, LocalPokemon>{};

  @override
  Future<void> insertOrUpdate(LocalPokemon pokemon) async {
    _storage[pokemon.id] = pokemon;
  }

  @override
  Future<void> delete(String id) async {
    _storage.remove(id);
  }

  @override
  Future<LocalPokemon?> getById(String id) async {
    return _storage[id];
  }

  @override
  Future<List<LocalPokemon>> getAll() async {
    return _storage.values.toList(growable: false);
  }

  @override
  Future<void> clear() async {
    _storage.clear();
  }
}
