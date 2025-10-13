import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/blocs/pokemon_list/pokemon_list_bloc.dart';
import '../lib/blocs/pokemon_list/pokemon_list_event.dart';
import '../lib/blocs/pokemon_list/pokemon_list_state.dart';
import 'helpers/test_helpers.dart';

const _pageSize = 30;


void main() {
  group('PokemonListBloc', () {
    late MockListRepository mockRepository;

    setUp(() {
      mockRepository = MockListRepository();
    });

    test('has initial state', () {
      final bloc = PokemonListBloc(listRepository: mockRepository);
      expect(bloc.state, const PokemonListInitial());
    });

    group('PokemonListLoadRequested', () {
      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Loading, Success] when fetchList succeeds with full page',
        build: () {
          final pokemons = TestPokemonFactory.createPokemonList(_pageSize);
          mockRepository.queuePokemons(offset: 0, pokemons: pokemons);
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
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Loading, Success] when fetchList succeeds with partial page',
        build: () {
          final pokemons = TestPokemonFactory.createPokemonList(_pageSize ~/ 2);
          mockRepository.queuePokemons(offset: 0, pokemons: pokemons);
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
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Loading, Error] when fetchList fails',
        build: () {
          mockRepository.queueError(
            offset: 0,
            exception: Exception('Network error'),
          );
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadRequested()),
        expect: () => [
          const PokemonListLoading(),
          isA<PokemonListError>()
              .having((s) => s.previousPokemons, 'previousPokemons', null),
        ],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );
    });

    group('PokemonListRefreshRequested', () {
      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Success] when refresh succeeds',
        build: () {
          final pokemons = TestPokemonFactory.createPokemonList(_pageSize);
          mockRepository.queuePokemons(offset: 0, pokemons: pokemons);
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListRefreshRequested()),
        expect: () => [
          isA<PokemonListSuccess>()
              .having((s) => s.pokemons.length, 'pokemons length', _pageSize)
              .having((s) => s.hasMore, 'hasMore', true)
              .having((s) => s.currentOffset, 'currentOffset', _pageSize),
        ],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Error] when refresh fails without previous data',
        build: () {
          mockRepository.queueError(
            offset: 0,
            exception: Exception('Refresh error'),
          );
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListRefreshRequested()),
        expect: () => [
          isA<PokemonListError>()
              .having((s) => s.previousPokemons, 'previousPokemons', isEmpty),
        ],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );

      final existingPokemons = TestPokemonFactory.createPokemonList(_pageSize);
      blocTest<PokemonListBloc, PokemonListState>(
        'emits [Error] with previous data when refresh fails after success',
        build: () {
          mockRepository.queueError(
            offset: 0,
            exception: Exception('Refresh error'),
          );
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
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([0]));
        },
      );
    });

    group('PokemonListLoadMoreRequested', () {
      final currentPokemons = TestPokemonFactory.createPokemonList(_pageSize);
      final morePokemons = TestPokemonFactory.createPokemonList(
        _pageSize,
        startId: _pageSize + 1,
      );
      blocTest<PokemonListBloc, PokemonListState>(
        'emits [LoadingMore, Success] when load more succeeds',
        build: () {
          mockRepository.queuePokemons(offset: _pageSize, pokemons: morePokemons);
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
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([_pageSize]));
        },
      );

      final failingStatePokemons = TestPokemonFactory.createPokemonList(_pageSize);
      blocTest<PokemonListBloc, PokemonListState>(
        'emits [LoadingMore, Error] when load more fails',
        build: () {
          mockRepository.queueError(
            offset: _pageSize,
            exception: Exception('Load more error'),
          );
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
                '載入更多 Pokemon 失敗: Exception: Load more error',
              )
              .having(
                (s) => s.previousPokemons,
                'previousPokemons',
                equals(failingStatePokemons),
              ),
        ],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, equals([_pageSize]));
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'does not emit when hasMore is false',
        build: () {
          return PokemonListBloc(listRepository: mockRepository);
        },
        seed: () {
          final currentPokemons = TestPokemonFactory.createPokemonList(_pageSize ~/ 2);
          return PokemonListSuccess(
            pokemons: currentPokemons,
            hasMore: false,
            currentOffset: _pageSize,
          );
        },
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, isEmpty);
        },
      );

      blocTest<PokemonListBloc, PokemonListState>(
        'does not emit when not in Success state',
        build: () {
          return PokemonListBloc(listRepository: mockRepository);
        },
        act: (bloc) => bloc.add(const PokemonListLoadMoreRequested()),
        expect: () => [],
        verify: (bloc) {
          expect(mockRepository.requestedOffsets, isEmpty);
        },
      );
    });
  });
}
