import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_another_pokemon_assignment/repository/list_repository.dart';
import 'package:flutter_another_pokemon_assignment/services/core/pokemon_service.dart';

import 'list_repository_test.mocks.dart';

@GenerateMocks([PokemonService])
void main() {
  group('ListRepository Tests', () {
    late MockPokemonService mockPokemonService;
    late ListRepository listRepository;

    setUp(() {
      mockPokemonService = MockPokemonService();
      listRepository = ListRepository(pokemonService: mockPokemonService);
    });

    group('Pokemon Creation and imageURL Validation', () {
      test('should create Pokemon with correct imageURL format for ID 1', () async {
        // Arrange
        const testId = '1';
        const testName = 'bulbasaur';
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "$testName",
              "url": "https://pokeapi.co/api/v2/pokemon/$testId/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(1));
        final pokemon = pokemons.first;
        expect(pokemon.name, equals(testName));
        expect(pokemon.id, equals(testId));
        expect(pokemon.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$testId.png'));
      });

      test('should create Pokemon with correct imageURL format for ID 25', () async {
        // Arrange
        const testId = '25';
        const testName = 'pikachu';
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "$testName",
              "url": "https://pokeapi.co/api/v2/pokemon/$testId/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(1));
        final pokemon = pokemons.first;
        expect(pokemon.name, equals(testName));
        expect(pokemon.id, equals(testId));
        expect(pokemon.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$testId.png'));
      });

      test('should create Pokemon with correct imageURL format for ID 150', () async {
        // Arrange
        const testId = '150';
        const testName = 'mewtwo';
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "$testName",
              "url": "https://pokeapi.co/api/v2/pokemon/$testId/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(1));
        final pokemon = pokemons.first;
        expect(pokemon.name, equals(testName));
        expect(pokemon.id, equals(testId));
        expect(pokemon.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$testId.png'));
      });

      test('should create multiple Pokemon with correct imageURLs', () async {
        // Arrange
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            },
            {
              "name": "ivysaur",
              "url": "https://pokeapi.co/api/v2/pokemon/2/"
            },
            {
              "name": "venusaur",
              "url": "https://pokeapi.co/api/v2/pokemon/3/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(3));
        
        // 驗證第一個 Pokemon
        expect(pokemons[0].name, equals('bulbasaur'));
        expect(pokemons[0].id, equals('1'));
        expect(pokemons[0].imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png'));
        
        // 驗證第二個 Pokemon
        expect(pokemons[1].name, equals('ivysaur'));
        expect(pokemons[1].id, equals('2'));
        expect(pokemons[1].imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png'));
        
        // 驗證第三個 Pokemon
        expect(pokemons[2].name, equals('venusaur'));
        expect(pokemons[2].id, equals('3'));
        expect(pokemons[2].imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png'));
      });
    });

    group('URL Parsing Tests', () {
      test('should handle URL without trailing slash', () async {
        // Arrange
        const testId = '25';
        const testName = 'pikachu';
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "$testName",
              "url": "https://pokeapi.co/api/v2/pokemon/$testId"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(1));
        final pokemon = pokemons.first;
        expect(pokemon.id, equals(testId));
        expect(pokemon.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$testId.png'));
      });

      test('should filter out Pokemon with invalid URLs', () async {
        // Arrange
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "valid-pokemon",
              "url": "https://pokeapi.co/api/v2/pokemon/25/"
            },
            {
              "name": "invalid-pokemon",
              "url": "https://pokeapi.co/api/v2/pokemon/invalid/"
            },
            {
              "name": "another-valid-pokemon",
              "url": "https://pokeapi.co/api/v2/pokemon/150/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(2)); // 只有有效的 Pokemon 被包含
        expect(pokemons[0].name, equals('valid-pokemon'));
        expect(pokemons[1].name, equals('another-valid-pokemon'));
      });
    });

    group('imageURL Format Validation', () {
      test('should generate imageURL with correct base URL', () async {
        // Arrange
        const testId = '999';
        const testName = 'test-pokemon';
        final mockResponse = http.Response('''
        {
          "count": 1302,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=30&limit=30",
          "previous": null,
          "results": [
            {
              "name": "$testName",
              "url": "https://pokeapi.co/api/v2/pokemon/$testId/"
            }
          ]
        }
        ''', 200);

        when(mockPokemonService.fetch(any, query: anyNamed('query')))
            .thenAnswer((_) async => mockResponse);

        // Act
        final pokemons = await listRepository.fetchList(offset: 0);

        // Assert
        expect(pokemons, hasLength(1));
        final pokemon = pokemons.first;
        
        // 驗證 imageURL 格式
        expect(pokemon.imageURL, startsWith('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/'));
        expect(pokemon.imageURL, endsWith('.png'));
        expect(pokemon.imageURL, contains(testId));
        
        // 驗證完整的 URL 格式
        expect(pokemon.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$testId.png'));
      });
    });
  });
}
