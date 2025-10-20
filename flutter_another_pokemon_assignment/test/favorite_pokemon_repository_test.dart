import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';
import 'package:flutter_another_pokemon_assignment/services/local_pokemon_service_spec.dart';
import 'package:flutter_another_pokemon_assignment/models/local_pokemon.dart';

import 'favorite_pokemon_repository_test.mocks.dart';

@GenerateMocks([LocalPokemonServiceSpec])
void main() {
  group('FavoritePokemonRepository Tests', () {
    late MockLocalPokemonServiceSpec mockLocalPokemonService;
    late FavoritePokemonRepository favoritePokemonRepository;

    setUp(() {
      mockLocalPokemonService = MockLocalPokemonServiceSpec();
      favoritePokemonRepository = FavoritePokemonRepository(
        localPokemonService: mockLocalPokemonService,
      );
    });

    group('isFavorite Tests', () {
      test('should return true when Pokemon is favorite', () async {
        // Arrange
        const pokemonId = '25';
        const pokemonName = 'pikachu';
        const imageURL = 'https://example.com/pikachu.png';
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final mockPokemon = LocalPokemon(
          id: pokemonId,
          name: pokemonName,
          imageURL: imageURL,
          isFavorite: true,
          created: timestamp,
          updatedAt: timestamp,
        );

        when(
          mockLocalPokemonService.getById(pokemonId),
        ).thenAnswer((_) async => mockPokemon);

        // Act
        final result = await favoritePokemonRepository.isFavorite(pokemonId);

        // Assert
        expect(result, isTrue);
        verify(mockLocalPokemonService.getById(pokemonId)).called(1);
      });

      test('should return false when Pokemon is not favorite', () async {
        // Arrange
        const pokemonId = '25';
        const pokemonName = 'pikachu';
        const imageURL = 'https://example.com/pikachu.png';
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final mockPokemon = LocalPokemon(
          id: pokemonId,
          name: pokemonName,
          imageURL: imageURL,
          isFavorite: false,
          created: timestamp,
          updatedAt: timestamp,
        );

        when(
          mockLocalPokemonService.getById(pokemonId),
        ).thenAnswer((_) async => mockPokemon);

        // Act
        final result = await favoritePokemonRepository.isFavorite(pokemonId);

        // Assert
        expect(result, isFalse);
        verify(mockLocalPokemonService.getById(pokemonId)).called(1);
      });

      test('should return false when Pokemon does not exist', () async {
        // Arrange
        const pokemonId = '999';

        when(
          mockLocalPokemonService.getById(pokemonId),
        ).thenAnswer((_) async => null);

        // Act
        final result = await favoritePokemonRepository.isFavorite(pokemonId);

        // Assert
        expect(result, isFalse);
        verify(mockLocalPokemonService.getById(pokemonId)).called(1);
      });

      test('should return false when error occurs', () async {
        // Arrange
        const pokemonId = '25';

        when(
          mockLocalPokemonService.getById(pokemonId),
        ).thenThrow(Exception('Database error'));

        // Act
        final result = await favoritePokemonRepository.isFavorite(pokemonId);

        // Assert
        expect(result, isFalse);
        verify(mockLocalPokemonService.getById(pokemonId)).called(1);
      });
    });

    group('updateFavorite Tests', () {
      test(
        'should add Pokemon to favorites when marking as favorite',
        () async {
          // Arrange
          const pokemonId = '25';
          const pokemonName = 'pikachu';
          const imageURL = 'https://example.com/pikachu.png';

          when(
            mockLocalPokemonService.getById(pokemonId),
          ).thenAnswer((_) async => null);

          when(
            mockLocalPokemonService.insertOrUpdate(any),
          ).thenAnswer((_) async {});

          // Act
          await favoritePokemonRepository.updateFavorite(
            pokemonId,
            true,
            pokemonName,
            imageURL,
          );

          // Assert
          verify(mockLocalPokemonService.getById(pokemonId)).called(1);
          verify(mockLocalPokemonService.insertOrUpdate(any)).called(1);
          verifyNever(mockLocalPokemonService.delete(any));
        },
      );

      test(
        'should remove Pokemon from favorites when marking as not favorite',
        () async {
          // Arrange
          const pokemonId = '25';
          const pokemonName = 'pikachu';
          const imageURL = 'https://example.com/pikachu.png';
          when(
            mockLocalPokemonService.delete(pokemonId),
          ).thenAnswer((_) async {});

          // Act
          await favoritePokemonRepository.updateFavorite(
            pokemonId,
            false,
            pokemonName,
            imageURL,
          );

          // Assert
          verify(mockLocalPokemonService.delete(pokemonId)).called(1);
          verifyNever(mockLocalPokemonService.insertOrUpdate(any));
          verifyNever(mockLocalPokemonService.getById(any));
        },
      );

      test(
        'should create LocalPokemon with correct properties when adding to favorites',
        () async {
          // Arrange
          const pokemonId = '25';
          const pokemonName = 'pikachu';
          const imageURL = 'https://example.com/pikachu.png';

          when(
            mockLocalPokemonService.getById(pokemonId),
          ).thenAnswer((_) async => null);

          when(
            mockLocalPokemonService.insertOrUpdate(any),
          ).thenAnswer((_) async {});

          // Act
          await favoritePokemonRepository.updateFavorite(
            pokemonId,
            true,
            pokemonName,
            imageURL,
          );

          // Assert
          final capturedPokemon =
              verify(
                    mockLocalPokemonService.insertOrUpdate(captureAny),
                  ).captured.first
                  as LocalPokemon;
          expect(capturedPokemon.id, equals(pokemonId));
          expect(capturedPokemon.name, equals(pokemonName));
          expect(capturedPokemon.imageURL, equals(imageURL));
          expect(capturedPokemon.isFavorite, isTrue);
          expect(capturedPokemon.created, isA<int>());
          expect(capturedPokemon.created, greaterThan(0));
          expect(capturedPokemon.updatedAt, isA<int>());
          expect(
            capturedPokemon.updatedAt,
            greaterThanOrEqualTo(capturedPokemon.created),
          );
        },
      );

      test(
        'should rethrow error when service throws exception during favorite save',
        () async {
          // Arrange
          const pokemonId = '25';
          const pokemonName = 'pikachu';
          const imageURL = 'https://example.com/pikachu.png';

          when(
            mockLocalPokemonService.getById(pokemonId),
          ).thenThrow(Exception('Database error'));

          // Act & Assert
          expect(
            () => favoritePokemonRepository.updateFavorite(
              pokemonId,
              true,
              pokemonName,
              imageURL,
            ),
            throwsA(isA<Exception>()),
          );
          verify(mockLocalPokemonService.getById(pokemonId)).called(1);
        },
      );
    });

    group('getFavoritePokemonIds Tests', () {
      test('should return favorite id set for favorite Pokemon', () async {
        // Arrange
        final now = DateTime.now().millisecondsSinceEpoch;
        final mockPokemonList = [
          LocalPokemon(
            id: '1',
            name: 'bulbasaur',
            imageURL: 'https://example.com/bulbasaur.png',
            isFavorite: true,
            created: now,
            updatedAt: now,
          ),
          LocalPokemon(
            id: '25',
            name: 'pikachu',
            imageURL: 'https://example.com/pikachu.png',
            isFavorite: false,
            created: now,
            updatedAt: now,
          ),
          LocalPokemon(
            id: '150',
            name: 'mewtwo',
            imageURL: 'https://example.com/mewtwo.png',
            isFavorite: true,
            created: now,
            updatedAt: now,
          ),
        ];

        when(
          mockLocalPokemonService.getAll(),
        ).thenAnswer((_) async => mockPokemonList);

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonIds();

        // Assert
        expect(result, hasLength(2));
        expect(result.contains('1'), isTrue);
        expect(result.contains('150'), isTrue);
        expect(result.contains('25'), isFalse);
        verify(mockLocalPokemonService.getAll()).called(1);
      });

      test('should return empty set when no Pokemon exist', () async {
        // Arrange
        when(
          mockLocalPokemonService.getAll(),
        ).thenAnswer((_) async => <LocalPokemon>[]);

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonIds();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalPokemonService.getAll()).called(1);
      });

      test('should return empty set when error occurs', () async {
        // Arrange
        when(
          mockLocalPokemonService.getAll(),
        ).thenThrow(Exception('Database error'));

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonIds();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalPokemonService.getAll()).called(1);
      });
    });

    group('getFavoritePokemonList Tests', () {
      test(
        'should return only favorite Pokemon sorted by updated time',
        () async {
          // Arrange
          final now = DateTime.now();
          final mockPokemonList = [
            LocalPokemon(
              id: '25',
              name: 'pikachu',
              imageURL: 'https://example.com/pikachu.png',
              isFavorite: true,
              created: now
                  .add(const Duration(minutes: 10))
                  .millisecondsSinceEpoch,
              updatedAt: now
                  .add(const Duration(minutes: 10))
                  .millisecondsSinceEpoch,
            ),
            LocalPokemon(
              id: '1',
              name: 'bulbasaur',
              imageURL: 'https://example.com/bulbasaur.png',
              isFavorite: false, // Not favorite, should be filtered out
              created: now.millisecondsSinceEpoch,
              updatedAt: now.millisecondsSinceEpoch,
            ),
            LocalPokemon(
              id: '150',
              name: 'mewtwo',
              imageURL: 'https://example.com/mewtwo.png',
              isFavorite: true,
              created: now.millisecondsSinceEpoch, // Created earlier
              updatedAt: now.millisecondsSinceEpoch,
            ),
            LocalPokemon(
              id: '4',
              name: 'charmander',
              imageURL: 'https://example.com/charmander.png',
              isFavorite: true,
              created: now
                  .add(const Duration(minutes: 5))
                  .millisecondsSinceEpoch,
              updatedAt: now
                  .add(const Duration(minutes: 5))
                  .millisecondsSinceEpoch,
            ),
          ];

          when(
            mockLocalPokemonService.getAll(),
          ).thenAnswer((_) async => mockPokemonList);

          // Act
          final result = await favoritePokemonRepository
              .getFavoritePokemonList();

          // Assert
          expect(result, hasLength(3)); // Only 3 favorite Pokemon

          // Verify sorting: pikachu (latest) -> charmander -> mewtwo (earliest)
          expect(result[0].id, equals('25')); // pikachu (latest)
          expect(result[1].id, equals('4')); // charmander
          expect(result[2].id, equals('150')); // mewtwo (earliest)

          // Verify all are favorite Pokemon
          for (final pokemon in result) {
            expect(pokemon.isFavorite, isTrue);
          }

          verify(mockLocalPokemonService.getAll()).called(1);
        },
      );

      test('should return empty list when no Pokemon exist', () async {
        // Arrange
        when(
          mockLocalPokemonService.getAll(),
        ).thenAnswer((_) async => <LocalPokemon>[]);

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonList();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalPokemonService.getAll()).called(1);
      });

      test('should return empty list when no favorite Pokemon exist', () async {
        // Arrange
        final mockPokemonList = [
          LocalPokemon(
            id: '1',
            name: 'bulbasaur',
            imageURL: 'https://example.com/bulbasaur.png',
            isFavorite: false,
            created: DateTime.now().millisecondsSinceEpoch,
          ),
          LocalPokemon(
            id: '25',
            name: 'pikachu',
            imageURL: 'https://example.com/pikachu.png',
            isFavorite: false,
            created: DateTime.now().millisecondsSinceEpoch,
          ),
        ];

        when(
          mockLocalPokemonService.getAll(),
        ).thenAnswer((_) async => mockPokemonList);

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonList();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalPokemonService.getAll()).called(1);
      });

      test('should return empty list when error occurs', () async {
        // Arrange
        when(
          mockLocalPokemonService.getAll(),
        ).thenThrow(Exception('Database error'));

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonList();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalPokemonService.getAll()).called(1);
      });

      test('should filter out non-favorite Pokemon correctly', () async {
        // Arrange
        final now = DateTime.now();
        final mockPokemonList = [
          LocalPokemon(
            id: '1',
            name: 'bulbasaur',
            imageURL: 'https://example.com/bulbasaur.png',
            isFavorite: false,
            created: now.millisecondsSinceEpoch,
            updatedAt: now.millisecondsSinceEpoch,
          ),
          LocalPokemon(
            id: '25',
            name: 'pikachu',
            imageURL: 'https://example.com/pikachu.png',
            isFavorite: true,
            created: now.add(const Duration(minutes: 5)).millisecondsSinceEpoch,
            updatedAt: now
                .add(const Duration(minutes: 5))
                .millisecondsSinceEpoch,
          ),
          LocalPokemon(
            id: '4',
            name: 'charmander',
            imageURL: 'https://example.com/charmander.png',
            isFavorite: false,
            created: now
                .add(const Duration(minutes: 10))
                .millisecondsSinceEpoch,
            updatedAt: now
                .add(const Duration(minutes: 10))
                .millisecondsSinceEpoch,
          ),
        ];

        when(
          mockLocalPokemonService.getAll(),
        ).thenAnswer((_) async => mockPokemonList);

        // Act
        final result = await favoritePokemonRepository.getFavoritePokemonList();

        // Assert
        expect(result, hasLength(1));
        expect(result[0].id, equals('25'));
        expect(result[0].name, equals('pikachu'));
        expect(result[0].isFavorite, isTrue);
        verify(mockLocalPokemonService.getAll()).called(1);
      });
    });
  });
}
