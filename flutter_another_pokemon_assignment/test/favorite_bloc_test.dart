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

    test('Initial state should be FavoriteInitial with empty favorite set', () {
      expect(favoriteBloc.state, isA<FavoriteInitial>());
      expect((favoriteBloc.state as FavoriteInitial).favoritePokemonIds, isEmpty);
    });




    blocTest<FavoriteBloc, FavoriteState>(
      'Clicking favorite button should toggle state and save to Repository',
      build: () {
        when(mockFavoriteRepository.updateFavorite('1', true, 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        FavoriteSuccess(
          favoritePokemonIds: {'1'},
          toggledPokemonFavoriteStatus: true,
          currentPokemonId: '1',
        ),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.updateFavorite('1', true, 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'When Pokemon is already favorite, clicking should remove favorite state',
      build: () {
        when(mockFavoriteRepository.updateFavorite('1', false, 'Pikachu', 'https://example.com/pikachu.png')).thenAnswer((_) async {});
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      seed: () => FavoriteSuccess(
        favoritePokemonIds: {'1'},
        toggledPokemonFavoriteStatus: true,
        currentPokemonId: '1',
      ),
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        FavoriteSuccess(
          favoritePokemonIds: const <String>{},
          toggledPokemonFavoriteStatus: false,
          currentPokemonId: '1',
        ),
      ],
      verify: (_) {
        verify(mockFavoriteRepository.updateFavorite('1', false, 'Pikachu', 'https://example.com/pikachu.png')).called(1);
      },
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'When Repository operation fails, should show error state',
      build: () {
        when(mockFavoriteRepository.updateFavorite('1', true, 'Pikachu', 'https://example.com/pikachu.png'))
            .thenThrow(Exception('Repository error'));
        return FavoriteBloc(
          favoriteRepository: mockFavoriteRepository,
        );
      },
      act: (bloc) => bloc.add(const FavoriteToggled(pokemonId: '1', pokemonName: 'Pikachu', imageURL: 'https://example.com/pikachu.png')),
      expect: () => [
        isA<FavoriteError>()
            .having((s) => s.message, 'message', contains('Repository error'))
            .having((s) => s.favoritePokemonIds, 'favoritePokemonIds', isEmpty)
            .having((s) => s.currentPokemonId, 'currentPokemonId', '1'),
      ],
    );
  });
}
