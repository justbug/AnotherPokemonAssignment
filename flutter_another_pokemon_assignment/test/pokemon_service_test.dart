import 'package:flutter_test/flutter_test.dart';
import '../lib/services/services.dart';

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

  group('ListService Tests', () {
    test('ListService should be created successfully', () {
      final listService = ListService();
      expect(listService, isNotNull);
    });
  });

  group('DetailService Tests', () {
    test('DetailService should be created successfully', () {
      final detailService = DetailService();
      expect(detailService, isNotNull);
    });
  });

}