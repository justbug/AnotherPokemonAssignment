import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_another_pokemon_assignment/blocs/pokemon_list/pokemon_list_bloc.dart';
import 'package:flutter_another_pokemon_assignment/blocs/pokemon_list/pokemon_list_event.dart';
import 'package:flutter_another_pokemon_assignment/blocs/pokemon_list/pokemon_list_state.dart';
import 'package:flutter_another_pokemon_assignment/repository/list_repository.dart';

import 'helpers/test_helpers.dart';
import 'pokemon_list_bloc_test.mocks.dart';

const _pageSize = 30;

@GenerateMocks([ListRepositorySpec])
void main() {
  group('PokemonListBloc', () {
    late MockListRepositorySpec mockRepository;

    setUp(() {
      mockRepository = MockListRepositorySpec();
    });

    test('has initial state', () {
      final bloc = PokemonListBloc(listRepository: mockRepository);
      expect(bloc.state, const PokemonListInitial());
    });

    group('PokemonListLoadRequested', () {
      blocTest<PokemonListBloc, PokemonListState>(
        'emits (Loading, Success) when fetchList succeeds with full page',
        build: () {
          final pokemons = TestLocalPokemonFactory.createPokemonList(_pageSize);
          when(mockRepository.fetchList(offset: 0))
              .thenAnswer((_) async => pokemons);
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadRequested()),
        expect: () => [
          const PokemonListLoading(),
          isA<PokemonListSuccess>()
              .having((s) => s.pokemons.length, 'pokemons length', _pageSize)
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits (Loading, Success) when fetchList succeeds with partial page',
        build: () {
          final pokemons = TestLocalPokemonFactory.createPokemonList(_pageSize ~/ 2);
          when(mockRepository.fetchList(offset: 0))
              .thenAnswer((_) async => pokemons);
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadRequested()),
        expect: () => [
          const PokemonListLoading(),
          isA<PokemonListSuccess>()
              .having((s) => s.pokemons.length, 'pokemons length', _pageSize ~/ 2)
              .having((s) => s.hasMore, 'hasMore', false)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize ~/ 2),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits (Loading, Error) when fetchList fails',
        build: () {
          when(mockRepository.fetchList(offset: 0))
              .thenThrow(Exception('Network error'));
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadRequested()),
        expect: () => [
          const PokemonListLoading(),
          isA<PokemonListError>()
              .having((s) => s.previousPokemons, 'previousPokemons', null),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );
    });

    group('PokemonListRefreshRequested', () {
      blocTest<PokemonListBloc, PokemonListState>(
        'emits Success when refresh succeeds',
        build: () {
          final pokemons = TestLocalPokemonFactory.createPokemonList(_pageSize);
          when(mockRepository.fetchList(offset: 0))
              .thenAnswer((_) async => pokemons);
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListRefreshRequested()),
        expect: () => [
          isA<PokemonListSuccess>()
              .having((s) => s.pokemons.length, 'pokemons length', _pageSize)
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits Error when refresh fails without previous data',
        build: () {
          when(mockRepository.fetchList(offset: 0))
              .thenThrow(Exception('Refresh error'));
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListRefreshRequested()),
        expect: () => [
          isA<PokemonListError>()
              .having((s) => s.previousPokemons, 'previousPokemons', isEmpty),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );

      final existingPokemons = TestLocalPokemonFactory.createPokemonList(_pageSize);
      blocTest<PokemonListBloc, PokemonListState>(
        'emits Error with previous data when refresh fails after success',
        build: () {
          when(mockRepository.fetchList(offset: 0))
              .thenThrow(Exception('Refresh error'));
          return PokemonListBloc(listRepository: mockRepository);
        },
        seed: () => PokemonListSuccess(
          pokemons: existingPokemons,
          hasMore: true,
          currentOffset: _pageSize,
        ),
        act: (bloc) => bloc.add(const PokemonListRefreshRequested()),
        expect: () => [
          isA<PokemonListError>()
              .having(
                (s) => s.previousPokemons,
                'previousPokemons',
                equals(existingPokemons),
              ),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: 0)).called(1);
        },
      );
    });

    group('PokemonListLoadMoreRequested', () {
      final currentPokemons = TestLocalPokemonFactory.createPokemonList(_pageSize);
      final morePokemons = TestLocalPokemonFactory.createPokemonList(
        _pageSize,
        startId: _pageSize + 1,
      );
      blocTest<PokemonListBloc, PokemonListState>(
        'emits (LoadingMore, Success) when load more succeeds',
        build: () {
          when(mockRepository.fetchList(offset: _pageSize))
              .thenAnswer((_) async => morePokemons);
          return PokemonListBloc(listRepository: mockRepository);
        },
        seed: () => PokemonListSuccess(
          pokemons: currentPokemons,
          hasMore: true,
          currentOffset: _pageSize,
        ),
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [
          isA<PokemonListLoadingMore>()
              .having((s) => s.pokemons, 'pokemons', equals(currentPokemons))
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize),
          isA<PokemonListSuccess>()
              .having((s) => s.pokemons.length, 'pokemons length', _pageSize * 2)
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize * 2)
              .having(
                (s) => s.pokemons.take(_pageSize).toList(),
                'existing pokemons',
                equals(currentPokemons),
              )
              .having(
                (s) => s.pokemons.skip(_pageSize).toList(),
                'new pokemons',
                equals(morePokemons),
              ),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: _pageSize)).called(1);
        },
      );

      final failingStatePokemons = TestLocalPokemonFactory.createPokemonList(_pageSize);
      blocTest<PokemonListBloc, PokemonListState>(
        'emits (LoadingMore, Error) when load more fails',
        build: () {
          when(mockRepository.fetchList(offset: _pageSize))
              .thenThrow(Exception('Load more error'));
          return PokemonListBloc(listRepository: mockRepository);
        },
        seed: () => PokemonListSuccess(
          pokemons: failingStatePokemons,
          hasMore: true,
          currentOffset: _pageSize,
        ),
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [
          isA<PokemonListLoadingMore>()
              .having((s) => s.pokemons, 'pokemons', equals(failingStatePokemons))
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize),
          isA<PokemonListError>()
              .having(
                (s) => s.message,
                'message',
                'Failed to load more Pokemon: Exception: Load more error',
              )
              .having(
                (s) => s.previousPokemons,
                'previousPokemons',
                equals(failingStatePokemons),
              ),
        ],
        verify: (_) {
          verify(mockRepository.fetchList(offset: _pageSize)).called(1);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'does not emit when hasMore is false',
        build: () {
          return PokemonListBloc(listRepository: mockRepository);
        },
        seed: () {
          final currentPokemons = TestLocalPokemonFactory.createPokemonList(_pageSize ~/ 2);
          return PokemonListSuccess(
            pokemons: currentPokemons,
            hasMore: false,
            currentOffset: _pageSize,
          );
        },
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [],
        verify: (_) {
          verifyZeroInteractions(mockRepository);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'does not emit when not in Success state',
        build: () {
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [],
        verify: (_) {
          verifyZeroInteractions(mockRepository);
        },
      );
    });
  });
}
