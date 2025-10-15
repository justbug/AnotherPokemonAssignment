import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorite/favorite_state.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoritePokemonRepository])
void main() {
  group('FavoriteBloc', () {
    late MockFavoritePokemonRepository mockFavoriteRepository;
    late FavoriteBloc favoriteBloc;

    setUp(() {
      mockFavoriteRepository = MockFavoritePokemonRepository();
      favoriteBloc = FavoriteBloc(
        favoriteRepository: mockFavoriteRepository,
      );
    });

    tearDown(() {
      favoriteBloc.close();
    });

    test('Initial state should be FavoriteSuccess with empty favoriteStatus', () {
      expect(favoriteBloc.state, isA<FavoriteSuccess>());
      expect((favoriteBloc.state as FavoriteSuccess).favoriteStatus, isEmpty);
    });

    blocTest<FavoriteBloc, FavoriteState>(
      'When loading all favorite states, should correctly load all states',
      build: () {
        when(mockFavoriteRepository.getAllFavoriteStatus()).thenAnswer((_) async => {
          '1': false,
          '2': true,
          '3': false,
        });
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteLoadAllRequested()),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': false, '2': true, '3': false}),
      ],
    );



    blocTest<FavoriteBloc, FavoriteState>(
      'Clicking favorite button should toggle state and save to Repository',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': true}),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'When Pokemon is already favorite, clicking should remove favorite state',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      seed: () => const FavoriteSuccess(favoriteStatus: {'1': true}),
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        const FavoriteSuccess(favoriteStatus: {'1': false}),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'When Repository operation fails, should show error state',
      build: () {
        when(mockFavoriteRepository.toggleFavorite('1', 'Pikachu', 'https://example.com/pikachu.png'))
            .thenThrow(Exception('Repository error'));
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        isA<FavoriteError>()
            .having((s) => s.message, 'message', contains('Repository error'))
            .having((s) => s.favoriteStatus, 'favoriteStatus', isEmpty),
      ],
    );
  });
}
