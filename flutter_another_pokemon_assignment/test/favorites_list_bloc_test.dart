import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/favorites_list/favorites_list_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorites_list/favorites_list_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/favorites_list/favorites_list_state.dart';
import 'package:flutter_another_pokemon_assignment/repository/favorite_pokemon_repository.dart';

import 'helpers/test_helpers.dart';
import 'favorites_list_bloc_test.mocks.dart';

@GenerateMocks([FavoritePokemonRepository])
void main() {
  group('FavoritesListBloc', () {
    late MockFavoritePokemonRepository mockRepository;

    setUp(() {
      mockRepository = MockFavoritePokemonRepository();
    });

    test('has initial state', () {
      final bloc = FavoritesListBloc(favoriteRepository: mockRepository);
      expect(bloc.state, const FavoritesListInitial());
    });

    group('FavoritesListLoadRequested', () {
      blocTest<FavoritesListBloc, FavoritesListState>(
        'emits (Loading, Success) when getFavoritePokemonList succeeds',
        build: () {
          final favoritePokemons = TestLocalPokemonFactory.createLocalPokemonList(3);
          when(mockRepository.getFavoritePokemonList())
              .thenAnswer((_) async => favoritePokemons);
          return FavoritesListBloc(favoriteRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const FavoritesListLoadRequested()),
        expect: () => [
          const FavoritesListLoading(),
          isA<FavoritesListSuccess>()
              .having((s) => s.favoritePokemons.length, 'favoritePokemons length', 3)
              .having((s) => s.favoritePokemons.first.id, 'first pokemon id', '1')
              .having((s) => s.favoritePokemons.first.name, 'first pokemon name', 'pokemon-1'),
        ],
        verify: (_) {
          verify(mockRepository.getFavoritePokemonList()).called(1);
        },
      );

      blocTest<FavoritesListBloc, FavoritesListState>(
        'emits (Loading, Error) when getFavoritePokemonList fails',
        build: () {
          when(mockRepository.getFavoritePokemonList())
              .thenThrow(Exception('Network error'));
          return FavoritesListBloc(favoriteRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const FavoritesListLoadRequested()),
        expect: () => [
          const FavoritesListLoading(),
          isA<FavoritesListError>()
              .having((s) => s.message, 'message', 'Failed to load favorites list: Exception: Network error')
              .having((s) => s.previousFavoritePokemons, 'previousFavoritePokemons', isEmpty),
        ],
        verify: (_) {
          verify(mockRepository.getFavoritePokemonList()).called(1);
        },
      );
    });

    group('FavoritesListRefreshRequested', () {
      blocTest<FavoritesListBloc, FavoritesListState>(
        'emits Success when refresh succeeds without previous data',
        build: () {
          final favoritePokemons = TestLocalPokemonFactory.createLocalPokemonList(2);
          when(mockRepository.getFavoritePokemonList())
              .thenAnswer((_) async => favoritePokemons);
          return FavoritesListBloc(favoriteRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const FavoritesListRefreshRequested()),
        expect: () => [
          isA<FavoritesListSuccess>()
              .having((s) => s.favoritePokemons.length, 'favoritePokemons length', 2)
              .having((s) => s.favoritePokemons.first.id, 'first pokemon id', '1'),
        ],
        verify: (_) {
          verify(mockRepository.getFavoritePokemonList()).called(1);
        },
      );

      blocTest<FavoritesListBloc, FavoritesListState>(
        'emits Error when refresh fails without previous data',
        build: () {
          when(mockRepository.getFavoritePokemonList())
              .thenThrow(Exception('Refresh error'));
          return FavoritesListBloc(favoriteRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const FavoritesListRefreshRequested()),
        expect: () => [
          isA<FavoritesListError>()
              .having((s) => s.message, 'message', 'Failed to refresh favorites list: Exception: Refresh error')
              .having((s) => s.previousFavoritePokemons, 'previousFavoritePokemons', isEmpty),
        ],
        verify: (_) {
          verify(mockRepository.getFavoritePokemonList()).called(1);
        },
      );

      final existingFavoritePokemons = TestLocalPokemonFactory.createLocalPokemonList(3);
      blocTest<FavoritesListBloc, FavoritesListState>(
        'emits Error with previous data when refresh fails after success',
        build: () {
          when(mockRepository.getFavoritePokemonList())
              .thenThrow(Exception('Refresh error'));
          return FavoritesListBloc(favoriteRepository: mockRepository);
        },
        seed: () => FavoritesListSuccess(
          favoritePokemons: existingFavoritePokemons,
        ),
        act: (bloc) => bloc.add(const FavoritesListRefreshRequested()),
        expect: () => [
          isA<FavoritesListError>()
              .having(
                (s) => s.message,
                'message',
                'Failed to refresh favorites list: Exception: Refresh error',
              )
              .having(
                (s) => s.previousFavoritePokemons,
                'previousFavoritePokemons',
                equals(existingFavoritePokemons),
              ),
        ],
        verify: (_) {
          verify(mockRepository.getFavoritePokemonList()).called(1);
        },
      );
    });
  });
}
