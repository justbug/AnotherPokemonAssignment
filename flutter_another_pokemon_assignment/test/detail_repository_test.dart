import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/repository/detail_repository.dart';
import 'package:flutter_another_pokemon_assignment/services/detail_service.dart';
import 'package:flutter_another_pokemon_assignment/models/models.dart';

import 'detail_repository_test.mocks.dart';

@GenerateMocks([DetailService])
void main() {
  group('DetailRepository Tests', () {
    late MockDetailService mockDetailService;
    late DetailRepository detailRepository;

    setUp(() {
      mockDetailService = MockDetailService();
      detailRepository = DetailRepository(detailService: mockDetailService);
    });

    group('Pokemon Detail Fetching', () {
      test('should fetch Pokemon detail successfully', () async {
        // Arrange
        const testId = '25';
        final mockDetailEntity = DetailEntity(
          id: 25,
          weight: 60,
          height: 4,
          types: [
            TypesEntity(type: TypeEntity(name: 'electric')),
          ],
          sprites: SpriteEntity(
            frontDefault: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
          ),
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'pikachu');

        // Assert
        expect(pokemonDetail.id, equals('25'));
        expect(pokemonDetail.name, equals('pikachu'));
        expect(pokemonDetail.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.id, equals(25));
        expect(pokemonDetail.detail!.weight, equals(60));
        expect(pokemonDetail.detail!.height, equals(4));
        expect(pokemonDetail.detail!.types, equals(['electric']));
        
        verify(mockDetailService.fetchDetail(testId)).called(1);
      });

      test('should handle Pokemon with multiple types', () async {
        // Arrange
        const testId = '1';
        final mockDetailEntity = DetailEntity(
          id: 1,
          weight: 69,
          height: 7,
          types: [
            TypesEntity(type: TypeEntity(name: 'grass')),
            TypesEntity(type: TypeEntity(name: 'poison')),
          ],
          sprites: SpriteEntity(
            frontDefault: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          ),
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'bulbasaur');

        // Assert
        expect(pokemonDetail.id, equals('1'));
        expect(pokemonDetail.name, equals('bulbasaur'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.types, equals(['grass', 'poison']));
        expect(pokemonDetail.detail!.types.length, equals(2));
      });

      test('should handle Pokemon without sprites', () async {
        // Arrange
        const testId = '999';
        final mockDetailEntity = DetailEntity(
          id: 999,
          weight: 100,
          height: 5,
          types: [
            TypesEntity(type: TypeEntity(name: 'unknown')),
          ],
          sprites: null,
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'unknown');

        // Assert
        expect(pokemonDetail.id, equals('999'));
        expect(pokemonDetail.name, equals('unknown'));
        expect(pokemonDetail.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/999.png'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.types, equals(['unknown']));
      });

      test('should handle Pokemon with empty types list', () async {
        // Arrange
        const testId = '0';
        final mockDetailEntity = DetailEntity(
          id: 0,
          weight: 0,
          height: 0,
          types: [],
          sprites: SpriteEntity(frontDefault: null),
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'empty');

        // Assert
        expect(pokemonDetail.id, equals('0'));
        expect(pokemonDetail.name, equals('empty'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.types, isEmpty);
        expect(pokemonDetail.imageURL, equals('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/0.png'));
      });
    });

    group('Error Handling', () {
      test('should rethrow service errors', () async {
        // Arrange
        const testId = 'invalid';
        when(mockDetailService.fetchDetail(testId))
            .thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => detailRepository.fetchDetail(testId, 'test'),
          throwsException,
        );
        
        verify(mockDetailService.fetchDetail(testId)).called(1);
      });

      test('should rethrow network errors', () async {
        // Arrange
        const testId = '25';
        when(mockDetailService.fetchDetail(testId))
            .thenThrow(Exception('Network error'));

        // Act & Assert
        expect(
          () => detailRepository.fetchDetail(testId, 'test'),
          throwsException,
        );
      });
    });

    group('Model Mapping', () {
      test('should correctly map all entity fields to model', () async {
        // Arrange
        const testId = '150';
        final mockDetailEntity = DetailEntity(
          id: 150,
          weight: 1220,
          height: 20,
          types: [
            TypesEntity(type: TypeEntity(name: 'psychic')),
          ],
          sprites: SpriteEntity(
            frontDefault: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png',
          ),
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'mewtwo');

        // Assert
        expect(pokemonDetail.id, equals('150'));
        expect(pokemonDetail.name, equals('mewtwo'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.id, equals(mockDetailEntity.id));
        expect(pokemonDetail.detail!.weight, equals(mockDetailEntity.weight));
        expect(pokemonDetail.detail!.height, equals(mockDetailEntity.height));
        expect(pokemonDetail.detail!.types, equals(['psychic']));
        expect(pokemonDetail.imageURL, equals(mockDetailEntity.sprites?.frontDefault));
      });

      test('should handle complex type names correctly', () async {
        // Arrange
        const testId = '1';
        final mockDetailEntity = DetailEntity(
          id: 1,
          weight: 69,
          height: 7,
          types: [
            TypesEntity(type: TypeEntity(name: 'grass')),
            TypesEntity(type: TypeEntity(name: 'poison')),
            TypesEntity(type: TypeEntity(name: 'flying')),
          ],
          sprites: SpriteEntity(
            frontDefault: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          ),
        );

        when(mockDetailService.fetchDetail(testId))
            .thenAnswer((_) async => mockDetailEntity);

        // Act
        final pokemonDetail = await detailRepository.fetchDetail(testId, 'complex');

        // Assert
        expect(pokemonDetail.name, equals('complex'));
        expect(pokemonDetail.detail, isNotNull);
        expect(pokemonDetail.detail!.types, equals(['grass', 'poison', 'flying']));
        expect(pokemonDetail.detail!.types.length, equals(3));
      });
    });
  });
}
