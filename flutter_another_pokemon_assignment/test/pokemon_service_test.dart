import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_another_pokemon_assignment/services/services.dart';

void main() {
  group('PokemonService Tests', () {
    test('PokemonService should be singleton', () {
      final instance1 = PokemonService.instance;
      final instance2 = PokemonService.instance;
      expect(instance1, same(instance2));
    });

    test('PokemonService should be created successfully', () {
      final pokemonService = PokemonService.instance;
      expect(pokemonService, isNotNull);
    });
  });

  group('ListRepository Tests', () {
    test('ListRepository should be created successfully', () {
      final listRepository = ListRepository();
      expect(listRepository, isNotNull);
    });
  });

  group('DetailService Tests', () {
    test('DetailService should be created successfully', () {
      final detailService = DetailService();
      expect(detailService, isNotNull);
    });
  });

}